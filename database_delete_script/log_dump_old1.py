import pymongo
import urllib.parse
import sys
from datetime import datetime
import json
import csv

host=sys.argv[1]
port=sys.argv[2]
username=sys.argv[3]
password=sys.argv[4]
#start_time=sys.argv[5]
#end_time=sys.argv[6]
#threshold=sys.argv[5]
database="masterreportingdb"

pwd_encode = urllib.parse.quote_plus(f'{password}')

mongo_uri=(f"mongodb://{username}:{pwd_encode}@{host}:{port}")
#mongo_uri=("mongodb://localhost:27017")
print("mongo_uri:", mongo_uri)

client = pymongo.MongoClient(mongo_uri)
db = client["masterreportingdb"]

#time_string = "29/11/2023 16:35:29"
#time_string = "29/11/2023 17:19:29"
start_time=input("Enter the start time:")
end_time=input("Enter the end time:")
threshold=input("Enter the threshold value:")
format_string = "%d/%m/%Y %H:%M:%S"
start_datetime_object = datetime.strptime(start_time, format_string)
end_datetime_object = datetime.strptime(end_time, format_string)
start_timestamp_seconds = start_datetime_object.timestamp()
end_timestamp_seconds = end_datetime_object.timestamp()
start_timestamp_milliseconds = int(start_timestamp_seconds * 1000)
end_timestamp_milliseconds = int(end_timestamp_seconds * 1000)

print("Start Timestamp in milliseconds:", start_timestamp_milliseconds)
print("End Timestamp in milliseconds:", end_timestamp_milliseconds)



##checking the connection 
def connection_check():
    try: 
        db.command("serverStatus")
    except Exception as e: 
        print(e)
        sys.exit()
    else: 
        print("You are connected to masterreportingdb!")


##checking the threshold
def dmscode_threshold():
    collection = db["logssummary"]
    query = {"logtimestamp": {"$gte": start_timestamp_milliseconds, "$lt": end_timestamp_milliseconds}}
    #doc_count=collection.count_documents(query)
    result = collection.find(query)
    list1=[]
    for document in result:
      if (document["presenttotalweight"] < int(threshold)):
        list1.append(document)
    #print(list1)
    if not list1:
        print("The list is empty")
        sys.exit()
    unq_dms = list(set(list(map(lambda x: x["dmscode"], list1))))
    #print(unq_dms)
    dms_dict = {}
    for dms in unq_dms:
        #dms_dict = {}
        dms_dict.setdefault(dms, {})
        unq_version_ = list(filter(lambda x: x["dmscode"] == dms, list1))
        #print(unq_version_)
        unq_version = set(list(map(lambda x: x["version"], unq_version_))) ###[0 , 1]
        doctype = unq_version_[0]['doctype']
        temp_dict = {}
        temp_dict["Doctype"]=doctype
        temp_dict["unique_version"]=list(unq_version)
        version_count=len(unq_version)
        for val in unq_version:
            bal = list(filter(lambda x: x["version"]==val, unq_version_))
            #print("**********************",bal,"******************************")
            sort_bal=sorted(bal,key=lambda x: x["logtimestamp"])
            #print("##############",sort_bal,"##########################")
            weight = list(map(lambda x: x["presenttotalweight"], bal))
            #doctype = list(map(lambda x: x["doctype"], bal))
            temp_dict.setdefault(str(val), weight)
            #temp_dict["Doctype"]=doctype
            temp_dict['v'+str(val)+'_weight']=str(sort_bal[-1]['presentweights'])+"="+str(sort_bal[-1]['presenttotalweight'])
        #print(temp_dict)
        dms_dict[dms] = temp_dict       
    #print(dms_dict)
    return dms_dict



##dump into the report
def dmscode_threshold_report(dict_th):
    report1=[]
    for result in dict_th:
        result_dict={"dmscode":"","doctype":"","consistency_version":"","inconsistency_version":"","final_result":""}
        result_dict["dmscode"]=result
        result_dict["doctype"]=dict_th[result]["Doctype"]
        for version in dict_th[result]["unique_version"]:
                result_dict['v'+str(version)+'_weight']=dict_th[result]['v'+str(version)+'_weight']
                if all(i == dict_th[result][str(version)][0] for i in dict_th[result][str(version)]) == True:
                    result_dict["consistency_version"]=result_dict["consistency_version"]+'  '+str(version)
                else:
                    result_dict["inconsistency_version"]=result_dict["inconsistency_version"]+'  '+str(version)
        if len(result_dict["inconsistency_version"]) != 0:
            result_dict["final_result"]="Inconsistent"
        else:
            result_dict["final_result"]="Consistent"
        report1.append(result_dict)
    #print(report1)
    len_keys=0
    dmscode=0
    for val in range (len(report1)):
        if len(list(report1[val].keys())) > len_keys:
            len_keys=len(list(report1[val].keys()))
            dmscode=val
        else:
            continue
    keys = report1[dmscode].keys()
    #print(list[keys])
    with open('Report_Threshold'+ str(datetime.now().strftime('%Y_%m_%d_%H_%M_%S'))+'.csv', 'w', newline='') as output_file:
        dict_writer = csv.DictWriter(output_file, keys)
        dict_writer.writeheader()
        dict_writer.writerows(report1)


    
connection_check()
b=dmscode_threshold()
dmscode_threshold_report(b)



