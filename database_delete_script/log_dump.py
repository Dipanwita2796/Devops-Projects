import pymongo
import urllib.parse
import sys
from datetime import datetime
import json
import csv
import pytz

host=sys.argv[1]
port=sys.argv[2]
username=sys.argv[3]
password=sys.argv[4]
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
    query = {"docuploadtimestamp": {"$gte": start_timestamp_milliseconds, "$lt": end_timestamp_milliseconds}}
    result = collection.find(query)
    list1=[]
    for document in result:
        list1.append(document)
    

    unq_dms_list1 = list(set(list(map(lambda x: x["dmscode"], list1))))
    #print(unq_dms_list1)
    list2=[]
    for dms in unq_dms_list1:
        query1={"dmscode":dms}
        result1=collection.find(query1)
        
        for doc in result1:
            if (doc["presenttotalweight"] < int(threshold)):
                list2.append(doc)
    

    unq_dms_list2 = list(set(list(map(lambda x: x["dmscode"], list2))))
    
    report=[]
    for dms in unq_dms_list2:
        unq_version_ = list(filter(lambda x: x["dmscode"] == dms, list2))
        unq_version = list(set(list(map(lambda x: x["version"], unq_version_)))) ###[0 , 1]
        for val in unq_version:
            
            balnc = list(filter(lambda x: x["version"]==val, unq_version_))
            sorted_balance=sorted(balnc,key=lambda x: x["logtimestamp"])
            reference_value = sorted_balance[0]['presenttotalweight']
            for json_object in sorted_balance:
                dms_dict={"dmscode":"","doctype":"","logtimestamp":"","version":"","presentweights":"","sumofweight":"","totalweight":"","response_type_id":"","response_type":"","result":""}
                epoch_seconds = json_object['logtimestamp'] / 1000.0
                dt_object = datetime.utcfromtimestamp(epoch_seconds)
                ist_timezone = pytz.timezone('Asia/Kolkata')
                ist_dt = dt_object.replace(tzinfo=pytz.utc).astimezone(ist_timezone)
                formatted_datetime = ist_dt.strftime('%d/%m/%Y %H:%M:%S')
                dms_dict["dmscode"]=json_object['dmscode']
                dms_dict["doctype"]=json_object['doctype']
                dms_dict["logtimestamp"]=formatted_datetime
                dms_dict["version"]=json_object['version']
                dms_dict["presentweights"]=json_object['presentweights']
                dms_dict["sumofweight"]=json_object['presenttotalweight']
                dms_dict["totalweight"]=json_object['totalweight']
                dms_dict["response_type_id"]=json_object['reponsetypeid']
                dms_dict["response_type"]=json_object['reponsetype']
                if json_object['presenttotalweight'] != reference_value:
                    dms_dict["result"]="Inconsistent"
                else:
                    dms_dict["result"]="Consistent"
                report.append(dms_dict)
    #print("Final Report: ", report)
    keys = report[0].keys()
    with open('Report_Threshold'+ str(datetime.now().strftime('%Y_%m_%d_%H_%M_%S'))+'.csv', 'w', newline='') as output_file:
        dict_writer = csv.DictWriter(output_file, keys)
        dict_writer.writeheader()
        dict_writer.writerows(report)
            


    
connection_check()
b=dmscode_threshold()



