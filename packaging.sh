#!/bin/bash

read -p "Enter the demo URL: " DEMO_URL
read -p "Please enter theme code: " THEME_CODE

DEMO_USER=$(/scripts/whoowns $DEMO_URL)
mkdir /home/webramz/public_html/wsb/assets/themes/$THEME_CODE && chown webramz:nobody /home/webramz/public_html/wsb/assets/themes/$THEME_CODE
DATABASE_NAME=$(grep DB_NAME /home/$DEMO_USER/public_html/wp-config.php |  sed -n "s/^.*'\(.*\)'.*$/\1/ p")
#DATABASE_NAME=$(grep DB_NAME /home/$DEMO_USER/public_html/wp-config.php | cut -d \" -f2)
mysqldump $DATABASE_NAME > database.sql && mv database.sql /home/$DEMO_USER/public_html && chown $DEMO_USER:$DEMO_USER /home/$DEMO_USER/public_html/database.sql
cd /home/$DEMO_USER/public_html/ && zip -r archive.zip * && mv archive.zip /home/webramz/public_html/wsb/assets/themes/$THEME_CODE
