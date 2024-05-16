#!/bin/bash
rm -rf /home/ilya/Desktop/logs/
mkdir /home/ilya/Desktop/logs/

# Путь к каталогу с лог-файлами
log_directory="/var/log"
users=$(ls /home)

# Путь к файлу для записи найденных строк
output_file1="/home/ilya/Desktop/logs/auth_log.txt"
output_file2="/home/ilya/Desktop/logs/error_logs.txt"
output_file3="/home/ilya/Desktop/logs/users_lastlog.txt"
output_file4="/home/ilya/Desktop/logs/apt_history.txt"
output_file5="/home/ilya/Desktop/logs/users_bash_history.txt"
output_file6="/home/ilya/Desktop/logs/root_bash_history.txt"

# Очистим файл перед началом сканирования
> "$output_file1"
> "$output_file2"
> "$output_file3"
> "$output_file4"
> "$output_file5"
> "$output_file6"
# Проходим по файлам auth.log и syslog
for logfile in "$log_directory/auth.log"; do
    # Проверяем, существует ли файл
    if [[ -f "$logfile" ]]; then
        # Ищем строки с ключевыми словами и записываем их в файл
        grep -Ei "sshd|session opened for|accepted password|new session|not in sudoers" "$logfile" >> "$output_file1"
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

last $(ls /home) >> "$output_file3"
cat /var/log/apt/history.log >> "$output_file4"


# Проходим по каждому пользователю и выводим его историю
for user in $users; do
    echo "History for user $user was collected"
    history_file="/home/$user/.bash_history"
    cat "$history_file" >> "$output_file5"
    cat /root/.bash_history >> "$output_file6"
    echo "History for root was collected"

done


echo "Logs was collected"
