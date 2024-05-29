#!/usr/bin/bash

######################################################## BILLING DATABASE EXPORT ############################################################

#export started in 'billingdb' : collection 'rulesmaster'
mongoexport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/ --db billingdb --collection rulesmaster --out billingdb/rulesmaster.json --jsonArray

#export started in 'billingdb' : collection 'subscribedfeatures'
mongoexport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/ --db billingdb --collection subscribedfeatures --out billingdb/subscribedfeatures.json --jsonArray

#export started in 'billingdb' : collection 'resourcebilling'
mongoexport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/ --db billingdb --collection resourcebilling --out billingdb/resourcebilling.json --jsonArray

#export started in 'billingdb' : collection 'resourceconsumption'
mongoexport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/ --db billingdb --collection resourceconsumption --out billingdb/resourceconsumption.json --jsonArray



######################################################## DMS DATABASE EXPORT ############################################################


# export started in 'dmsdb' : collection 'files'
mongoexport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/ --db dmsdb --collection files --out dmsdb/files.json --jsonArray

# #export started in 'dmsdb' : collection 'errorcodes'
mongoexport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/ --db dmsdb --collection errorcodes --out dmsdb/errorcodes.json --jsonArray




######################################################## DOCGATEWAY DATABASE EXPORT ############################################################



# #export started in 'docgateway' : collection 'docuploads'
mongoexport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/ --db docgateway --collection docuploads --out docgateway/docuploads.json --jsonArray

# #export started in 'docgateway' : collection 'entities'
mongoexport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/ --db docgateway --collection entities --out docgateway/entities.json --jsonArray

# #export started in 'docgateway' : collection 'webhookstatus'
mongoexport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/ --db docgateway --collection webhookstatus --out docgateway/webhookstatus.json --jsonArray



######################################################## PRIORITYMGR DATABASE EXPORT ############################################################



# #export started in 'prioritymgr' : collection 'documents'
mongoexport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db prioritymgr --collection documents --out prioritymgr/documents.json --jsonArray



######################################################## REFERENCE DATABASE EXPORT ############################################################


#export started in 'refdatadb' : collection 'category_master'
mongoexport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/ --db refdatadb --collection category_master --out refdatadb/category_master.json --jsonArray

#export started in 'refdatadb' : collection 'country'
mongoexport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/ --db refdatadb --collection country --out refdatadb/country.json --jsonArray

#export started in 'refdatadb' : collection 'country_units'
mongoexport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/ --db refdatadb --collection country_units --out refdatadb/country_units.json --jsonArray

#export started in 'refdatadb' : collection 'industry'
mongoexport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/ --db refdatadb --collection industry --out refdatadb/industry.json --jsonArray

#export started in 'refdatadb' : collection 'exchange_rate'
mongoexport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/ --db refdatadb --collection exchange_rate --out refdatadb/exchange_rate.json --jsonArray

#export started in 'refdatadb' : collection 'queueconfig'
mongoexport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/ --db refdatadb --collection queueconfig --out refdatadb/queueconfig.json --jsonArray

#export started in 'refdatadb' : collection 'classcodemaster'
mongoexport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/ --db refdatadb --collection classcodemaster --out refdatadb/classcodemaster.json --jsonArray



######################################################## TENANTREGISTRATION DATABASE EXPORT ############################################################




#export started in 'tenantregistration' : collection 'permissions'
mongoexport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db tenantregistration --collection permissions --out tenantregistration/permissions.json --jsonArray

#export started in 'tenantregistration' : collection 'resourcedefinitions'
mongoexport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db tenantregistration --collection resourcedefinitions --out tenantregistration/resourcedefinitions.json --jsonArray

#export started in 'tenantregistration' : collection 'roles'
mongoexport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db tenantregistration --collection roles --out tenantregistration/roles.json --jsonArray

#export started in 'tenantregistration' : collection 'tenants'
mongoexport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db tenantregistration --collection tenants --out tenantregistration/tenants.json --jsonArray

