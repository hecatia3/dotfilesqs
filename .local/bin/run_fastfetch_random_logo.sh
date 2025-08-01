#!/bin/bash

# Tentukan direktori tempat logo disimpan
LOGO_DIR="$HOME/.config/fastfetch/logos"

# Periksa apakah direktori ada
if [ ! -d "$LOGO_DIR" ]; then
  fastfetch
  exit 0
fi

# Baca semua path file yang cocok ke dalam sebuah array
mapfile -d '' files < <(find "$LOGO_DIR" -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.svg" \) -print0)

# Periksa apakah ada file yang ditemukan
count="${#files[@]}"
if [ "$count" -eq 0 ]; then
  fastfetch
  exit 0
fi

# Pilih sebuah indeks acak
random_index=$((RANDOM % count))

# Dapatkan path file yang terpilih dari array
selected_file="${files[$random_index]}"

# Jalankan fastfetch dengan logo, dan PAKSA TIPE LOGO MENJADI 'chafa'
# Menaikkan resolusi logo
fastfetch --logo "$selected_file" --logo-width 48
