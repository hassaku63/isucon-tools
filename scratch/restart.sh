#!/bin/bash

# 
# サービスのリスタートのみを実行
# 

function restart() {
	sudo systemctl stop isubata.python.service
	sudo systemctl stop nginx
	sudo systemctl restart mysql
	sudo systemctl start nginx
	sudo systemctl start isubata.python.service
	echo "Service restarted."
}