#export started in 'tenantregistration' : collection 'users'
mongoexport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db tenantregistration --collection users --out tenantregistration/users.json --jsonArray




######################################################## FINANCIALDATA DATABASE EXPORT ############################################################



#export started in 'findatadb' : collection 'allmetricsformula'
mongoexport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db findatadb --collection allmetricsformula --out findatadb/allmetricsformula.json --jsonArray

# #export started in 'findatadb' : collection 'chartsconfig'
mongoexport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db findatadb --collection chartsconfig  --out findatadb/chartsconfig.json --jsonArray

# #export started in 'findatadb' : collection 'chartsconfignew'
mongoexport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db findatadb --collection chartsconfignew  --out findatadb/chartsconfignew.json --jsonArray

# #export started in 'findatadb' : collection 'metricglossary'
mongoexport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db findatadb --collection metricglossary  --out findatadb/metricglossary.json --jsonArray

# #export started in 'findatadb' : collection 'sanityexpressions'
mongoexport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db findatadb --collection sanityexpressions  --out findatadb/sanityexpressions.json --jsonArray

# #export started in 'findatadb' : collection 'sanityglossary'
mongoexport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db findatadb --collection sanityglossary  --out findatadb/sanityglossary.json --jsonArray

# #export started in 'findatadb' : collection 'sanityconfig'
mongoexport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db findatadb --collection sanityconfig  --out findatadb/sanityconfig.json --jsonArray

# #export started in 'findatadb' : collection 'basevariables'
mongoexport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db findatadb --collection basevariables --out findatadb/basevariables.json --jsonArray

# #export started in 'findatadb' : collection 'coordinatedocs'
mongoexport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db findatadb --collection coordinatedocs --out findatadb/coordinatedocs.json --jsonArray

# #export started in 'findatadb' : collection 'docadjustmentsaggregates'
mongoexport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db findatadb --collection docadjustmentsaggregates --out findatadb/docadjustmentsaggregates.json --jsonArray

# #export started in 'findatadb' : collection 'docreportingattributes'
mongoexport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db findatadb --collection docreportingattributes --out findatadb/docreportingattributes.json --jsonArray

# #export started in 'findatadb' : collection 'extractionmappingmetricsdoc'
mongoexport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db findatadb --collection extractionmappingmetricsdoc --out findatadb/extractionmappingmetricsdoc.json --jsonArray

# #export started in 'findatadb' : collection 'financialdataadjustments'
mongoexport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db findatadb --collection financialdataadjustments --out findatadb/financialdataadjustments.json --jsonArray

# #export started in 'findatadb' : collection 'financialdocs'
mongoexport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db findatadb --collection financialdocs --out findatadb/financialdocs.json --jsonArray

# #export started in 'findatadb' : collection 'financialrawdata'
mongoexport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db findatadb --collection financialrawdata --out findatadb/financialrawdata.json --jsonArray

# #export started in 'findatadb' : collection 'mappingadjustments'
mongoexport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db findatadb --collection mappingadjustments --out findatadb/mappingadjustments.json --jsonArray

# #export started in 'findatadb' : collection 'rawextractionfinancial'
mongoexport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db findatadb --collection rawextractionfinancial --out findatadb/rawextractionfinancial.json --jsonArray

# #export started in 'findatadb' : collection 'sanityrunoutput'
mongoexport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db findatadb --collection sanityrunoutput --out findatadb/sanityrunoutput.json --jsonArray

# #export started in 'findatadb' : collection 'filter_col'
mongoexport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db findatadb --collection filter_col --out findatadb/filter_col.json --jsonArray

# #export started in 'findatadb' : collection 'financialdatalatest'
mongoexport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db findatadb --collection financialdatalatest --out findatadb/financialdatalatest.json --jsonArray

# #export started in 'findatadb' : collection 'extractedfinancials'
mongoexport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db findatadb --collection extractedfinancials --out findatadb/extractedfinancials.json --jsonArray




