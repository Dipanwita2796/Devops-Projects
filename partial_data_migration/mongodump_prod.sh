#!/bin/bash
start_date=$1
end_date=$2
filter=$3
instance=$4
host=$HOST_NAME
start_date_millis=`expr $(date -d "${start_date}" +"%s") \* 1000`
end_date_millis=`expr $(date -d "${end_date}" +"%s") \* 1000`
DATETIME=$(date "+20%y-%m-%d")
FOLDER_DATE=_dumpprod_$DATETIME
FOLDER_NAME=$instance
FOLDER_NAME+=$FOLDER_DATE

mongouser=$(curl --header 'X-Vault-Token:'$VAULT_TOKEN http://$VAULT_IP/v1/secret/$instance|sed -e 's/{//g' -e 's/"//g' -e 's/:/ /g' -e 's/,/ /g' -e 's/}//g'|grep -oP "(?<=MONGODB_USER )[^ ]+")
mongopwd=$(curl --header 'X-Vault-Token:'$VAULT_TOKEN http://$VAULT_IP/v1/secret/$instance|sed -e 's/{//g' -e 's/"//g' -e 's/:/ /g' -e 's/,/ /g' -e 's/}//g'|grep -oP "(?<=MONGODB_PASSWORD )[^ ]+")
declare -a datalist=()
if [ $filter == "IS" ]
then

	mongo --host "$host:22017" -u "$mongouser" -p "$mongopwd" findatadb --quiet  --eval 'db.getCollection("extractedfinancials").distinct("linkeddocid",{ "$and": [ {"auditdata.createdat":{"$gte":'$start_date_millis',"$lt": '$end_date_millis'}},{ "items.classification.componenttype": {"$ne" : "IS"}}]})'>dms_list.txt
	flag="IS"
fi
if [ $filter == "BS" ]
then

	mongo --host "$host:22017" -u "$mongouser" -p "$mongopwd" findatadb --quiet  --eval 'db.getCollection("extractedfinancials").distinct("linkeddocid",{ "$and": [ {"auditdata.createdat":{"$gte":'$start_date_millis',"$lt": '$end_date_millis'}},{ "items.classification.componenttype": {"$ne" : "BS"}}]})'>dms_list.txt
	flag="BS"
fi
if [ $filter == "BSIS" ]
then

	mongo --host "$host:22017" -u "$mongouser" -p "$mongopwd" findatadb --quiet  --eval 'db.getCollection("extractedfinancials").distinct("linkeddocid",{ "$and": [ {"auditdata.createdat":{"$gte":'$start_date_millis',"$lt":'$end_date_millis'}},{ $or: [ { "items.classification.componenttype": {$ne : "BS"} },{ "items.classification.componenttype": {$ne : "IS"}}]}]})'>dms_list.txt
	flag="BSIS"
fi
data=$(sed -e 's/\[//g' -e 's/"//g' -e 's/\]//g' -e 's/,//g' dms_list.txt)
echo $data
echo $data>final.txt
declare -a dmscodelist

while read -r WORD; 
do
    dmscodelist+="$WORD"
done<"final.txt"
for dmscode in $dmscodelist
do
	totalcount=$(mongo --host "$host:22017" -u "$mongouser" -p "$mongopwd" findatadb --quiet  --eval 'db.getCollection("extractedfinancials").find({"linkeddocid":"'$dmscode'"}).count()')
	if [ $flag == "IS" ]
	then
		querycount=$(mongo --host "$host:22017" -u "$mongouser" -p "$mongopwd" findatadb --quiet  --eval 'db.getCollection("extractedfinancials").find({ "$and": [ {"linkeddocid":"'$dmscode'"},{ "items.classification.componenttype": {"$ne" : "IS"}}]}).count()')
	fi
	if [ $flag == "BS" ]
	then
		querycount=$(mongo --host "$host:22017" -u "$mongouser" -p "$mongopwd" findatadb --quiet  --eval 'db.getCollection("extractedfinancials").find({ "$and": [ {"linkeddocid":"'$dmscode'"},{ "items.classification.componenttype": {"$ne" : "BS"}}]}).count()')
	fi
	if [ $flag == "BSIS" ]
	then
		querycount=$(mongo --host "$host:22017" -u "$mongouser" -p "$mongopwd" findatadb --quiet  --eval 'db.getCollection("extractedfinancials").find({ "$and": [ {"linkeddocid":"'$dmscode'"},{ $or: [ { "items.classification.componenttype": {$ne : "BS"} },{ "items.classification.componenttype": {$ne : "IS"}}]}]}).count()')
	fi
	COUNT=`expr $totalcount - $querycount`
	if [ $COUNT == 0 ]
	then
		docname=$(mongo --host "$host:22017" -u "$mongouser" -p "$mongopwd" findatadb --quiet  --eval 'db.getCollection("extractedfinancials").distinct("docname",{ "$and": [ {"auditdata.createdat":{"$gte":'$start_date_millis',"$lt": '$end_date_millis'}},{"linkeddocid":"'$dmscode'"}]})')
		echo $dmscode-$docname>>dmscode_list_prod.txt
		datalist+=("\"${dmscode[@]}\"")
	fi
done
finaldata=$(echo  "${datalist[@]}" | sed -e 's/ /,/g')
sudo mongodump --host $host --port 22017 --authenticationDatabase="admin" -u="$mongouser" -p="$mongopwd" --db findatadb -c extractedfinancials --query='{"linkeddocid":{"$in":['$finaldata']}}' --out=./$FOLDER_NAME
sudo mongodump --host $host --port 22017 --authenticationDatabase="admin" -u="$mongouser" -p="$mongopwd" --db findatadb -c financialdocs --query='{"dmscode":{"$in":['$finaldata']}}' --out=./$FOLDER_NAME
sudo mongodump --host $host --port 22017 --authenticationDatabase="admin" -u="$mongouser" -p="$mongopwd" --db findatadb -c financialrawdata --query='{"dmscode":{"$in":['$finaldata']}}' --out=./$FOLDER_NAME
sudo mongodump --host $host --port 22017 --authenticationDatabase="admin" -u="$mongouser" -p="$mongopwd" --db findatadb -c financialdatalatest --query='{"linkeddocid":{"$in":['$finaldata']}}' --out=./$FOLDER_NAME

rm dms_list.txt
#rm final.txt

zip -r $FOLDER_NAME.zip $FOLDER_NAME
sudo rm -r $FOLDER_NAME
file_location=$FOLDER_NAME.zip
echo $file_location
export file_location
sh fileupload.sh

sudo rm -r $file_location