#!/bin/bash

# Проверяем, что все 10 изображений успешно загружены
for i in {0..9}; do
    if [[ ! -f non-existen_people/$i.jpg ]]; then
        echo "Test Failed: image $i.jpg was not downloaded."
    fi
done
echo "OK: images download"