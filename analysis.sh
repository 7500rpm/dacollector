#!/bin/bash

# Параметры
CLIENT_ID="d8f3a5a7-78f3-4df0-8756-128bebe57e69"
CLIENT_SECRET="befc3188-eb9b-495e-bf24-97eede87f7cb"
RUID=$(uuidgen)
TOKEN_URL="https://ngw.devices.sberbank.ru:9443/api/v2/oauth"
CHAT_API_URL="https://gigachat.devices.sberbank.ru/api/v1/chat/completions"
AUTH_DATA="ZDhmM2E1YTctNzhmMy00ZGYwLTg3NTYtMTI4YmViZTU3ZTY5OmJlZmMzMTg4LWViOWItNDk1ZS1iZjI0LTk3ZWVkZTg3ZjdjYg=="

# Запрос пути к файлу у пользователя
read -p "Введите путь до файла для отправки на анализ: " file_path

# Проверка существования файла
if [ ! -f "$file_path" ]; then
    echo "Ошибка: Файл не найден."
    exit 1
fi

# Получение токена доступа
response=$(curl -s -L -X POST "$TOKEN_URL" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -H "Accept: application/json" \
  -H "RqUID: $RUID" \
  -H "Authorization: Basic $AUTH_DATA" \
  --data-urlencode 'scope=GIGACHAT_API_PERS')

# Извлечение токена доступа из ответа
access_token=$(echo "$response" | jq -r '.access_token')

if [ "$access_token" == "null" ]; then
  echo "Ошибка получения токена доступа. Ответ: $response"
  exit 1
fi

# Формирование сообщения для анализа
file=$(cat "$file_path")
message="Проведи анализ данных записей на наличие подозрительной активности\n $file"

# Создание JSON запроса с помощью jq
json_request=$(jq -n \
  --arg model "GigaChat" \
  --arg role "user" \
  --arg content "$message" \
  --argjson temperature 0.2 \
  --argjson top_p 0.1 \
  --argjson n 1 \
  --argjson stream false \
  --argjson max_tokens 1024 \
  --argjson repetition_penalty 1 \
  '{
    model: $model,
    messages: [
      {
        role: $role,
        content: $content
      }
    ],
    temperature: $temperature,
    top_p: $top_p,
    n: $n,
    stream: $stream,
    max_tokens: $max_tokens,
    repetition_penalty: $repetition_penalty
  }')

# Запрос на генерацию текста
response=$(curl -s -L -X POST "$CHAT_API_URL" \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -H "Authorization: Bearer $access_token" \
  --data-raw "$json_request")

# Вывод результата
echo "Результаты анализа: "
echo "$response"
