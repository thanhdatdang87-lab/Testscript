#!/bin/bash
echo -e "\e[1;32m[*] Dang toi uu va cai dat moi truong cho Prometheus...\e[0m"
pkg update -y && pkg upgrade -y
pkg install -y lua53 git findutils

echo -e "\e[1;32m[*] Dang tai Prometheus ve may cua ban...\e[0m"
rm -rf Testscript
git clone https://github.com/thanhdatdang87-lab/Testscript.git

cat << 'EOF' > ~/bam.sh
#!/bin/bash
if [ -z "$1" ]; then
echo -e "\e[1;31m[❌] Loi: Ban chua nhap ten file Lua! Vi du: ./bam.sh luau.lua\e[0m"
exit 1
fi
TEN_FILE="$1"
echo -e "\e[1;36m🔍 Dang lung suc file '$TEN_FILE' tren toan bo dien thoai...\e[0m"
DUONG_DAN_FILE=$(find /sdcard ~/ -type f -name "$TEN_FILE" ! -path '*/.*' 2>/dev/null | head -n 1)
if [ ! -z "$DUONG_DAN_FILE" ]; then
echo -e "\e[1;32m[🎯] Da tim thay file tai: $DUONG_DAN_FILE\e[0m"
lua ~/Testscript/prometheus-main.lua "$DUONG_DAN_FILE"
else
echo -e "\e[1;31m[❌] Khong tim thay file nao ten '$TEN_FILE'!\e[0m"
fi
EOF
chmod +x ~/bam.sh

echo -e "\e[1;34m===============================================\e[0m"
echo -e "\e[1;32m[✔] CAI DAT THANH CONG PROMETHEUS BY DAT!\e[0m"
echo -e "\e[1;33m👉 Cach xai sieu toc:\e[0m"
echo -e "\e[1;32m   ./bam.sh (ten_file).lua\e[0m"
echo -e "\e[1;34m===============================================\e[0m"
