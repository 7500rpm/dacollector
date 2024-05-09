#!/bin/bash

# Путь к файлу для записи информации
output_file="/home/ilya/Desktop/cpu_load.log"

# Очищаем файл перед записью новых данных
> "$output_file"

# Записываем 10 записей о загрузке процессора
for ((i=1; i<=10; i++)); do
    # Получаем данные о загрузке процессора за последние 10 секунд
    cpu_load=$(top -n 1 -b | awk 'NR > 7 { sum += $9; } END { print sum; }')

    # Записываем информацию в файл
    echo "$(date +"%Y-%m-%d %H:%M:%S") CPU load: $cpu_load" >> "$output_file"

    # Ждем 1 секунду перед следующей записью
    sleep 1
done
