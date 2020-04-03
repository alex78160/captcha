#!/bin/bash

echo "enter the username : "
read -s username
#echo "enter the password for $username : "
#read -s password

echo "enter the password for $username : "
read -s password

rootFolder=$(date +%Y%m%d-%H%M%S)
mkdir $rootFolder
cd $rootFolder

# recup cookie login
#curl --socks5-hostname 127.0.0.1:9150 "http://apollonxilywevef.onion/login.php" --silent --compressed -c cook1.txt
# recup page login avec le premier cookie
#curl --socks5-hostname 127.0.0.1:9150 "http://apollonxilywevef.onion/login.php" --silent --compressed --output out1.html -b cook1.txt
# recup img captcha
#curl --socks5-hostname 127.0.0.1:9150 "http://apollonxilywevef.onion/cap/capshow.png" --silent --compressed --output img.jpg -b cook1.txt
# copie img dans downloads de stockage interne
#cp img.jpg /data/data/com.termux/files/home/storage/downloads/

#identify img.jpg
#convert img.jpg -crop 215x65+0+0 img2.png
#cp img2.png ../../storage/downloads/
#convert img2.png -colorspace gray -threshold 70% img3.png
#convert img3.png -resize 350x80! img5.png
#tesseract --psm 8 --oem 3 img5.png -
#tesseract --psm 8 --oem 3 img2.png -
#tesseract --psm 8 --oem 3 img3.png -
#cp img5.png ../../storage/downloads


#echo "open downloads/img.jpg and enter captcha : "
#read capt

# post login avec captcha
#curl --socks5-hostname 127.0.0.1:9150 "http://apollonxilywevef.onion/login.php" --silent --compressed --output out2.html -b cook1.txt --data "l_username=$username&l_password=*****&capt_code=$capt" -L
statutLogin=1
while [ "$statutLogin" -ne "0" ]
do
	curl --socks5-hostname 127.0.0.1:9150 "http://apollonxilywevef.onion/login.php" --silent --compressed -c cook1.txt
	curl --socks5-hostname 127.0.0.1:9150 "http://apollonxilywevef.onion/login.php" --silent --compressed --output out1.html -b cook1.txt
	curl --socks5-hostname 127.0.0.1:9150 "http://apollonxilywevef.onion/cap/capshow.png" --silent --compressed --output img.jpg -b cook1.txt
	cp img.jpg /data/data/com.termux/files/home/storage/downloads/
	identify img.jpg
	convert img.jpg -crop 215x65+0+0 img2.png
	cp img2.png ../../storage/downloads/
	convert img2.png -colorspace gray -threshold 70% img3.png
	convert img3.png -resize 350x80! img5.png
	tesseract --psm 8 --oem 3 img2.png -
	tesseract --psm 8 --oem 3 img3.png -
	tesseract --psm 8 --oem 3 img5.png -
	capt=$(tesseract --psm 8 --oem 3 img5.png -)
	echo "capt : $capt"
	curl --socks5-hostname 127.0.0.1:9150 "http://apollonxilywevef.onion/login.php" --silent --compressed --output out2.html -b cook1.txt --data "l_username=$username&l_password=$password&capt_code=$capt" -L

	grep -i camille out2.html
	statutLogin=$?
	echo "statut post login : $statutLogin"
	sleep 5
	echo "end sleep"
done


