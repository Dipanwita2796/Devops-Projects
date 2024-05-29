#!/usr/bin/bash

#insertion started in 'billingdb' : collection 'rulesmaster'
#mongoimport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/ --db billingdb --collection rulesmaster --drop --file billingdb/rulesmaster.json --jsonArray

#insertion started in 'billingdb' : collection 'subscribedfeatures'
#mongoimport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/ --db billingdb --collection subscribedfeatures --drop --file billingdb/subscribedfeatures.json --jsonArray

#insertion started in 'billingdb' : collection 'resourcebilling'
#mongoimport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/ --db billingdb --collection resourcebilling --drop --file billingdb/resourcebilling.json --jsonArray

#insertion started in 'billingdb' : collection 'resourceconsumption'
#mongoimport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/ --db billingdb --collection resourceconsumption --drop --file billingdb/resourceconsumption.json --jsonArray


# #insertion started in 'dmsdb' : collection 'files'
 mongoimport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/ --db dmsdb --collection files --drop --file dmsdb/files.json --jsonArray

# #insertion started in 'dmsdb' : collection 'errorcodes'
mongoimport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/ --db dmsdb --collection errorcodes --drop --file dmsdb/errorcodes.json --jsonArray


# #insertion started in 'docgateway' : collection 'docuploads'
mongoimport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/ --db docgateway --collection docuploads --drop --file docgateway/docuploads.json --jsonArray

# #insertion started in 'docgateway' : collection 'entities'
mongoimport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/ --db docgateway --collection entities --drop --file docgateway/entities.json --jsonArray

# #insertion started in 'docgateway' : collection 'webhookstatus'
mongoimport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/ --db docgateway --collection webhookstatus --drop --file docgateway/webhookstatus.json --jsonArray


# #insertion started in 'prioritymgr' : collection 'documents'
mongoimport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db prioritymgr --collection documents --drop --file prioritymgr/documents.json --jsonArray


#insertion started in 'refdatadb' : collection 'category_master'
#mongoimport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/ --db refdatadb --collection category_master --drop --file refdatadb/category_master.json --jsonArray

#insertion started in 'refdatadb' : collection 'country'
#mongoimport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/ --db refdatadb --collection country --drop --file refdatadb/country.json --jsonArray

#insertion started in 'refdatadb' : collection 'country_units'
#mongoimport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/ --db refdatadb --collection country_units --drop --file refdatadb/country_units.json --jsonArray

#insertion started in 'refdatadb' : collection 'industry'
#mongoimport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/ --db refdatadb --collection industry --drop --file refdatadb/industry.json --jsonArray

#insertion started in 'refdatadb' : collection 'exchange_rate'
#mongoimport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/ --db refdatadb --collection exchange_rate --drop --file refdatadb/exchange_rate.json --jsonArray

#insertion started in 'refdatadb' : collection 'queueconfig'
#mongoimport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/ --db refdatadb --collection queueconfig --drop --file refdatadb/queueconfig.json --jsonArray

#insertion started in 'refdatadb' : collection 'classcodemaster'
#mongoimport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/ --db refdatadb --collection classcodemaster --drop --file refdatadb/classcodemaster.json --jsonArray


#insertion started in 'tenantregistration' : collection 'permissions'
#mongoimport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db tenantregistration --collection permissions --drop --file tenantregistration/permissions.json --jsonArray

#insertion started in 'tenantregistration' : collection 'resourcedefinitions'
#mongoimport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db tenantregistration --collection resourcedefinitions --drop --file tenantregistration/resourcedefinitions.json --jsonArray

#insertion started in 'tenantregistration' : collection 'roles'
#mongoimport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db tenantregistration --collection roles --drop --file tenantregistration/roles.json --jsonArray

#insertion started in 'tenantregistration' : collection 'tenants'
#mongoimport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db tenantregistration --collection tenants --drop --file tenantregistration/tenants.json --jsonArray

#insertion started in 'tenantregistration' : collection 'users'
#mongoimport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db tenantregistration --collection users --drop --file tenantregistration/users.json --jsonArray




