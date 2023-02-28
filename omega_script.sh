#!/bin/bash
# Set some params
IFS='/'
INDEX=-1
GREEN='\033[0;31m'
NC='\033[0m'

# Variables
echo '\n---- File names parsing ----\n'
BONITA_HOST=https://sourceforge.net/projects/bonita/files/BonitaCommunity-2022.1-u0/BonitaStudioCommunity-2022.1-u0-x86_64.run

read -a bon <<< $BONITA_HOST
BONITA_FILE_NAME=${bon[INDEX]}

ODOO_HOST=https://raw.githubusercontent.com/Yenthe666/InstallScript/16.0/odoo_install.sh

read -a odo <<< $ODOO_HOST
ODOO_FILE_NAME=${odo[INDEX]}

# Update
echo '\n---- System: update ----\n'
sudo apt update
sudo apt upgrade
echo '\n---- System: update ${GREEN}done${NC} ----\n'

# Odoo
echo '\n---- Odoo: installation ----\n'
wget $ODOO_HOST
chmod +x $ODOO_FILE_NAME
sed -i 's/^INSTALL_WKHTMLTOPDF=.*/INSTALL_WKHTMLTOPDF="True"/' $ODOO_FILE_NAME
sed -i 's/^GENERATE_RANDOM_PASSWORD=.*/GENERATE_RANDOM_PASSWORD="False"/' $ODOO_FILE_NAME
./$ODOO_FILE_NAME
echo '\n---- Odoo: installation ${GREEN}done${NC} ----\n'
echo '\n---- Odoo: admin password change ----\n'
sudo sed -i "s/^admin_passwd.*/admin_passwd = $1" /etc/odoo-server.conf
sudo service odoo-server restart

# Bonita
echo '\n---- Bonita: installation ----\n'
wget $BONITA_HOST
chmod +x $BONITA_FILE_NAME
./$BONITA_FILE_NAME
echo '\n---- Bonita: installation ${GREEN}done${NC} ----\n'
