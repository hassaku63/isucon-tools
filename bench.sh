#!/bin/bash

# 
# サービスリスタートの後、
# ベンチマークを実行する
# 

function restart() {
	sudo systemctl stop isubata.python.service
	sudo systemctl stop nginx
	sudo systemctl restart mysql
	sudo systemctl start nginx
	sudo systemctl start isubata.python.service
	echo "Service restarted."
}

#restart 
sudo service nginx rotate

pushd /home/isucon/isubata/bench
of=/home/isucon/result.json
./bin/bench -remotes localhost -data data -output ${of}
popd
