#!/bin/bash

# 
# MySQLに格納されていた画像データをexportする。
# "EXPORT_DIR" は、次のコマンドで表示されるパスを指定する
#   > SELECT @@global.secure_file_priv;
# 
# 参考: https://qiita.com/kiyodori/items/7281a5bdcfbcbbe03c68
# 
# mysql> SELECT @@global.secure_file_priv;
# +---------------------------+
# | @@global.secure_file_priv |
# +---------------------------+
# | /var/lib/mysql-files/     |
# +---------------------------+# 


EXPORT_DIR="/var/lib/mysql-files"
DBPASSWORD="isucon"

function image_list(){
	images=`mysql -h localhost -u isucon -D isubata -p${DBPASSWORD} -B -N -e "select name from image;" | sort | uniq`
	echo $images
}

for img in `image_list`; do
	echo $img

	mysql -h localhost -u isucon -D isubata -p${DBPASSWORD} -B -N -e "select data into dumpfile '${EXPORT_DIR}/${img}' from image where name = '${img}' limit 1;"
done;
