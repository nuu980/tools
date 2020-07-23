#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

#wget -P 目录 网址  下载到指定目录


NAME := trojan-go

install:
	echo "deb http://ftp.de.debian.org/debian sid main" | tee --append /etc/apt/sources.list&&apt-get update
	apt -y install unzip wget curl openssl net-tools
	mkdir ./trojan-go/
	cd ./trojan-go/
	wget "https://github.com/p4gefau1t/trojan-go/releases/download/v0.8.1/trojan-go-linux-amd64.zip"
	unzip -o ./trojan-go-linux-amd64.zip
	ls
	rm -f ./trojan-go-linux-amd64.zip
	mkdir -p /etc/$(NAME)
	mkdir -p /usr/share/$(NAME)
	cp example/service.json /etc/$(NAME)/config.json
	cp ./$(NAME) /usr/bin/$(NAME)
	chmod +x /usr/bin/$(NAME)
	cp example/$(NAME).service /lib/systemd/system/
	cp example/$(NAME)@.service /lib/systemd/system/
	systemctl daemon-reload
	cp geosite.dat /usr/share/$(NAME)/geosite.dat
	cp geoip.dat /usr/share/$(NAME)/geoip.dat
	ln -fs /usr/share/$(NAME)/geoip.dat /usr/bin/
	ln -fs /usr/share/$(NAME)/geosite.dat /usr/bin/