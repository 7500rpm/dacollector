#!/bin/bash

# Запрос пути к файлу у пользователя
read -p "Введите путь до файла: " file_path

# Проверка существования файла
if [ ! -f "$file_path" ]; then
    echo "Ошибка: Файл не найден."
    exit 1
fi

# Вывод метаданных файла с помощью exiftool
exiftool "$file_path"
