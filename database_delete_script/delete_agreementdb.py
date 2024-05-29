import pymongo
import urllib.parse
import sys

host=sys.argv[1]
port=sys.argv[2]
username=sys.argv[3]
password=sys.argv[4]
database="agreementdatadb"

pwd_encode = urllib.parse.quote_plus(f'{password}')

mongo_uri=(f"mongodb://{username}:{pwd_encode}@{host}:{port}")
#mongo_uri=("mongodb://localhost:27017")
print("mongo_uri:", mongo_uri)

client = pymongo.MongoClient(mongo_uri)
db = client["agreementdatadb"]

dmscode_list=[]


##checking the connection 
def connection_check():
    try: 
        db.command("serverStatus")
    except Exception as e: 
        print(e)
        sys.exit()
    else: 
        print("You are connected to agreementdatadb!")


#drop documents from agreementdocs
def drop_agreementdocs(tenantid,doctype):
    collection = db["agreementdocs"]
    condition1={"metadata.tenantId":tenantid}
    condition2={"doctype":doctype}
    query = {"$and": [condition1, condition2]}
    doc_count=collection.count_documents(query)
    print("No. of documents present in agreementdocs:",doc_count)
    doc_delete = collection.delete_many(query)
    print("No. of document deleted from agreementdocs:",doc_delete.deleted_count)
    
    
#drop documents from agreements
def drop_agreements(tenantid,doctype):
    collection = db["agreements"]
    condition1={"tenantid":tenantid}
    condition2={"doctype":doctype}
    query = {"$and": [condition1, condition2]}
    doc_count=collection.count_documents(query)
    print("No. of documents present in agreements:",doc_count)
    result=collection.find(query)
    for document in result:
        dmscode_list.append(document['dmscode'])
        
    doc_delete = collection.delete_many(query)
    print("No. of document deleted from agreements:",doc_delete.deleted_count)
    
    
#drop documents from contractexceptions
def drop_contractexceptions(tenantid,doctype):
    collection = db["contractexceptions"]
    condition1={"tenantid":tenantid}
    condition2={"doctype":doctype}
    query = {"$and": [condition1, condition2]}
    doc_count=collection.count_documents(query)
    print("No. of documents present in contractexceptions:",doc_count)
    doc_delete = collection.delete_many(query)
    print("No. of document deleted from contractexceptions:",doc_delete.deleted_count)
    

#drop documents from reportingdata
def drop_reportingdata(tenantid,doctype):
    collection = db["reportingdata"]
    condition1={"tenantid":tenantid}
    condition2={"doctype":doctype}
    query = {"$and": [condition1, condition2]}
    doc_count=collection.count_documents(query)
    print("No. of documents present in reportingdata:",doc_count)
    doc_delete = collection.delete_many(query)
    print("No. of document deleted from reportingdata:",doc_delete.deleted_count)
    

#drop documents from rawextractionagreement
def drop_rawextractionagreement(tenantid,doctype):
    collection = db["rawextractionagreement"]
    condition1={"tenant":tenantid}
    condition2={"document.doctype":doctype}
    query = {"$and": [condition1, condition2]}
    doc_count=collection.count_documents(query)
    print("No. of documents present in rawextractionagreement:",doc_count)
    doc_delete = collection.delete_many(query)
    print("No. of document deleted from rawextractionagreement:",doc_delete.deleted_count)
    
    
#drop documents from textdocextraction
def drop_textdocextraction(dmscode_list):
    collection = db["textdocextraction"]
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
    print("No. of document present in textdocextraction:",count)
    print("No. of document deleted from textdocextraction:",deleted_doc)
      
      
#drop documents from textdocextractionpages
def drop_textdocextractionpages(dmscode_list):
    collection = db["textdocextractionpages"]
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
    print("No. of document present in textdocextractionpages:",count)
    print("No. of document deleted from textdocextractionpages:",deleted_doc)
    
    

##main function  
def main_func():  
    
    ##calling function for connection check
    connection_check()
    
    ##taking inputs from user
    tenantid= input("Enter the tenantid:")
    doctype= input("Enter the doctype:")
    
    ##calling the functions for deleting db
    drop_agreementdocs(tenantid,doctype)
    drop_agreements(tenantid,doctype)
    drop_contractexceptions(tenantid,doctype)
    drop_reportingdata(tenantid,doctype)
    drop_rawextractionagreement(tenantid,doctype)
    drop_textdocextraction(dmscode_list)
    drop_textdocextractionpages(dmscode_list)
    client.close()


##calling main function
main_func()
