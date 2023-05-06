#!/bin/bash

for i in {0..9}; do
  # Получаем ответ от сервера Random User API
  response=$(curl -sS -w '%{http_code}' "https://randomuser.me/api/")
  http_status=$(echo "${response: -3}")

  if [[ $http_status -eq 200 ]]; then
    # Из ответа забираем 10 фоток
    avatar=$(echo "$response" | jq -r '.results[0].picture.large')
    
    # Скачиваем изображения и сохраняем их
    if curl -sS "$avatar" > "$pictures/$i.jpg"; then
      echo "YES"
    else
      echo "NO"
    fi
  else
    echo "NO"
  fi
done
