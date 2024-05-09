#!/bin/bash

# Сканируем активные сетевые подключения с помощью утилиты netstat
netstat > /tmp/network_connections.txt

# Проверяем каждую запись в файле сетевых подключений
while IFS= read -r line; do
    # Проверяем, содержит ли текущая строка подозрительные признаки
    if echo "$line" | grep -qE 'ESTABLISHED|SYN_SENT|SYN_RECV'; then
        # Если найдены подозрительные подключения, выводим информацию в консоль
        echo "Suspicious network connection detected:"
        echo "$line"
        echo "-----------------------------------------"
    fi
done < /tmp/network_connections.txt

# Удаляем временный файл
rm /tmp/network_connections.txt

echo "Capturing network traffic:"
echo "--------------------------"
tcpdump -c 100

echo "Scanning open ports..."
open_ports=$(sudo nmap -p 1-65535 localhost | grep -E '^[0-9]+/' | awk '{print $1}')

# Выводим список открытых портов
echo "Open ports:"
echo "$open_ports"
