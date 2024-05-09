#!/bin/bash

# Замените это значение на ваш API-ключ от VirusTotal
api_key="a666bfbbca55198f0f343f78bc4059e7f6e997731268a282e356085bc32117d1"

# URL для отправки файла на анализ
url="https://www.virustotal.com/vtapi/v2/file/scan"

# Запрос пути к файлу у пользователя
read -p "Введите путь до файла для отправки на анализ: " file_path

# Проверка существования файла
if [ ! -f "$file_path" ]; then
    echo "Ошибка: Файл не найден."
    exit 1
fi

# Отправка файла на анализ с помощью curl
response=$(curl --request POST \
  --url "$url" \
  --form apikey="$api_key" \
  --form file=@"$file_path")

# Вывод ответа от сервера
echo "$response"
echo

# Получение resource из ответа
resource=$(echo "$response" | grep -o '"resource":"[^"]*' | cut -d '"' -f 4)
scan_id=$(echo "$response" | grep -o '"scan_id":"[^"]*' | cut -d '"' -f 4)

# Получение последних 10 символов resource
last_chars=$(echo "$scan_id" | tail -c 11)
# Проверка, получен ли resource
if [ -n "$resource" ]; then
    echo "Отчет по: $file_path"
    report_url="https://www.virustotal.com/gui/file/$resource/analysis/$last_chars"
    echo "Ссылка на отчет: $report_url"
else
    echo "Не удалось получить resource из ответа."
fi

