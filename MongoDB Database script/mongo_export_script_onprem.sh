#!/usr/bin/bash
host=$1
port=$2
username=$3
password=$4
echo "Host Address: ${host}"
echo "Port Number: ${port}"
echo "Username: ${username}"
echo "Password: ${password}"


######################################################## BILLING DATABASE EXPORT ############################################################

#export started in 'billingdb' : collection 'rulesmaster'
mongoexport --host $host --port $port --db billingdb --collection rulesmaster --out billingdb/rulesmaster.json --jsonArray -u $username -p $password

#export started in 'billingdb' : collection 'subscribedfeatures'
mongoexport --host $host --port $port --db billingdb --collection subscribedfeatures --out billingdb/subscribedfeatures.json --jsonArray -u $username -p $password

#export started in 'billingdb' : collection 'resourcebilling'
mongoexport --host $host --port $port --db billingdb --collection resourcebilling --out billingdb/resourcebilling.json --jsonArray -u $username -p $password

#export started in 'billingdb' : collection 'resourceconsumption'
mongoexport --host $host --port $port --db billingdb --collection resourceconsumption --out billingdb/resourceconsumption.json --jsonArray -u $username -p $password



######################################################## DMS DATABASE EXPORT ############################################################




#insertion started in 'dmsdb' : collection 'files'
mongoexport --host $host --port $port --db DNB_dmsdb --collection files --out dmsdb/files.json --jsonArray -u $username -p $password

# #insertion started in 'dmsdb' : collection 'errorcodes'
mongoexport --host $host --port $port --db DNB_dmsdb --collection errorcodes --out dmsdb/errorcodes.json --jsonArray -u $username -p $password



######################################################## DOCGATEWAY DATABASE EXPORT ############################################################



# #insertion started in 'docgateway' : collection 'docuploads'
mongoexport --host $host --port $port --db DNB_docgateway --collection docuploads  --out docgateway/docuploads.json --jsonArray -u $username -p $password

# #insertion started in 'docgateway' : collection 'entities'
mongoexport --host $host --port $port --db DNB_docgateway --collection entities  --out docgateway/entities.json --jsonArray -u $username -p $password

# #insertion started in 'docgateway' : collection 'webhookstatus'
mongoexport --host $host --port $port --db DNB_docgateway --collection webhookstatus  --out docgateway/webhookstatus.json --jsonArray -u $username -p $password



######################################################## PRIORITYMGR DATABASE EXPORT ############################################################




# #insertion started in 'prioritymgr' : collection 'documents'
mongoexport --host $host --port $port --db DNB_prioritymgr --collection documents  --out prioritymgr/documents.json --jsonArray -u $username -p $password



######################################################## REFERENCE DATABASE EXPORT ############################################################


#export started in 'refdatadb' : collection 'category_master'
mongoexport --host $host --port $port --db refdatadb --collection category_master --out refdatadb/category_master.json --jsonArray -u $username -p $password

#export started in 'refdatadb' : collection 'country'
mongoexport --host $host --port $port --db refdatadb --collection country --out refdatadb/country.json --jsonArray -u $username -p $password

#export started in 'refdatadb' : collection 'country_units'
mongoexport --host $host --port $port --db refdatadb --collection country_units --out refdatadb/country_units.json --jsonArray -u $username -p $password

#export started in 'refdatadb' : collection 'industry'
mongoexport --host $host --port $port --db refdatadb --collection industry --out refdatadb/industry.json --jsonArray -u $username -p $password

#export started in 'refdatadb' : collection 'exchange_rate'
mongoexport --host $host --port $port --db refdatadb --collection exchange_rate --out refdatadb/exchange_rate.json --jsonArray -u $username -p $password

#export started in 'refdatadb' : collection 'queueconfig'
mongoexport --host $host --port $port --db refdatadb --collection queueconfig --out refdatadb/queueconfig.json --jsonArray -u $username -p $password

#export started in 'refdatadb' : collection 'classcodemaster'
mongoexport --host $host --port $port --db refdatadb --collection classcodemaster --out refdatadb/classcodemaster.json --jsonArray -u $username -p $password



######################################################## TENANTREGISTRATION DATABASE EXPORT ############################################################




#export started in 'tenantregistration' : collection 'permissions'
mongoexport --host $host --port $port  --db tenantregistration --collection permissions --out tenantregistration/permissions.json --jsonArray -u $username -p $password

#export started in 'tenantregistration' : collection 'resourcedefinitions'
mongoexport --host $host --port $port  --db tenantregistration --collection resourcedefinitions --out tenantregistration/resourcedefinitions.json --jsonArray -u $username -p $password

#export started in 'tenantregistration' : collection 'roles'
mongoexport --host $host --port $port  --db tenantregistration --collection roles --out tenantregistration/roles.json --jsonArray -u $username -p $password

#export started in 'tenantregistration' : collection 'tenants'
mongoexport --host $host --port $port  --db tenantregistration --collection tenants --out tenantregistration/tenants.json --jsonArray -u $username -p $password

