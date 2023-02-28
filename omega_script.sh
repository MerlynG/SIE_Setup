#!/bin/bash
# Set some params
IFS='/'
INDEX=-1
GREEN=$'\033[0;32m'
NC=$'\033[0m'
BL=$'\n'

# Variables
ODOO_HOST="https://raw.githubusercontent.com/Yenthe666/InstallScript/16.0/odoo_install.sh"

read -a odo <<< $ODOO_HOST
ODOO_FILE_NAME=${odo[INDEX]}

BONITA_HOST="https://sourceforge.net/projects/bonita/files/BonitaCommunity-2022.1-u0/BonitaStudioCommunity-2022.1-u0-x86_64.run"

read -a bon <<< $BONITA_HOST
BONITA_FILE_NAME=${bon[INDEX]}

# Update
echo "$BL---- System: update ----$BL"
sudo apt update
sudo apt upgrade
echo "$BL---- System: update ${GREEN}done${NC} ----$BL"

# Odoo
echo "$BL---- Odoo: installation ----$BL"
wget "${ODOO_HOST}"
chmod +x $ODOO_FILE_NAME
sed -i 's/^INSTALL_WKHTMLTOPDF=.*/INSTALL_WKHTMLTOPDF="True"/' $ODOO_FILE_NAME
sed -i 's/^GENERATE_RANDOM_PASSWORD=.*/GENERATE_RANDOM_PASSWORD="False"/' $ODOO_FILE_NAME
./$ODOO_FILE_NAME
echo "$BL---- Odoo: installation ${GREEN}done${NC} ----$BL"
sudo sed -i 's/^admin_passwd.*/admin_passwd = $1' /etc/odoo-server.conf
sudo service odoo-server restart

# Bonita
echo "$BL---- Bonita: installation ----$BL"
wget "${BONITA_HOST}"
chmod +x $BONITA_FILE_NAME
./$BONITA_FILE_NAME
echo "$BL---- Bonita: installation ${GREEN}done${NC} ----$BL"
