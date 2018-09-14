#!/bin/sh

# ダウンロード
wget https://github.com/tkuchiki/alp/releases/download/v0.3.1/alp_linux_amd64.zip
unzip alp_linux_amd64.zip
 
mkdir ~/alp
sudo install ./alp /usr/local/bin
