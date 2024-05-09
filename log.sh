#!/bin/bash

# Путь к каталогу с лог-файлами
log_directory="/var/log"

# Путь к файлу для записи найденных строк
output_file="/home/ilya/Desktop/error_logs.txt"

# Очистим файл перед началом сканирования
> "$output_file"

# Проходим по файлам auth.log и syslog
for logfile in "$log_directory/auth.log" "$log_directory/syslog"; do
    # Проверяем, существует ли файл
    if [[ -f "$logfile" ]]; then
        # Ищем строки с ключевыми словами и записываем их в файл
        grep -Ei "error|failed|denied" "$logfile" >> "$output_file"
    fi
done

echo "Logs with keywords 'error', 'failed', 'denied', '/etc/passwd' have been saved to $output_file"
