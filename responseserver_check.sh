# Скачиваем 10 фотографий, которая сгенерировала нейросеть
for i in {0..9}; do
  # Получаем ответ от сервера Random User API
  response=$(curl -sS -w "%{http_code}" "https://randomuser.me/api/")
  
  # Проверяем код ответа HTTP
  if [[ "${response: -3}" != "200" ]]; then
    echo "NO"
    exit 1
  fi
  
  # Из ответа забираем 10 фоток
  avatar=$(echo "$response" | jq -r '.results[0].picture.large')
  
  # Скачиваем изображения и сохраняем их
  curl -sS "$avatar" > "$pictures/$i.jpg"
  
  # Проверяем, получен ли файл
  if [[ ! -s "$pictures/$i.jpg" ]]; then
    echo "NO"
    exit 1
  fi
done

# Если дошли до конца цикла, значит все файлы были получены успешно
echo "YES"
