FILE_NAME=$1

AWS_KEY=$(curl --header 'X-Vault-Token:'$VAULT_TOKEN http://$VAULT_IP/v1/secret/reminders/app|sed -e 's/{//g' -e 's/"//g' -e 's/:/ /g' -e 's/,/ /g' -e 's/}//g'|grep -oP "(?<=AWS_Access_Key_ID )[^ ]+")

echo $AWS_KEY
AWS_SECRET_KEY=$(curl --header 'X-Vault-Token:'$VAULT_TOKEN http://$VAULT_IP/v1/secret/reminders/app|sed -e 's/{//g' -e 's/"//g' -e 's/:/ /g' -e 's/,/ /g' -e 's/}//g'|grep -oP "(?<=AWS_Secret_Access_Key_ID )[^ ]+")
echo $AWS_SECRET_KEY

AWS_REGION=$(curl --header 'X-Vault-Token:'$VAULT_TOKEN http://$VAULT_IP/v1/secret/reminders/app|sed -e 's/{//g' -e 's/"//g' -e 's/:/ /g' -e 's/,/ /g' -e 's/}//g'|grep -oP "(?<=Default_region_name )[^ ]+")
echo $AWS_REGION
#FILE_NAME="dev_dumpuat_2022-11-06.zip"
export AWS_KEY
export AWS_SECRET_KEY
export AWS_REGION
export FILE_NAME

python s3_delete.py $AWS_KEY $AWS_SECRET_KEY $AWS_REGION $FILE_NAME