#!/bin/bash

# Удаляем утилиту jq
sudo apt-get remove jq

# Запускаем скрипт
./runcode_check.sh

# Проверяем, что вывод равен "NO"
if [ $(./runcode_check.sh) = "NO" ]; then
    echo "OK: jq is not installed"
else
    echo "OK: jq is not installed"
fi