#export started in 'tenantregistration' : collection 'users'
mongoexport --host $host --port $port  --db tenantregistration --collection users --out tenantregistration/users.json --jsonArray -u $username -p $password



######################################################## FINANCIALDATA DATABASE EXPORT ############################################################



#insertion started in 'findatadb' : collection 'allmetricsformula'
mongoexport --host $host --port $port --db DNB_findatadb --collection allmetricsformula  --out findatadb/allmetricsformula.json --jsonArray -u $username -p $password

# #insertion started in 'findatadb' : collection 'chartsconfig'
mongoexport --host $host --port $port --db DNB_findatadb --collection chartsconfig  --out findatadb/chartsconfig.json --jsonArray -u $username -p $password

# #insertion started in 'findatadb' : collection 'metricglossary'
mongoexport --host $host --port $port --db DNB_findatadb --collection metricglossary  --out findatadb/metricglossary.json --jsonArray -u $username -p $password

# #insertion started in 'findatadb' : collection 'chartsconfignew'
mongoexport --host $host --port $port --db DNB_findatadb --collection chartsconfignew  --out findatadb/chartsconfignew.json --jsonArray -u $username -p $password

# #insertion started in 'findatadb' : collection 'sanityconfig'
mongoexport --host $host --port $port --db DNB_findatadb --collection sanityconfig  --out findatadb/sanityconfig.json --jsonArray -u $username -p $password

# #insertion started in 'findatadb' : collection 'sanityexpressions'
mongoexport --host $host --port $port --db DNB_findatadb --collection sanityexpressions  --out findatadb/sanityexpressions.json --jsonArray -u $username -p $password

# #insertion started in 'findatadb' : collection 'sanityglossary'
mongoexport --host $host --port $port --db DNB_findatadb --collection sanityglossary  --out findatadb/sanityglossary.json --jsonArray -u $username -p $password

# #insertion started in 'findatadb' : collection 'basevariables'
mongoexport --host $host --port $port --db DNB_findatadb --collection basevariables  --out findatadb/basevariables.json --jsonArray -u $username -p $password

# #insertion started in 'findatadb' : collection 'coordinatedocs'
mongoexport --host $host --port $port --db DNB_findatadb --collection coordinatedocs  --out findatadb/coordinatedocs.json --jsonArray -u $username -p $password

# #insertion started in 'findatadb' : collection 'docadjustmentsaggregates'
mongoexport --host $host --port $port --db DNB_findatadb --collection docadjustmentsaggregates  --out findatadb/docadjustmentsaggregates.json --jsonArray -u $username -p $password

# #insertion started in 'findatadb' : collection 'docreportingattributes'
mongoexport --host $host --port $port --db DNB_findatadb --collection docreportingattributes  --out findatadb/docreportingattributes.json --jsonArray -u $username -p $password

# #insertion started in 'findatadb' : collection 'extractionmappingmetricsdoc'
mongoexport --host $host --port $port --db DNB_findatadb --collection extractionmappingmetricsdoc  --out findatadb/extractionmappingmetricsdoc.json --jsonArray -u $username -p $password

# #insertion started in 'findatadb' : collection 'filter_col'
mongoexport --host $host --port $port --db DNB_findatadb --collection filter_col  --out findatadb/filter_col.json --jsonArray -u $username -p $password

# #insertion started in 'findatadb' : collection 'financialdataadjustments'
mongoexport --host $host --port $port --db DNB_findatadb --collection financialdataadjustments  --out findatadb/financialdataadjustments.json --jsonArray -u $username -p $password

# #insertion started in 'findatadb' : collection 'financialdocs'
mongoexport --host $host --port $port --db DNB_findatadb --collection financialdocs  --out findatadb/financialdocs.json --jsonArray -u $username -p $password

# #insertion started in 'findatadb' : collection 'financialrawdata'
mongoexport --host $host --port $port --db DNB_findatadb --collection financialrawdata  --out findatadb/financialrawdata.json --jsonArray -u $username -p $password

# #insertion started in 'findatadb' : collection 'mappingadjustments'
mongoexport --host $host --port $port --db DNB_findatadb --collection mappingadjustments  --out findatadb/mappingadjustments.json --jsonArray -u $username -p $password

# #insertion started in 'findatadb' : collection 'rawextractionfinancial'
mongoexport --host $host --port $port --db DNB_findatadb --collection rawextractionfinancial  --out findatadb/rawextractionfinancial.json --jsonArray -u $username -p $password

# #insertion started in 'findatadb' : collection 'sanityrunoutput'
mongoexport --host $host --port $port --db DNB_findatadb --collection sanityrunoutput  --out findatadb/sanityrunoutput.json --jsonArray -u $username -p $password

# #insertion started in 'findatadb' : collection 'financialdatalatest'
mongoexport --host $host --port $port --db DNB_findatadb --collection financialdatalatest  --out findatadb/financialdatalatest.json --jsonArray -u $username -p $password

# #insertion started in 'findatadb' : collection 'extractedfinancials'
mongoexport --host $host --port $port --db DNB_findatadb --collection extractedfinancials  --out findatadb/extractedfinancials.json --jsonArray -u $username -p $password



