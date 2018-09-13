#!/bin/bash
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
