#!/bin/bash
start_date=$1
end_date=$2
instance=$3
host=$HOST_NAME
start_date_millis=`expr $(date -d "${start_date}" +"%s") \* 1000`
end_date_millis=`expr $(date -d "${end_date}" +"%s") \* 1000`
DATETIME=$(date "+20%y-%m-%d")
FOLDER_DATE=_dumpuat_$DATETIME
FOLDER_NAME=$instance
FOLDER_NAME+=$FOLDER_DATE
mongouser=$(curl --header 'X-Vault-Token:'$VAULT_TOKEN http://$VAULT_IP/v1/secret/$instance|sed -e 's/{//g' -e 's/"//g' -e 's/:/ /g' -e 's/,/ /g' -e 's/}//g'|grep -oP "(?<=MONGODB_USER )[^ ]+")
mongopwd=$(curl --header 'X-Vault-Token:'$VAULT_TOKEN http://$VAULT_IP/v1/secret/$instance|sed -e 's/{//g' -e 's/"//g' -e 's/:/ /g' -e 's/,/ /g' -e 's/}//g'|grep -oP "(?<=MONGODB_PASSWORD )[^ ]+")

declare -a datalist=()

mongo --host "$host" --port=22017 -u "$mongouser" -p "$mongopwd" findatadb --quiet  --eval 'db.getCollection("extractedfinancials").distinct("linkeddocid",{"auditdata.createdat":{"$gte": '$start_date_millis',"$lt": '$end_date_millis'}})'>dms_list.txt
data=$(sed -e 's/\[//g' -e 's/"//g' -e 's/\]//g' -e 's/,//g' dms_list.txt)
echo $data>final.txt
declare -a dmscodelist

while read -r WORD; 
do
    dmscodelist+="$WORD"
done<"final.txt"

for dmscode in $dmscodelist
do
    docname=$(mongo --host "$host:22017" -u "$mongouser" -p "$mongopwd" findatadb --quiet  --eval 'db.getCollection("extractedfinancials").distinct("docname",{ "$and": [ {"auditdata.createdat":{"$gte":'$start_date_millis',"$lt": '$end_date_millis'}},{"linkeddocid":"'$dmscode'"}]})')
	echo $dmscode-$docname>>dmscode_list_uat.txt
    datalist+=("\"${dmscode[@]}\"")
done
echo $datalist
finaldata=$(echo  "${datalist[@]}" | sed -e 's/ /,/g')
mongodump --host=$host --port=22017 --username=$mongouser --password=$mongopwd --db findatadb -c extractedfinancials --query='{"linkeddocid":{"$in":['$finaldata']}}' --out=./$FOLDER_NAME
mongodump --host=$host --port=22017 --username=$mongouser --password=$mongopwd --db findatadb -c financialdocs --query='{"dmscode":{"$in":['$finaldata']}}' --out=./$FOLDER_NAME
mongodump --host=$host --port=22017 --username=$mongouser --password=$mongopwd --db findatadb -c financialrawdata --query='{"dmscode":{"$in":['$finaldata']}}' --out=./$FOLDER_NAME
mongodump --host=$host --port=22017 --username=$mongouser --password=$mongopwd --db findatadb -c financialdatalatest --query='{"linkeddocid":{"$in":['$finaldata']}}' --out=./$FOLDER_NAME
rm dms_list.txt
rm final.txt

zip -r $FOLDER_NAME.zip $FOLDER_NAME
sudo rm -r $FOLDER_NAME
file_location=$FOLDER_NAME.zip
echo $file_location
export file_location
sh fileupload.sh

unzip 