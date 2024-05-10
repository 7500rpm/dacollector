#!/bin/bash

# Путь к каталогу с лог-файлами
log_directory="/var/log"

# Путь к файлу для записи найденных строк
output_file1="/home/ilya/Desktop/auth_log.txt"
output_file2="/home/ilya/Desktop/error_logs.txt"


# Очистим файл перед началом сканирования
> "$output_file1"
> "$output_file2"

# Проходим по файлам auth.log и syslog
for logfile in "$log_directory/auth.log"; do
    # Проверяем, существует ли файл
    if [[ -f "$logfile" ]]; then
        # Ищем строки с ключевыми словами и записываем их в файл
        grep -Ei "error|failed|denied" "$logfile" >> "$output_file1"
    fi
done

# Проходим по файлам auth.log и syslog
for logfile in "$log_directory/syslog"; do
    # Проверяем, существует ли файл
    if [[ -f "$logfile" ]]; then
        # Ищем строки с ключевыми словами и записываем их в файл
        grep -Ei "error|failed|denied" "$logfile" >> "$output_file2"
    fi
done

echo "Logs with keywords have been saved to $output_file1 and $output_file2"
