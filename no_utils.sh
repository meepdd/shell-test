#!/bin/bash

pictures="non-existen_people"
success=true

# Проверяем установлено ли утилита для обработки json из командной строки и устанавливаем если нет
if ! command -v jq &> /dev/null; then
    echo "jq is not installed. NO"
    success=false
fi
# Скачиваем утилиту которая из jpg формата в гиф
if ! command -v convert &> /dev/null; then
    echo "imagemagick is not installed. NO"
    success=false
fi

if [[ -d $pictures ]]
then 
    echo "Папка для вывода найдена, продолжаем."
else
    echo "Папка для вывода не найдена, NO"
    success=false
fi

if [ "$success" = false ]; then
    echo "NO"
    exit 1
fi

# Скачиваем 10 фотографий, которая сгенерировала нейросеть
for i in {0..9}; do
    # Получаем ответ от сервера Random User API
    response=$(curl -sS "https://randomuser.me/api/")
  
    # Из ответа забираем 10 фоток
    avatar=$(echo "$response" | jq -r '.results[0].picture.large')
  
    # Скачиваем изображения и сохраняем их
    curl -sS "$avatar" > "$pictures/$i.jpg" || success=false
done
# Меняем 10 картинок в гифку 
convert -delay 100 -loop 0 $pictures/* $pictures/users.gif || success=false

if [ "$success" = true ]; then
    echo "YES"
else
    echo "NO"
fi
