#!/bin/bash

host_address=$1
username=$2
pwd=$3
DATETIME=$(date "+%y-%m-%d_%H:%M:%S")
declare -a dmscodelist=()

authentication=$(curl -i POST "https://$host_address/auth-api//gatekeeper/login" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"password\": \"$pwd\", \"userid\": \"$username\"}" )
modauthentication=$(echo "{$authentication}" |sed -e 's/:/ /g' -e 's/,/ /g' -e 's/"/ /g')
token=$(echo $modauthentication |grep -oP "(?<=Bearer )[^ ]+")
modtoken="Bearer "$token

echo "Fetching metadata from csv for the documents">>log_file/log_$DATETIME.txt

cd .. && . ./upload_with_diff_metadata.sh

./csvtojson.sh fstmetadatadetails.csv >>script/outputmetadata.txt

for file in *.pdf; do mv "$file" "$(echo $file | sed 's/ /_/g')"; done
yourfilenames=`ls *.pdf`
for eachfile in $yourfilenames 
do
    flag=0
	cp $eachfile ./script
	
	cd script/

	echo file name : "${eachfile}">>log_file/log_$DATETIME.txt
	echo "File Upload Initiated">>log_file/log_$DATETIME.txt
    result="$(curl -k -i -H "Content-Type=multipart/form-data" -F "files=@"$eachfile";type=application/pdf" -X POST https://$host_address/dms-api/dms/fileupload -H "Authorization: $modtoken")"
	response=(${result[@]})
	echo the result is: "${response[-1]}">>log_file/log_$DATETIME.txt
	responsebody="${response[-1]}"
	documentId=$(echo $responsebody | cut -d',' -f 5 | cut -d':' -f 2 | sed 's/"//g')
	documentname=$(echo $responsebody | cut -d',' -f 4 | cut -d':' -f 3 | sed 's/"//g')
	echo "${documentId}"  "${documentname}">>document_list.txt
	dmscodelist+=($documentId)
	
	output_json=$(grep -n "$eachfile" outputmetadata.txt)
	modresponse=$(echo $output_json |sed -e 's/:/ /g' -e 's/,/ /g' -e 's/{/ /g' -e 's/}/ /g')
	#echo $modresponse
	
    required_json_response=$(sed -e 's/:/ /g' -e 's/"/ /g' -e 's/,/ /g' mandatorymetadata.json)
	#echo $required_json_response

	entityid_req=$(echo $required_json_response |grep -oP "(?<=entity_id )[^ ]+")
	entity_id=$(echo $modresponse |grep -oP "(?<=entity_id )[^ ]+")
	entity_idmod=$(echo $entity_id |sed -e 's/-//g')
	if [ "$entityid_req" == "mandatory" -a "$entity_idmod" == "" ]
	then
		echo "Entity Id required!!Cannot upload Document "$eachfile
		flag=1
	fi
	
	entityname_req=$(echo $required_json_response |grep -oP "(?<=entity_name )[^ ]+")
	entity_name=$(echo $modresponse |grep -oP "(?<=entity_name )[^ ]+")
	entity_namemod=$(echo $entity_name |sed -e 's/-//g')
	if [ "$entityname_req" == "mandatory" -a "$entity_namemod" == "" ]
	then
		echo "Entity name required!!Cannot upload Document "$eachfile
		flag=1
	fi
	
	finindex=$(echo $modresponse |grep -oP "(?<=finendmonthindex )[^ ]+")
	finindex_mod=$(echo $finindex |sed -e 's/-//g')
	
	country=$(echo $modresponse |grep -oP "(?<=country )[^ ]+")
	country_mod=$(echo $country |sed -e 's/-//g')
	
	entities=$(echo $entity_namemod|sed -e 's/[\/&]/\\&/g' )
	
	cp customer.json customer_copy.json
	
	sed -i 's/fin_value/'$finindex_mod'/g' customer_copy.json
	sed -i 's/country_value/'$country_mod'/g' customer_copy.json
	sed -i 's/entity_id/'$entity_idmod'/g' customer_copy.json
	sed -i 's/entity_name/'$entities'/g' customer_copy.json
	echo "Customer creation initiated">>log_file/log_$DATETIME.txt
	
	curl -X POST "https://$host_address/docparser-gateway-api//customers" -H "accept: */*" -H "Authorization: $modtoken" -H "Content-Type: application/json" -d @customer_copy.json>>log_file/log_$DATETIME.txt
	
	docsource_req=$(echo $required_json_response |grep -oP "(?<=docsource )[^ ]+")
	docsource_name=$(echo $modresponse |grep -oP "(?<=docsource )[^ ]+")
	docsource_namemod=$(echo $docsource_name |sed -e 's/-//g')
	if [ "$docsource_req" == "mandatory" -a "$docsource_namemod" == "" ]
	then
		echo "Docsource required!!Cannot upload Document "$eachfile
		flag=1
	fi	
	
	templateid_req=$(echo $required_json_response |grep -oP "(?<=template_id )[^ ]+")
	template_id=$(echo $modresponse |grep -oP "(?<=template_id )[^ ]+")
	template_idsmod=$(echo $template_id |sed -e 's/-//g')
	if [ "$templateid_req" == "mandatory" -a "$template_idsmod" == "" ]
	then
		echo "Template_id required!!Cannot upload Document "$eachfile
		flag=1
	fi
	
	templatename_req=$(echo $required_json_response |grep -oP "(?<=template_name )[^ ]+")
	template_name=$(echo $modresponse |grep -oP "(?<=template_name )[^ ]+")
	template_namesmod=$(echo $template_name |sed -e 's/-//g')
	if [ "$templatename_req" == "mandatory" -a "$template_namesmod" == "" ]
	then
		echo "Template_name required!!Cannot upload Document "$eachfile
		flag=1
	fi
	
	templatecode_req=$(echo $required_json_response |grep -oP "(?<=template_code )[^ ]+")
	template_code=$(echo $modresponse |grep -oP "(?<=template_code )[^ ]+")
	template_codemod=$(echo $template_code |sed -e 's/-//g')
	if [ "$templatecode_req" == "mandatory" -a "$template_codemod" == "" ]
	then
		echo "Template_code required!!Cannot upload Document "$eachfile
		flag=1
	fi
	
	unit_req=$(echo $required_json_response |grep -oP "(?<=unit )[^ ]+")
	unit=$(echo $modresponse |grep -oP "(?<=unit )[^ ]+")
	unitmod=$(echo $unit |sed -e 's/-//g')
	if [ "$unit_req" == "mandatory" -a "$unitmod" == "" ]
	then
		echo "Units required!!Cannot upload Document "$eachfile
		flag=1
	fi
	
	currencycode_req=$(echo $required_json_response |grep -oP "(?<=currency_code )[^ ]+")
	currency_code=$(echo $modresponse |grep -oP "(?<=currency_code )[^ ]+")
	currency_codemod=$(echo $currency_code |sed -e 's/-//g')
	if [ "$currencycode_req" == "mandatory" -a "$currency_codemod" == "" ]
	then
		echo "Currency code required!!Cannot upload Document "$eachfile
		flag=1
	fi
	
	currencyname_req=$(echo $required_json_response |grep -oP "(?<=currency_name )[^ ]+")
	currency_name=$(echo $modresponse |grep -oP "(?<=currency_name )[^ ]+")
	currency_namemod=$(echo $currency_name |sed -e 's/-//g')
	if [ "$currencyname_req" == "mandatory" -a "$currency_namemod" == "" ]
	then
		echo "Currency name required!!Cannot upload Document "$eachfile
		flag=1
	fi
	
	currencydesc_req=$(echo $required_json_response |grep -oP "(?<=currency_desc )[^ ]+")
	currency_desc=$(echo $modresponse |grep -oP "(?<=currency_desc )[^ ]+")
	currency_descmod=$(echo $currency_desc |sed -e 's/-//g')
	if [ "$currencydesc_req" == "mandatory" -a "$currency_descmod" == "" ]
	then
		echo "Currency desc required!!Cannot upload Document "$eachfile
		flag=1
	fi
	
	langcode_req=$(echo $required_json_response |grep -oP "(?<=lang_code )[^ ]+")
	lang_code=$(echo $modresponse |grep -oP "(?<=lang_code )[^ ]+")
	lang_codemod=$(echo $lang_code |sed -e 's/-//g')
	if [ "$langcode_req" == "mandatory" -a "$lang_codemod" == "" ]
	then
		echo "Language code required!!Cannot upload Document "$eachfile
		flag=1
	fi
	
	langname_req=$(echo $required_json_response |grep -oP "(?<=lang_name )[^ ]+")
	lang_name=$(echo $modresponse |grep -oP "(?<=lang_name )[^ ]+")
	lang_namemod=$(echo $lang_name |sed -e 's/-//g')
	if [ "$langname_req" == "mandatory" -a "$lang_namemod" == "" ]
	then
		echo "Language name required!!Cannot upload Document "$eachfile
		flag=1
	fi
	
	langdesc_req=$(echo $required_json_response |grep -oP "(?<=lang_desc )[^ ]+")
	lang_desc=$(echo $modresponse |grep -oP "(?<=lang_desc )[^ ]+")
	lang_desccmod=$(echo $lang_desc |sed -e 's/-//g')
	if [ "$langdesc_req" == "mandatory" -a "$lang_desccmod" == "" ]
	then
		echo "Language desc required!!Cannot upload Document "$eachfile
		flag=1
	fi
	
	datatype_req=$(echo $required_json_response |grep -oP "(?<=datatype )[^ ]+")
	datatype=$(echo $modresponse |grep -oP "(?<=datatype )[^ ]+")
	datatypemod=$(echo $datatype |sed -e 's/-//g')
	if [ "$datatype_req" == "mandatory" -a "$datatypemod" == "" ]
	then
		echo "Datatype required!!Cannot upload Document "$eachfile
		flag=1
	fi

	isresult_req=$(echo $required_json_response |grep -oP "(?<=isresult )[^ ]+")
	isresult=$(echo $modresponse |grep -oP "(?<=finresult )[^ ]+")
	isresultmod=$(echo $isresult |sed -e 's/-//g')
	if [ "$isresult_req" == "mandatory" -a "$isresultmod" == "" ]
	then
		echo "Finresult required!!Cannot upload Document "$eachfile
		flag=1
	fi
	
	pagenumberbscon_req=$(echo $required_json_response |grep -oP "(?<=pagenumberbscon )[^ ]+")
	pagenumberbscon_temp=$(echo $modresponse |grep -oP "(?<=pagenumberbscon )[^ ]+")
	pagenumberbscon=$(echo $pagenumberbscon_temp|sed -e 's/@/,/g')
	pagenumberbsconmod=$(echo $pagenumberbscon |sed -e 's/-//g')
	if [ "$pagenumberbscon_req" == "mandatory" -a "$pagenumberbsconmod" == "" ]
	then
		echo "Pagenumberbscon required!!Cannot upload Document "$eachfile
		flag=1
	fi
	
	pagenumberbssta_req=$(echo $required_json_response |grep -oP "(?<=pagenumberbssta )[^ ]+")
	pagenumberbssta_temp=$(echo $modresponse |grep -oP "(?<=pagenumberbssta )[^ ]+")
	pagenumberbssta=$(echo $pagenumberbssta_temp|sed -e 's/@/,/g')
	pagenumberbsstamod=$(echo $pagenumberbssta |sed -e 's/-//g')
	if [ "$pagenumberbssta_req" == "mandatory" -a "$pagenumberbsstamod" == "" ]
	then
		echo "Pagenumberbssta required!!Cannot upload Document "$eachfile
		flag=1
	fi
	
	pagenumberiscon_req=$(echo $required_json_response |grep -oP "(?<=pagenumberiscon )[^ ]+")
	pagenumberiscon_temp=$(echo $modresponse |grep -oP "(?<=pagenumberiscon )[^ ]+")
	pagenumberiscon=$(echo $pagenumberiscon_temp|sed -e 's/@/,/g')
	pagenumberisconmod=$(echo $pagenumberiscon |sed -e 's/-//g')
	if [ "$pagenumberiscon_req" == "mandatory" -a "$pagenumberisconmod" == "" ]
	then
		echo "pagenumberiscon required!!Cannot upload Document "$eachfile
		flag=1
	fi
	
	pagenumberissta_req=$(echo $required_json_response |grep -oP "(?<=pagenumberissta )[^ ]+")
	pagenumberissta_temp=$(echo $modresponse |grep -oP "(?<=pagenumberissta )[^ ]+")
	pagenumberissta=$(echo $pagenumberissta_temp|sed -e 's/@/,/g')
	pagenumberisstamod=$(echo $pagenumberissta |sed -e 's/-//g')
	if [ "$pagenumberissta_req" == "mandatory" -a "$pagenumberisstamod" == "" ]
	then
		echo "pagenumberissta required!!Cannot upload Document "$eachfile
		flag=1
	fi
	
	pagenumbercfcon_req=$(echo $required_json_response |grep -oP "(?<=pagenumbercfcon )[^ ]+")
	pagenumbercfcon_temp=$(echo $modresponse |grep -oP "(?<=pagenumbercfcon )[^ ]+")
	pagenumbercfcon=$(echo $pagenumbercfcon_temp|sed -e 's/@/,/g')
	pagenumbercfconmod=$(echo $pagenumbercfcon |sed -e 's/-//g')
	if [ "$pagenumbercfcon_req" == "mandatory" -a "$pagenumbercfconmod" == "" ]
	then
		echo "Pagenumbercfcon required!!Cannot upload Document "$eachfile
		flag=1
	fi
	
	pagenumbercfsta_req=$(echo $required_json_response |grep -oP "(?<=pagenumbercfsta )[^ ]+")
	pagenumbercfsta_temp=$(echo $modresponse |grep -oP "(?<=pagenumbercfsta )[^ ]+")
	pagenumbercfsta=$(echo $pagenumbercfsta_temp|sed -e 's/@/,/g')
	pagenumbercfstamod=$(echo $pagenumbercfsta |sed -e 's/-//g')
	if [ "$pagenumbercfsta_req" == "mandatory" -a "$pagenumbercfstamod" == "" ]
	then
		echo "Pagenumbercfsta required!!Cannot upload Document "$eachfile
		flag=1
	fi

	pagenumbernotes_req=$(echo $required_json_response |grep -oP "(?<=pagenumbernotes )[^ ]+")
	pagenumbernotes_temp=$(echo $modresponse |grep -oP "(?<=pagenumbernotes )[^ ]+")
	pagenumbernotes=$(echo $pagenumbernotes_temp|sed -e 's/@/,/g')
	pagenumbernotesmod=$(echo $pagenumbernotes |sed -e 's/-//g')
	if [ "$pagenumbernotes_req" == "mandatory" -a "$pagenumbernotesmod" == "" ]
	then
		echo "Pagenumbernotes required!!Cannot upload Document "$eachfile
		flag=1
	fi
	
	pagenumberliquidity_req=$(echo $required_json_response |grep -oP "(?<=pagenumbernotesliquidity )[^ ]+")
	pagenumberliquidity_temp=$(echo $modresponse |grep -oP "(?<=pagenumbernotesliquidity )[^ ]+")
	pagenumbernotesliquidity=$(echo $pagenumberliquidity_temp|sed -e 's/@/,/g')
	pagenumberliquiditymod=$(echo $pagenumbernotesliquidity |sed -e 's/-//g')
	if [ "$pagenumberliquidity_req" == "mandatory" -a "$pagenumberliquiditymod" == "" ]
	then
		echo "Pagenumberliquidity required!!Cannot upload Document "$eachfile
		flag=1
	fi
	
	industrycode_req=$(echo $required_json_response |grep -oP "(?<=industrycode )[^ ]+")
	industrycode=$(echo $modresponse |grep -oP "(?<=industrycode )[^ ]+")
	industrycodemod=$(echo $industrycode |sed -e 's/-//g')
	if [ "$industrycode_req" == "mandatory" -a "$industrycodemod" == "" ]
	then
		echo "Industry code required!!Cannot upload Document "$eachfile
		flag=1
	fi
	
	password_req=$(echo $required_json_response |grep -oP "(?<=password )[^ ]+")
	password=$(echo $modresponse |grep -oP "(?<=password )[^ ]+")
	passwordmod=$(echo $password |sed -e 's/-//g')
	if [ "$password_req" == "mandatory" -a "$passwordmod" == "" ]
	then
		echo "Password required!!Cannot upload Document "$eachfile
		flag=1
	fi
	
	features=$(echo $modresponse |grep -oP "(?<=features )[^ ]+")
	featuresmod=$(echo $features |sed -e 's/-//g')
	if [ "$featuresmod" == "Notes" ]
	then
		cp upload_with_notes.json upload_copy.json
		sed -i 's/pagenumbernotes_value/'$pagenumbernotesmod'/g' upload_copy.json
	else
		cp upload_without_notes.json upload_copy.json
	fi
	files=$(echo $eachfile|sed -e 's/[\/&]/\\&/g' )

	sed -i 's/dms_code/'$documentId'/g' upload_copy.json
		sed -i 's/file_name/'$files'/g' upload_copy.json
		sed -i 's/docsource_name/'$docsource_namemod'/g' upload_copy.json
		sed -i 's/template_id/'$template_idsmod'/g' upload_copy.json
		sed -i 's/template_name/'$template_namesmod'/g' upload_copy.json
		sed -i 's/template_code/'$template_codemod'/g' upload_copy.json
		sed -i 's/unit_code/'$unitmod'/g' upload_copy.json
		sed -i 's/currency_code/'$currency_codemod'/g' upload_copy.json
		sed -i 's/currency_name/'$currency_namemod'/g' upload_copy.json
		sed -i 's/currency_desc/'$currency_descmod'/g' upload_copy.json
		sed -i 's/lang_code/'$lang_codemod'/g' upload_copy.json
		sed -i 's/lang_name/'$lang_namemod'/g' upload_copy.json
		sed -i 's/lang_desc/'$lang_desccmod'/g' upload_copy.json
		sed -i 's/datatype_code/'$datatypemod'/g' upload_copy.json
		sed -i 's/isresult_value/'$isresultmod'/g' upload_copy.json
		sed -i 's/pagenumberbscon_value/'$pagenumberbsconmod'/g' upload_copy.json
		sed -i 's/pagenumberbssta_value/'$pagenumberbsstamod'/g' upload_copy.json
		sed -i 's/pagenumberiscon_value/'$pagenumberisconmod'/g' upload_copy.json
		sed -i 's/pagenumberissta_value/'$pagenumberisstamod'/g' upload_copy.json
		sed -i 's/pagenumbercfcon_value/'$pagenumbercfconmod'/g' upload_copy.json
		sed -i 's/pagenumbercfsta_value/'$pagenumbercfstamod'/g' upload_copy.json
		sed -i 's/pagenumbernotesliquidity_value/'$pagenumberliquiditymod'/g' upload_copy.json
		sed -i 's/industrycode_value/'$industrycodemod'/g' upload_copy.json
		sed -i 's/password_value/'$passwordmod'/g' upload_copy.json
		sed -i 's/entity_id/'$entity_idmod'/g' upload_copy.json
		sed -i 's/entity_name/'$entities'/g' upload_copy.json

		if [ $flag == 0 ]
		then
	      echo "Proccessing Initiated for " $eachfile>>log_file/log_$DATETIME.txt
		  curl -X POST -H "Content-Type: application/json" -d @upload_copy.json https://$host_address/docparser-gateway-api/documents -H "Authorization: $modtoken">>log_file/log_$DATETIME.txt
	    fi
	rm $eachfile
	cd .. && . ./upload_with_diff_metadata.sh
done
cd script/
rm document_list.txt
rm outputmetadata.txt
#echo  "${dmscodelist[@]}" >>dmscode_list.txt
echo "Process Ended">>log_file/log_$DATETIME.txt