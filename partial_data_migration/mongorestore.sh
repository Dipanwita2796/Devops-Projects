#!/bin/bash
start_date=$1
end_date=$2
instance=$3
FILE_NAME=$4
host=$HOST_NAME
mongouser=$(curl --header 'X-Vault-Token:'$VAULT_TOKEN http://$VAULT_IP/v1/secret/$instance|sed -e 's/{//g' -e 's/"//g' -e 's/:/ /g' -e 's/,/ /g' -e 's/}//g'|grep -oP "(?<=MONGODB_USER )[^ ]+")
mongopwd=$(curl --header 'X-Vault-Token:'$VAULT_TOKEN http://$VAULT_IP/v1/secret/$instance|sed -e 's/{//g' -e 's/"//g' -e 's/:/ /g' -e 's/,/ /g' -e 's/}//g'|grep -oP "(?<=MONGODB_PASSWORD )[^ ]+")
mongorestore --host=$host --port=22017 --username=$mongouser --password=$mongopwd --db findatadb --maintainInsertionOrder $FILE_NAME/findatadb
declare -a dmscodelist=()

declare -a documentlist=()

while read -r WORD; 
do
    dmscodelist+="$WORD "
done<"dmscode_list_uat.txt"
echo "${dmscodelist[@]}"
for dmscode in $dmscodelist
do
	docname=$(mongo --host "$host" -u "$mongouser" -p "$mongopwd" findatadb --quiet  --eval 'db.getCollection("extractedfinancials").distinct("docname",{ "$and": [ {"auditdata.createdat":{"$gte":'$start_date',"$lt": '$end_date'}},{"linkeddocid":"'$dmscode'"}]})')
	documentlist+=$docname
	echo "${dmscode}"  "${docname}">>document_list.txt
done
