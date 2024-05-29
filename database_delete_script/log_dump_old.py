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
start_time=sys.argv[5]
end_time=sys.argv[6]
threshold=sys.argv[7]
database="masterreportingdb"

pwd_encode = urllib.parse.quote_plus(f'{password}')

mongo_uri=(f"mongodb://{username}:{pwd_encode}@{host}:{port}")
#mongo_uri=("mongodb://localhost:27017")
print("mongo_uri:", mongo_uri)

client = pymongo.MongoClient(mongo_uri)
db = client["masterreportingdb"]

#time_string = "29/11/2023 4:35:29"
#time_string = "29/11/2023 6:19:29"
format_string = "%d/%m/%Y %H:%M:%S"
start_datetime_object = datetime.strptime(start_time, format_string)
end_datetime_object = datetime.strptime(end_time, format_string)
start_timestamp_seconds = start_datetime_object.timestamp()
end_timestamp_seconds = end_datetime_object.timestamp()
start_timestamp_milliseconds = int(start_timestamp_seconds * 1000)
end_timestamp_milliseconds = int(end_timestamp_seconds * 1000)

#print("Start Timestamp in milliseconds:", start_timestamp_milliseconds)
#print("End Timestamp in milliseconds:", end_timestamp_milliseconds)
#print("Threshold is:", threshold)


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
        #dict_th={"dmscode":document["dmscode"],"doctype":document["doctype"],"present_weight":document["presenttotalweight"]}
        list1.append(document)
    dict_th={}
    for i in list1:
        if i["dmscode"] not in list(dict_th.keys()):
            dict_th[i["dmscode"]]={i["version"]:[i["presenttotalweight"]]}
            dict_th[i["dmscode"]]["Doctype"]=i["doctype"]
            dict_th[i["dmscode"]]["present weight"]=i["presenttotalweight"]
        else:
            if i["version"] not in list(dict_th[i["dmscode"]].keys()):
                dict_th[i["dmscode"]]={i["version"]:[i["presenttotalweight"]]}
            elif i["version"] in list(dict_th[i["dmscode"]].keys()):
                dict_th[i["dmscode"]][i["version"]].append(i["presenttotalweight"])

    
    #print("***************************************")
    #print(json.dumps(dict_th))
    return dict_th

def dmscode_threshold_report(dict_th):
    report1=[]
    
    for result in dict_th:
        result_dict={"dmscode":"","doctype":"","consistency_version":"","inconsistency_version":"","present_weight":"","final_result":""}
        result_dict["dmscode"]=result
        result_dict["doctype"]=dict_th[result]["Doctype"]
        result_dict["present_weight"]=dict_th[result]["present weight"]

        for version in dict_th[result]:
            if version != "Doctype" and version != "present weight":
                #print(version)
                if all(i == dict_th[result][version][0] for i in dict_th[result][version]) == True:
                    result_dict["consistency_version"]=result_dict["consistency_version"]+' '+str(version)
                else:
                    result_dict["inconsistency_version"]=result_dict["consistency_version"]+' '+str(version)
        if len(result_dict["inconsistency_version"]) != 0:
            result_dict["final_result"]="Inconsistent"
        else:
            result_dict["final_result"]="Consistent"
        report1.append(result_dict)
    #print(report1)
    keys = report1[0].keys()
    with open('Report_Threshold'+ str(datetime.now().strftime('%Y_%m_%d_%H_%M_%S'))+'.csv', 'w', newline='') as output_file:
        dict_writer = csv.DictWriter(output_file, keys)
        dict_writer.writeheader()
        dict_writer.writerows(report1)


    
    # with open('Report_Threshold'+ str(datetime.now().strftime('%Y_%m_%d_%H_%M_%S'))+'.csv', 'w', newline='') as output_file:
    #     dict_writer = csv.DictWriter(output_file, keys)
    #     dict_writer.writeheader()
    #     dict_writer.writerows(list1)


##checking consistency
def dmscode_consistency():
    collection = db["logssummary"]
    query = {"logtimestamp": {"$gte": start_timestamp_milliseconds, "$lt": end_timestamp_milliseconds}}
    result = collection.find(query)
    doc_list=[]
    for document in result:
        doc_list.append(document)
    #print(doc_list)
    dict1={}
    for i in doc_list:
        if i["dmscode"] not in list(dict1.keys()):
            dict1[i["dmscode"]]={i["version"]:[i["presenttotalweight"]]}
            dict1[i["dmscode"]]["Doctype"]=i["doctype"]
        else:
            if i["version"] not in list(dict1[i["dmscode"]].keys()):
                dict1[i["dmscode"]]={i["version"]:[i["presenttotalweight"]]}
            elif i["version"] in list(dict1[i["dmscode"]].keys()):
                dict1[i["dmscode"]][i["version"]].append(i["presenttotalweight"])
                
                
                
    #print("***************************************")
    #print(json.dumps(dict1))
    return dict1


def consistency_report(dict1):
    report=[]
    
    for result in dict1:
        result_dict={"dmscode":"","doctype":"","consistency_version":"","inconsistency_version":"","final_result":""}
        #print(result)
        result_dict["dmscode"]=result
        result_dict["doctype"]=dict1[result]["Doctype"]
        for version in dict1[result]:
            if version != "Doctype":
                #print(dict1[result][version])
                if all(i == dict1[result][version][0] for i in dict1[result][version]) == True:
                    result_dict["consistency_version"]=result_dict["consistency_version"]+' '+str(version)
                else:
                    result_dict["inconsistency_version"]=result_dict["consistency_version"]+' '+str(version)
        if len(result_dict["inconsistency_version"]) != 0:
            result_dict["final_result"]="Inconsistent"
        else:
            result_dict["final_result"]="Consistent"
        report.append(result_dict)


    #print(report)
    keys = report[0].keys()
    #print(keys)
    with open('Report_'+ str(datetime.now().strftime('%Y_%m_%d_%H_%M_%S'))+'.csv', 'w', newline='') as output_file:
        dict_writer = csv.DictWriter(output_file, keys)
        dict_writer.writeheader()
        dict_writer.writerows(report)






    
    

    



connection_check()
b=dmscode_threshold()
dmscode_threshold_report(b)
a=dmscode_consistency()
consistency_report(a)



