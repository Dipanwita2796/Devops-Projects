import psycopg2
import sys

host=sys.argv[1]
port=sys.argv[2]
username=sys.argv[3]
password=sys.argv[4]


##creating connection with database
try:
    connection = psycopg2.connect(
        database="parsergateway",
        user=username,
        password=password,
        host=host,  
        port=port  
    )
    #connection = psycopg2.connect(
     #   database="parsergateway",
      #  user="postgres",
       # password="postgres",
       # host="localhost",  
        #port="5432"  
    #)
    print("connection successful with parsergatewaydb")

except psycopg2.Error as error:
    print("Error connecting to PostgreSQL:", error)
    sys.exit()
   
cust_id_list=[] 

##delete data from documents  
def delete_document_data(tenantid,doctype):
    
    # Create a cursor
    cursor = connection.cursor()
    try:
        cursor.execute(f"DELETE FROM documents WHERE tenantid = '{tenantid}' AND doctype = '{doctype}'")
        print("Documents data deleted from document table")
        # Commit after the transaction are done
        connection.commit()
    except psycopg2.Error as error:
        print("Error deleting data:", error)
        # Rollback the transaction in case of an error
        connection.rollback()


## get customer info based on tenants
def get_customer_data(tenantid):
    # Create a cursor
    cursor = connection.cursor()
    cursor.execute(f"SELECT * FROM customer WHERE tenantid = '{tenantid}'")
    rows = cursor.fetchall()
    for row in rows:
        cust_id=row[0]
        cust_id_list.append(cust_id)
        

##delete data from customerdocs table        
def delete_customerdoc_data(cust_id_list):
    cursor = connection.cursor()
    try:
        for custid in cust_id_list:
            cursor.execute(f"DELETE FROM customerdocs WHERE customer_id = '{custid}'")
            # Commit after the transaction are done
            connection.commit()
        print("All document releted to customers are deleted")
    except psycopg2.Error as error:
        print("Error deleting data:", error)
        # Rollback the transaction in case of an error
        connection.rollback()
        

##delete customers from customer table
def delete_customers(tenantid):
    cursor = connection.cursor()
    try:
        cursor.execute(f"DELETE FROM customer WHERE tenantid = '{tenantid}'")
        # Commit after the transaction are done
        connection.commit()
        print("All customers are deleted")
    except psycopg2.Error as error:
        print("Error deleting data:", error)
        # Rollback the transaction in case of an error
        connection.rollback()
    
    
        
##main function
def main_function():
    
    ##taking inputs from user
    tenantid= input("Enter the tenantid:")
    doctype= input("Enter the doctype:")
    
    ##calling the functions for deleting db
    delete_document_data(tenantid,doctype)
    get_customer_data(tenantid)
    delete_customerdoc_data(cust_id_list)
    delete_customers(tenantid)
    if connection:
       connection.close()
    
##calling main function
main_function()