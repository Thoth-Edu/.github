#!/bin/bash

# Reset
NC='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

echo -e "${BPurple}====> System Update <====${NC}"
echo -e "${Cyan}Entrez le mot de passe (\"password\")${NC}"
sudo echo
clear

# Chemin du fichier de version locale
LOCAL_VERSION_FILE="/home/debian/.scripts/version"
version=$(cat "$LOCAL_VERSION_FILE")

# Fonctions pour appliquer les mises à jour
update_1() {
    echo "Application de la version 1"
    sudo usermod -a -G root debian
    sudo chmod 770 -R /var/log/nginx/
    sudo chmod 770 -R /var/log/uwsgi/
    sudo chown -R root:root /var/log/nginx/
    sudo systemctl restart logrotate
    clear
}

#update_2() {
#    echo "Application de la version 2"
#}

#update_3() {
#    echo "Application de la version 3"
#}

# Tableau des fonctions de mise à jour
updates=("update_1") # "apply_update_2" "apply_update_3") <= SÉPARATION PAR DES ESPACES

# Appliquer les mises à jour à partir de la version actuelle
for ((i=$version; i<${#updates[@]}; i++)); do
    ${updates[$i]}
done

clear
echo -e "${BPurple}====> System Update Complete <====${NC}"

# Mettre à jour le fichier de version locale
echo ${#updates[@]} > "$LOCAL_VERSION_FILE"
