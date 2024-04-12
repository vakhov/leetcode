#!/bin/bash

# Проверка на количество аргументов
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <parent-folder> <sub-folder>"
    exit 1
fi

# Получение аргументов с нормализацией их имен
parent_folder=$(echo "$1" | tr ' ' '_' | tr '[:upper:]' '[:lower:]')
sub_folder=$(echo "$2" | tr ' ' '_' | tr '[:upper:]' '[:lower:]')

# Проверка и создание корневой папки
if [ ! -d "${parent_folder}" ]; then
    mkdir "${parent_folder}"
    echo "Created directory: ${parent_folder}"
else
    echo "Directory already exists: ${parent_folder}"
fi

# Проверка и создание вложенной папки и подпапок для языков программирования
for lang in php go javascript; do
    target_folder="${parent_folder}/${sub_folder}/${lang}"
    if [ ! -d "${target_folder}" ]; then
        mkdir -p "${target_folder}"
        echo "Created directory: ${target_folder}"
    else
        echo "Directory already exists: ${target_folder}"
    fi
done

# Создание файла в каждой подпапке с предопределенным содержимым, только если файл не существует
create_file_if_not_exists() {
    file_path=$1
    contents=$2
    if [ ! -f "${file_path}" ]; then
        echo "${contents}" > "${file_path}"
        echo "Created file: ${file_path}"
    else
        echo "File already exists: ${file_path}"
    fi
}

# Определение массива с информацией о файлах и шаблонах
declare -a files=(
    "go/main.go|package main"
    "java/solution.java|class HelloWorld {public static void main(String[] args) {System.out.println(\"Hello World!\");}}"
    "javascript/solution.js|console.log('Hello, World!');"
    "kotlin/solution.js|console.log('Hello, World!');"
    "php/solution.php|<?php echo 'Hello World!'; ?>"
    "python2/main.py|if __name__ == '__main__': pass"
    "python3/main.py|if __name__ == '__main__': pass"
    "ruby/solution.rb|puts 'Hello world'"
    "README.en.md|"
    "README.ru.md|"
    "SOLUTION.en.md|Let's go through the algorithm step by step:"
    "SOLUTION.ru.md|Давайте рассмотрим алгоритм на примере кода на Python и пошагово разберем его работу:"
)

# Создание вложенной папки и файлов
for item in "${files[@]}"; do
    IFS='|' read -r path content <<< "$item"
    full_path="${parent_folder}/${sub_folder}/${path}"
    mkdir -p "$(dirname "$full_path")"  # Создаем папки, если они не существуют
    if [ ! -f "$full_path" ]; then  # Проверяем, не существует ли уже файл
        echo "$content" > "$full_path"
        echo "Created file: $full_path"
    else
        echo "File already exists and was not overwritten: $full_path"
    fi
done

echo "All specified files have been processed."

# Обновление README.md
readme_path="README.md"
header="## $1"
link_text="[$2](./${parent_folder}/${sub_folder})"
description="A short description will appear here soon"

# Проверяем, содержится ли уже такой заголовок в README.md
if grep -q "$header" "$readme_path"; then
    # Если заголовок найден, добавляем ссылку и описание на новых строках в соответствующий раздел
    sed -i '' "/$header/ {
N
N
N
s|$|\n$link_text\n$description\n|
}" "$readme_path"
else
    # Если заголовок не найден, добавляем заголовок, ссылку и описание
    echo -e "\n$header\n$link_text\n$description\n" >> "$readme_path"
fi

echo "README.md updated successfully."
