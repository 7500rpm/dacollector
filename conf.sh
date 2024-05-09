#!/bin/bash

# Путь к директории с конфигурационными файлами
config_dir="/etc"

# Получаем текущую дату и время
current_date=$(date +%s)

# Находим дату, которая была месяц назад
one_month_ago=$(date -d '1 month ago' +%s)

# Получаем список конфигурационных файлов с расширением .conf и с датой изменения
config_files=$(find $config_dir -type f -name '*.conf' -newermt "$(date -d '1 month ago' '+%Y-%m-%d %H:%M:%S')")

# Выводим заголовок
echo "Последние изменения конфигурационных файлов за последний месяц в директории $config_dir:"

# Проходим по каждому файлу и выводим время последнего изменения
for file in $config_files; do
    last_modified=$(stat -c %y "$file")  # Получаем время последнего изменения файла
    echo "$file: $last_modified"
done
