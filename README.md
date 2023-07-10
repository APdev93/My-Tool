## CMD RUN VPS :
```
sudo apt update && cd ~ && curl -sL https://deb.nodesource.com/setup_17.x -o /tmp/nodesource_setup.sh
- sudo bash /tmp/nodesource_setup.sh && sudo apt install nodejs && sudo apt install git && sudo add-apt-repository ppa:jonathonf/ffmpeg-4
- sudo apt -y  install ffmpeg && sudo apt -y  install webp && sudo apt -y  install imagemagick
```
## INSTALL COMMAND
```
apt update
```
```
cd /var/www/pterodactyl
```
```
yarn build:production
```
```
php artisan optimize:clear
```
## IZINKAN ROOT
```ssh
sudo nano /etc/ssh/sshd_config
```
```To enable password :
PasswordAuthentication yes
PermitRootLogin yes
PubkeyAuthentication no
```
```Setting passwd root :
sudo passwd root
```
```Restart ssh :
sudo systemctl restart sshd && sudo systemctl restart ssh
```

## CLEAR
```
apt-get update && apt-get upgrade -y
```
```
ls
```
```
git clone https://github.com/SFams21/clear-cache-vps.git
```
```
cd clear-cache-vps
```
```
chmod +x cleaner-tools.sh
```
```
sh cleaner-tools.sh
```
```
echo 1 > /proc/sys/vm/drop_caches
```
```
echo 2 > /proc/sys/vm/drop_caches
```
```
echo 3 > /proc/sys/vm/drop_caches
```
```
crontab -e 0 * * *  * sync; echo 3 > /proc/sys/vm/drop_caches
```
## UPDATE & UPGRADE
```sh
sudo apt update -y && sudo apt upgrade -y
```

## PANEL & WINGS
#PANEL
```sh
bash <(curl https://pterodactyl-installer.se)
```
#WINGS
```sh
bash <(curl https://raw.githubusercontent.com/anamnich/zas/main/install-wings.sh)
```

## TEMA
Install script:
```sh
bash <(curl https://raw.githubusercontent.com/ChaikalTDR/Utama/master/install.sh)
```

## ChaikalVCJ OFFICIAL
