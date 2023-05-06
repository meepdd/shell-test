#!/bin/bash
pictures="non-existen_people"
# Проверяем установлено ли утилита для обработки json из командной строки и устанавливаем если нет
if ! command -v jq &> /dev/null; then
    echo "jq is not installed. Installing now..."
        sudo apt-get update && sudo apt-get install jq || { echo "NO"; exit 1; }
fi
# Скачиваем утилиту которая из jpg формата в гиф
if ! command -v convert &> /dev/null; then
    echo "imagemagick is not installed. Installing now..."
        sudo apt-get update && sudo apt-get install imagemagick || { echo "NO"; exit 1; }
fi

if [[ -d $pictures ]]
then 
    echo "Папка для вывода найдена, продолжаем."

else
    echo "Папка для вывода не найдена, создаем"
    mkdir -p $pictures || { echo "NO"; exit 1; }
fi

# Скачиваем 10 фотографий, которая сгенерировала нейросеть
for i in {0..9}; do
  # Получаем ответ от сервера Random User API
  response=$(curl -sS "https://randomuser.me/api/")
  
  # Из ответа забираем 10 фоток
  avatar=$(echo "$response" | jq -r '.results[0].picture.large')
  
  # Скачиваем изображения и сохраняем их
  curl -sS "$avatar" > "$pictures/$i.jpg" || { echo "NO"; exit 1; }
done
# Меняем 10 картинок в гифку 
convert -delay 100 -loop 0 $pictures/* $pictures/users.gif || { echo "NO"; }

echo "OK"
