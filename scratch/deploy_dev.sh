#!/bin/bash

# 
# - サービスリスタート
# - Developをデプロイ
# - ベンチマークを実行
# - Slack通知
# 

function restart() {
	sudo systemctl stop isubata.python.service
	sudo systemctl stop nginx
	sudo systemctl restart mysql
	sudo systemctl start nginx
	sudo systemctl start isubata.python.service
	echo "Service restarted."
}

pushd /home/isucon/isubata/webapp/python
echo Working Directory: `pwd`

# Service restart
sudo service nginx rotate

# Deploy from dev
git pull origin dev-hashimoto \
	&& git branch -v \
	&& restart \
	#&& curl -X POST --data-urlencode "payload={\"channel\": \"#private-ext-isucon8\", \"username\": \"deployment\", \"text\": \"Deployment done..\", \"icon_emoji\": \":ghost:\"}" https://hooks.slack.com/services/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
	echo "deploy done."
popd

# Run benchmark
pushd /home/isucon/isubata/bench
of=/home/isucon/result.json
./bin/bench -remotes localhost -data data -output ${of}

# Slack notification
#result=`cat ${of} | jq -r '"pass:" + .pass + ", score:" + .score'`
#echo ${result}
#
#curl -X POST --data-urlencode "payload={\"channel\": \"#private-ext-isucon7\", \"username\": \"deployment\", \"text\": \"${result}\", \"icon_emoji\": \":ghost:\"}" https://hooks.slack.com/services/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
