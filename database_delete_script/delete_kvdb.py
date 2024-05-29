import pymongo
import urllib.parse
import sys

host=sys.argv[1]
port=sys.argv[2]
username=sys.argv[3]
password=sys.argv[4]
database="kvdatadb"

pwd_encode = urllib.parse.quote_plus(f'{password}')

mongo_uri=(f"mongodb://{username}:{pwd_encode}@{host}:{port}")
#mongo_uri=("mongodb://localhost:27017")
print("mongo_uri:", mongo_uri)

client = pymongo.MongoClient(mongo_uri)
db = client["kvdatadb"]

dmscode_list=[]


##checking the connection 
def connection_check():
    try: 
        db.command("serverStatus")
    except Exception as e: 
        print(e)
        sys.exit()
    else: 
        print("You are connected to kvdatadb!")
        
        
        
#drop documents from kvdocument
def drop_kvdocument(tenantid,doctype):
    collection = db["kvdocument"]
    condition1={"metadata.tenantId":tenantid}
    condition2={"doctype":doctype}
    query = {"$and": [condition1, condition2]}
    doc_count=collection.count_documents(query)
    print("No. of documents present in kvdocument:",doc_count)
    doc_delete = collection.delete_many(query)
    print("No. of document deleted from kvdocument:",doc_delete.deleted_count)
    
    
#drop documents from kvdata
def drop_kvdata(tenantid,doctype):
    collection = db["kvdata"]
    condition1={"tenantid":tenantid}
    condition2={"doctype":doctype}
    query = {"$and": [condition1, condition2]}
    doc_count=collection.count_documents(query)
    print("No. of documents present in kvdata:",doc_count)
    result=collection.find(query)
    for document in result:
        dmscode_list.append(document['dmscode'])
    doc_delete = collection.delete_many(query)
    print("No. of document deleted from kvdata:",doc_delete.deleted_count)
    
    
#drop documents from kvauditdata
def drop_kvauditdata(tenantid,doctype):
    collection = db["kvauditdata"]
    condition1={"tenantid":tenantid}
    condition2={"doctype":doctype}
    query = {"$and": [condition1, condition2]}
    doc_count=collection.count_documents(query)
    print("No. of documents present in kvauditdata:",doc_count)
    doc_delete = collection.delete_many(query)
    print("No. of document deleted from kvauditdata:",doc_delete.deleted_count)
    

#drop documents from kvexceptions
def drop_kvexceptions(tenantid,doctype):
    collection = db["kvexceptions"]
    condition1={"tenantid":tenantid}
    condition2={"doctype":doctype}
    query = {"$and": [condition1, condition2]}
    doc_count=collection.count_documents(query)
    print("No. of documents present in kvexceptions:",doc_count)
    doc_delete = collection.delete_many(query)
    print("No. of document deleted from kvexceptions:",doc_delete.deleted_count)
    

#drop documents from rawextractionkv
def drop_rawextractionkv(tenantid,doctype):
    collection = db["rawextractionkv"]
    condition1={"tenant":tenantid}
    condition2={"document.doctype":doctype}
    query = {"$and": [condition1, condition2]}
    doc_count=collection.count_documents(query)
    print("No. of documents present in rawextractionkv:",doc_count)
    doc_delete = collection.delete_many(query)
    print("No. of document deleted from rawextractionkv:",doc_delete.deleted_count)
    
    
#drop documents from kvpageinfo
def drop_kvpageinfo(dmscode_list):
    collection = db["kvpageinfo"]
    dmscode_set=set(dmscode_list)
    count=0
    deleted_doc=0
    for dmscode in dmscode_set:
      condition1={"dmscode":dmscode}
      query = condition1
      result=collection.find(query)
      for document in result:
          count=count+1
      doc_delete = collection.delete_one(query)
      deleted_doc=deleted_doc+doc_delete.deleted_count
    print("No. of document present in kvpageinfo:",count)
    print("No. of document deleted from kvpageinfo:",deleted_doc)
      
      

##main function  
def main_func():  
    
    ##calling function for connection check
    connection_check()
    
    ##taking user input      
    tenantid= input("Enter the tenantid:")
    doctype= input("Enter the doctype:")
    
    ##calling the functions for deleting db
    drop_kvdocument(tenantid,doctype)
    drop_kvdata(tenantid,doctype)
    drop_kvauditdata(tenantid,doctype)
    drop_kvexceptions(tenantid,doctype)
    drop_rawextractionkv(tenantid,doctype)
    drop_kvpageinfo(dmscode_list)
    client.close()


##calling main function
main_func()
