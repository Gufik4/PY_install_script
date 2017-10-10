#!/usr/bin/env bash
 
# Use single quotes instead of double quotes to make it work with special-character passwords
PASSWORD='coderslab'
HOSTNAME='student.edu'

echo
echo "Witaj w CodersLab!"
echo
echo "Ten skrypt zaktualizuje Twój system, zainstaluje kilka niezbędnych programów,"
echo "których będziesz potrzebować podczas kursu oraz skonfiguruje bazę danych PostgreSQL."
echo "W tym czasie na ekranie pojawi się wiele komunikatów."
echo "ABY INSTALACJA SIĘ POWIODŁA MUSISZ MIEĆ DOSTĘP DO INTERNETU W TRAKCIE TRWANIA "
echo "INSTALACJI!"
read -n1 -r -p "Naciśnij dowolny klawisz, by kontynuować."

mkdir ~/.coderslab

# pausing updating grub as it might triger ui
sudo apt-mark hold grub*
echo
echo "Aktualizuję system..."

# update / upgrade
sudo apt update
sudo apt -y upgrade
echo
echo "Instaluję narzędzia systemowe..."

# install all used tools
sudo apt install -y curl vim git virtualenv mysql-workbench openjdk-8-jre-headless
  
echo
echo "Instaluję bazę danych PostgreSQL..."

# install mysql and give password to installer
# sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $PASSWORD"
# sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $PASSWORD"
# sudo apt install -y mysql-server
sudo apt-get install postgresql postgresql-contrib

echo
echo "Tworzę katalog roboczy..."
# creating and linkng Workspace
sudo mkdir ~/workspace
sudo chmod 777 ~/workspace
# sudo rm -r /var/www/html
# sudo ln -s ~/Workspace /var/www/html
sudo chmod 777 -R ~/workspace

echo
echo "Dla pewności -- ponownie aktualizuję system..."
# update and upgrade all packages
sudo apt update -y
sudo apt upgrade -y

DESKTOP=$(cat <<EOF
[Desktop Entry]
Name=PyCharm
Comment=IDE używane podczas kursu w CodersLab
Exec=/opt/pycharm-2017.2.3/bin/pycharm.sh
Icon=/opt/pycharm-2017.2.3/bin/pycharm.png
Terminal=false
Type=Application
StartupNotify=true
Categories=Utility;Application
EOF
)
touch ~/.coderslab/pycharm.desktop
echo "${DESKTOP}" > ~/.coderslab/pycharm.desktop
sudo cp ~/.coderslab/pycharm.desktop /usr/share/applications/pycharm.desktop
rm ~/.coderslab/pycharm.desktop


# unpausing updating grub
sudo apt-mark unhold grub*
