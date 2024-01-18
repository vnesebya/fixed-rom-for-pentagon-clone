#!/bin/bash

# Проверяем, что файл существует
if [ ! -f "$1" ]; then
  echo "Файл $1 не существует."
  exit 1
fi

dir_save=$(echo $1 | cut -d "." -f 1)

echo $dir_save

#Создаем директорию сохранения
mkdir -p $dir_save

# Получаем размер файла
file_size=$(stat -c %s "$1")

# Максимальное количество блоков
max_blocks=$((file_size / 16384))

# Делаем деление файла на блоки
for ((i = 0; i <= max_blocks; i++)); do
  start=$((i * 16384))
  end=$((start + 16383))
  dd if="$1" of="$dir_save/bank${i}.rom" bs=1 count=16384 skip=$start 2>/dev/null
  # echo "Создан блок $dir_save/bank${i}"
done

# # Переходим в указанную директорию
cd "$dir_save" || exit

# Итерируемся по всем файлам в указанной директории
for file in *; do
  # Проверяем, является ли файл нулевой длины
  if [[ -f "$file" && ! -s "$file" ]]; then
    # Если файл нулевой длины, удаляем его
    rm "$file"
  fi
done

# echo "Файл успешно разделен на блоки размером 16384 байт."
cat bank2.rom bank3.rom bank0.rom bank1.rom >xpeccy.rom
mv xpeccy.rom ../
echo "Файл xpeccy.rom создан"
