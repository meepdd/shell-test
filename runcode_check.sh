#!/bin/bash
pictures="non-existen_people"
# Проверяем установлено ли утилита для обработки json из командной строки и устанавливаем если нет
if ! command -v jq &> /dev/null; then
        sudo apt-get update && sudo apt-get install jq || { echo "NO"; }
fi
# Скачиваем утилиту которая из jpg формата в гиф
if ! command -v convert &> /dev/null; then
        sudo apt-get update && sudo apt-get install imagemagick || { echo "NO"; }
fi

if [[ -d $pictures ]]
then 
    continue
else
    mkdir -p $pictures || { echo "NO"; exit 1; }
fi

# Скачиваем 10 фотографий, которая сгенерировала нейросеть
for i in {0..9}; do
  # Получаем ответ от сервера Random User API
  response=$(curl -sS "https://randomuser.me/api/")
  
  # Из ответа забираем 10 фоток
  avatar=$(echo "$response" | jq -r '.results[0].picture.large')
  
  # Скачиваем изображения и сохраняем их
  curl -sS "$avatar" > "$pictures/$i.jpg" || { echo "NO"; }
done
# Меняем 10 картинок в гифку 
convert -delay 100 -loop 0 $pictures/* $pictures/users.gif || { echo "NO"; }

echo "OK"
