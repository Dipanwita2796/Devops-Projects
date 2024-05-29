import pymongo

host=sys.argv[1]
port=sys.argv[2]
username=sys.argv[3]
password=sys.argv[4]

pwd_encode = urllib.parse.quote_plus(f'{password}')

mongo_uri=(f"mongodb://{username}:{pwd_encode}@{host}:{port}")
#mongo_uri=("mongodb://localhost:27017")
print("mongo_uri:", mongo_uri)


db_name = "findatadb"
collection_name = "extractedfinancials"

# MongoDB query
query = {"linkeddocid": "283392a29eb249fa8c2e08ff0811b96b"}

# Output file (BSON format)
output_file = "extractedfinancials_dump.bson"

# Connect to MongoDB
client = pymongo.MongoClient(mongo_uri)
db = client["findatadb"]

# Create a cursor with the query
cursor = db["extractedfinancials"].find(query)

# Export data to a BSON file
with open(output_file, "wb") as output:
    for doc in cursor:
        output.write(doc.to_bson())

# Close the MongoDB connection
client.close()






