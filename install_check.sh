#!/bin/bash
# Проверяем, что утилита jq установлена
if ! command -v jq &> /dev/null; then
    echo "Test Failed: jq is not installed."
fi
echo "OK: jq installed."
# Проверяем, что утилита imagemagick установлена
if ! command -v convert &> /dev/null; then
    echo "Test Failed: imagemagick is not installed."
fi
echo "OK: imagemagick installed"
# Проверяем, что папка для вывода существует
if [[ ! -d non-existen_people ]]; then
    echo "Test Failed: output directory does not exist."
fi

echo "OK: output directory is exist."
