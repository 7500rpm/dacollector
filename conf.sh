#!/bin/bash

# Путь к директории с конфигурационными файлами
config_dir="/etc"

# Получаем текущую дату и время в формате Unix timestamp
current_date=$(date +%s)

# Находим дату, которая была месяц назад в формате Unix timestamp
one_month_ago=$(date -d '1 month ago' +%s)

# Выводим заголовок
echo "Последние изменения конфигурационных файлов за последний месяц в директории $config_dir:"

# Проходим по каждому файлу с расширением .conf в директории /etc и проверяем его время изменения с помощью exiftool
for file in "$config_dir"/*.conf; do
    # Получаем время последнего изменения файла с помощью exiftool
    last_modified=$(exiftool -FileModifyDate -d '%Y-%m-%d %H:%M:%S' -s3 "$file")

    # Преобразуем время последнего изменения в формат Unix timestamp
    last_modified_timestamp=$(date -d "$last_modified" +%s)

    # Проверяем, был ли файл изменен в течение последнего месяца
    if ((last_modified_timestamp >= one_month_ago && last_modified_timestamp <= current_date)); then
        echo "$file: $last_modified"
    fi
done
