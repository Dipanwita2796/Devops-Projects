#!/usr/bin/bash

#mongoimport --db dbName --collection collectionName --file fileName.json --jsonArray -u ser -p password
#mongoimport --host <host_name>:<host_port> --db <database_name> --collection <collection_name>  --file <path_to_dump_file> -u <my_user> -p <my_pass>

host=$1
port=$2
username=$3
password=$4
echo "Host Address: ${host}"
echo "Port Number: ${port}"
echo "Username: ${username}"
echo "Password: ${password}"


#declare -A databaseList=( ["allmetricsformula" "chartsconfig" "metricglossary"]="findatadb"
#						  ["bstchartsconfig" "metricexpression" "metricglossary" "transactionconfig"]="bankstatementdb"
#						  ["kvformcollection" "kvtabledefination"]="kvfinancialsdb"
#						  ["reportdefinitions"]="reportingdb"
#						)
#
#for collection in "${!databaseList[@]}";
#do
#	echo "${databaseList[$collection]} : $collection";
#	array=(${$collection//" "/ })
#	for c in "${array}";
#	do
#	  echo c;
#	done
#	#mongoimport --host $host --port $port --db reportingdb --collection reportdefinitions --file reportingdb/reportdefinitions.json -u $username -p $password
#done

#Stack Overflow link
#https://stackoverflow.com/questions/29775398/mongoimport-json-file-update-or-overwritte

#insertion started in 'dmsdb' : collection 'files'
mongoimport --host $host --port $port --db DNB_dmsdb --collection files --drop --file dmsdb/files.json --jsonArray -u $username -p $password

# #insertion started in 'dmsdb' : collection 'errorcodes'
mongoimport --host $host --port $port --db DNB_dmsdb --collection errorcodes --drop --file dmsdb/errorcodes.json --jsonArray -u $username -p $password


# #insertion started in 'docgateway' : collection 'docuploads'
mongoimport --host $host --port $port --db DNB_docgateway --collection docuploads --drop --file docgateway/docuploads.json --jsonArray -u $username -p $password

# #insertion started in 'docgateway' : collection 'entities'
mongoimport --host $host --port $port --db DNB_docgateway --collection entities --drop --file docgateway/entities.json --jsonArray -u $username -p $password

# #insertion started in 'docgateway' : collection 'webhookstatus'
mongoimport --host $host --port $port --db DNB_docgateway --collection webhookstatus --drop --file docgateway/webhookstatus.json --jsonArray -u $username -p $password


# #insertion started in 'prioritymgr' : collection 'documents'
mongoimport --host $host --port $port --db DNB_prioritymgr --collection documents --drop --file prioritymgr/documents.json --jsonArray -u $username -p $password



#insertion started in 'findatadb' : collection 'allmetricsformula'
mongoimport --host $host --port $port --db DNB_findatadb --collection allmetricsformula --drop --file findatadb/allmetricsformula.json --jsonArray -u $username -p $password

# #insertion started in 'findatadb' : collection 'basevariables'
mongoimport --host $host --port $port --db DNB_findatadb --collection basevariables --drop --file findatadb/basevariables.json --jsonArray -u $username -p $password

# #insertion started in 'findatadb' : collection 'chartsconfig'
mongoimport --host $host --port $port --db DNB_findatadb --collection chartsconfig --drop --file findatadb/chartsconfig.json --jsonArray -u $username -p $password

# #insertion started in 'findatadb' : collection 'chartsconfignew'
mongoimport --host $host --port $port --db DNB_findatadb --collection chartsconfignew --drop --file findatadb/chartsconfignew.json --jsonArray -u $username -p $password

# #insertion started in 'findatadb' : collection 'coordinatedocs'
mongoimport --host $host --port $port --db DNB_findatadb --collection coordinatedocs --drop --file findatadb/coordinatedocs.json --jsonArray -u $username -p $password

# #insertion started in 'findatadb' : collection 'docadjustmentsaggregates'
mongoimport --host $host --port $port --db DNB_findatadb --collection docadjustmentsaggregates --drop --file findatadb/docadjustmentsaggregates.json --jsonArray -u $username -p $password

# #insertion started in 'findatadb' : collection 'docreportingattributes'
mongoimport --host $host --port $port --db DNB_findatadb --collection docreportingattributes --drop --file findatadb/docreportingattributes.json --jsonArray -u $username -p $password

# #insertion started in 'findatadb' : collection 'extractionmappingmetricsdoc'
mongoimport --host $host --port $port --db DNB_findatadb --collection extractionmappingmetricsdoc --drop --file findatadb/extractionmappingmetricsdoc.json --jsonArray -u $username -p $password

# #insertion started in 'findatadb' : collection 'filter_col'
mongoimport --host $host --port $port --db DNB_findatadb --collection filter_col --drop --file findatadb/filter_col.json --jsonArray -u $username -p $password

# #insertion started in 'findatadb' : collection 'financialdataadjustments'
mongoimport --host $host --port $port --db DNB_findatadb --collection financialdataadjustments --drop --file findatadb/financialdataadjustments.json --jsonArray -u $username -p $password

# #insertion started in 'findatadb' : collection 'financialdocs'
mongoimport --host $host --port $port --db DNB_findatadb --collection financialdocs --drop --file findatadb/financialdocs.json --jsonArray -u $username -p $password

# #insertion started in 'findatadb' : collection 'financialrawdata'
mongoimport --host $host --port $port --db DNB_findatadb --collection financialrawdata --drop --file findatadb/financialrawdata.json --jsonArray -u $username -p $password

# #insertion started in 'findatadb' : collection 'mappingadjustments'
mongoimport --host $host --port $port --db DNB_findatadb --collection mappingadjustments --drop --file findatadb/mappingadjustments.json --jsonArray -u $username -p $password

# #insertion started in 'findatadb' : collection 'metricglossary'
mongoimport --host $host --port $port --db DNB_findatadb --collection metricglossary --drop --file findatadb/metricglossary.json --jsonArray -u $username -p $password

# #insertion started in 'findatadb' : collection 'rawextractionfinancial'
mongoimport --host $host --port $port --db DNB_findatadb --collection rawextractionfinancial --drop --file findatadb/rawextractionfinancial.json --jsonArray -u $username -p $password

# #insertion started in 'findatadb' : collection 'sanityconfig'
mongoimport --host $host --port $port --db DNB_findatadb --collection sanityconfig --drop --file findatadb/sanityconfig.json --jsonArray -u $username -p $password

# #insertion started in 'findatadb' : collection 'sanityexpressions'
mongoimport --host $host --port $port --db DNB_findatadb --collection sanityexpressions --drop --file findatadb/sanityexpressions.json --jsonArray -u $username -p $password

# #insertion started in 'findatadb' : collection 'sanityglossary'
mongoimport --host $host --port $port --db DNB_findatadb --collection sanityglossary --drop --file findatadb/sanityglossary.json --jsonArray -u $username -p $password

# #insertion started in 'findatadb' : collection 'sanityrunoutput'
mongoimport --host $host --port $port --db DNB_findatadb --collection sanityrunoutput --drop --file findatadb/sanityrunoutput.json --jsonArray -u $username -p $password

# #insertion started in 'findatadb' : collection 'financialdatalatest'
mongoimport --host $host --port $port --db DNB_findatadb --collection financialdatalatest --drop --file findatadb/financialdatalatest.json --jsonArray -u $username -p $password

# #insertion started in 'findatadb' : collection 'extractedfinancials'
mongoimport --host $host --port $port --db DNB_findatadb --collection extractedfinancials --drop --file findatadb/extractedfinancials.json --jsonArray -u $username -p $password



