#!/bin/bash

# Проверяем, что гифка успешно создана
if [[ ! -f non-existen_people/users.gif ]]; then
    echo "Test Failed: users.gif was not created."
    exit 1
fi

echo "OK: users.gif created"