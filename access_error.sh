#!/bin/bash

# Создаем папку, но не даём права на запись
mkdir -p non-existen_people
chmod a-rwx non-existen_people
