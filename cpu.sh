#!/bin/bash

# Путь к файлу для записи информации
output_file="/home/ilya/Desktop/cpu_load.log"

# Очищаем файл перед записью новых данных
> "$output_file"

# Записываем 10 записей о загрузке процессора
for ((i=1; i<=10; i++)); do
    echo "$(date +"%Y-%m-%d %H:%M:%S")" >> "$output_file"
    top -n 1 -b | awk '/^%Cpu/{print $0}' >> "$output_file"

    # Ждем 1 секунду перед следующей записью
    sleep 1
done