#insertion started in 'findatadb' : collection 'allmetricsformula'
mongoimport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db findatadb --collection allmetricsformula --drop --file findatadb/allmetricsformula.json --jsonArray

# #insertion started in 'findatadb' : collection 'basevariables'
mongoimport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db findatadb --collection basevariables --drop --file findatadb/basevariables.json --jsonArray

# #insertion started in 'findatadb' : collection 'coordinatedocs'
mongoimport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db findatadb --collection coordinatedocs --drop --file findatadb/coordinatedocs.json --jsonArray

# #insertion started in 'findatadb' : collection 'docadjustmentsaggregates'
mongoimport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db findatadb --collection docadjustmentsaggregates --drop --file findatadb/docadjustmentsaggregates.json --jsonArray

# #insertion started in 'findatadb' : collection 'docreportingattributes'
mongoimport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db findatadb --collection docreportingattributes --drop --file findatadb/docreportingattributes.json --jsonArray

# #insertion started in 'findatadb' : collection 'extractionmappingmetricsdoc'
mongoimport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db findatadb --collection extractionmappingmetricsdoc --drop --file findatadb/extractionmappingmetricsdoc.json --jsonArray

# #insertion started in 'findatadb' : collection 'financialdataadjustments'
mongoimport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db findatadb --collection financialdataadjustments --drop --file findatadb/financialdataadjustments.json --jsonArray

# #insertion started in 'findatadb' : collection 'financialdocs'
mongoimport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db findatadb --collection financialdocs --drop --file findatadb/financialdocs.json --jsonArray

# #insertion started in 'findatadb' : collection 'financialrawdata'
mongoimport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db findatadb --collection financialrawdata --drop --file findatadb/financialrawdata.json --jsonArray

# #insertion started in 'findatadb' : collection 'mappingadjustments'
mongoimport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db findatadb --collection mappingadjustments --drop --file findatadb/mappingadjustments.json --jsonArray

# #insertion started in 'findatadb' : collection 'rawextractionfinancial'
mongoimport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db findatadb --collection rawextractionfinancial --drop --file findatadb/rawextractionfinancial.json --jsonArray

# #insertion started in 'findatadb' : collection 'sanityrunoutput'
mongoimport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db findatadb --collection sanityrunoutput --drop --file findatadb/sanityrunoutput.json --jsonArray

# #insertion started in 'findatadb' : collection 'chartsconfig'
mongoimport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db findatadb --collection chartsconfig --drop --file findatadb/chartsconfig.json --jsonArray

# #insertion started in 'findatadb' : collection 'chartsconfignew'
mongoimport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db findatadb --collection chartsconfignew --drop --file findatadb/chartsconfignew.json --jsonArray

# #insertion started in 'findatadb' : collection 'metricglossary'
mongoimport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db findatadb --collection metricglossary --drop --file findatadb/metricglossary.json --jsonArray

# #insertion started in 'findatadb' : collection 'sanityexpressions'
mongoimport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db findatadb --collection sanityexpressions --drop --file findatadb/sanityexpressions.json --jsonArray

# #insertion started in 'findatadb' : collection 'sanityglossary'
mongoimport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db findatadb --collection sanityglossary --drop --file findatadb/sanityglossary.json --jsonArray

# #insertion started in 'findatadb' : collection 'sanityconfig'
mongoimport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db findatadb --collection sanityconfig --drop --file findatadb/sanityconfig.json --jsonArray

# #insertion started in 'findatadb' : collection 'filter_col'
mongoimport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db findatadb --collection filter_col --drop --file findatadb/filter_col.json --jsonArray

# #insertion started in 'findatadb' : collection 'financialdatalatest'
mongoimport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db findatadb --collection financialdatalatest --drop --file findatadb/financialdatalatest.json --jsonArray

# #insertion started in 'findatadb' : collection 'extractedfinancials'
mongoimport --uri mongodb+srv://xlrtb2c:Xlrtb2c@mongodb-uat-cluster.kroxz.mongodb.net/  --db findatadb --collection extractedfinancials --drop --file findatadb/extractedfinancials.json --jsonArray




