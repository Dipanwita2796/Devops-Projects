import sys
import os
import pika
import json
import colorama
from os.path import exists
from colorama import Fore


# argument order rabbitmq_host port username password vhost
print('argument need to passed in order of "host","port","username","password","vhost","file_path/name"')
print("name of the python file is ::", sys.argv[0])
print("number of argument passed is ::", len(sys.argv)-1)



#checking if proper arguments has been given or not, if not program will exit
if(len(sys.argv)-1 <6):
    print(f"\033[1;33m your given argumment is {len(sys.argv)-1}, required argument is 6 "+"\U0001F92F \U0001F92F")
    print(Fore.RED+"\033[1m"+"please retry by giving proper argument \U0001F92A  \U0001F92A  \U0001F92A  \U0001F92A	 ")
    exit(1)
else:
    print("you have entered all 6 arguments, please verify::", sys.argv[1],sys.argv[2],sys.argv[3],sys.argv[4],sys.argv[5], sys.argv[6])
    #checking if the given json file exist or not else program will exit
    file_exists = exists(sys.argv[6])
    if(file_exists==False):
        print(Fore.RED+'\033[1m'+f" {sys.argv[6]} file not find in the given path, please give the proper path of json file")
        exit(1)
    else:
        print("\033[1;34m json file fetched successfully will start creating soon..")


#collecting and preparing rabbitmq connection string
credentials = pika.PlainCredentials(sys.argv[3], sys.argv[4])
parameters = pika.ConnectionParameters(host=sys.argv[1], port=sys.argv[2], virtual_host=sys.argv[5], credentials=credentials)

#reading json file and converting into dict
with open(sys.argv[6],'r') as f:
    json_obj=json.loads(f.read())

print("json file read complete.... ")

try:
  #testing connection with rabbitmq with given params
  connection = pika.BlockingConnection(parameters)
  if connection.is_open:
    print(" \U0001F970  \U0001F970  \U0001F970  \U0001F970  \033[2;35m ....connection successfully with rabbitmq...... \U0001F970  \U0001F970  \U0001F970  \U0001F970  ")
    print("\n")
    channel = connection.channel()

    ##creating exchange from the given json file
    try:
        cnt=0
        for i in json_obj["exchanges"]:
            channel.exchange_declare(exchange=i["name"],exchange_type=i["type"],internal=i["internal"],durable=i["durable"],auto_delete=i["auto_delete"],arguments=i["arguments"])
            # print("exchnage created",i["name"])
            cnt+=1
        print(f" \U0001F973  \U0001F973  \U0001F973  \033[2;35m.............No of exchnage got created is::{cnt} ........... \U0001F973  \U0001F973  \U0001F973  ")
        #print("\U0001F973  \U0001F973  \U0001F973  \U0001F973  \U0001F973  \U0001F973  \U0001F973  \U0001F973  \U0001F973  \U0001F973  \U0001F973  \U0001F973  \U0001F973  \U0001F973  \U0001F973  \U0001F973 ")
    except Exception as error:
       print(Fore.RED+" \U0001F615 \U0001F615 \U0001F615 \U0001F615 Please recheck the json file, it has some error or connection broken..try again quiting.. \U0001F615 \U0001F615 \U0001F615 \U0001F615")
       print('Error:', error.__class__.__name__)
       exit(1)

    # try:
    # #testing connection with rabbitmq with given params
    # connection = pika.BlockingConnection(parameters)
    # if connection.is_open:
    # print(" \U0001F970  \U0001F970  \U0001F970  \U0001F970  \033[2;35m ....connection successfully with rabbitmq...... \U0001F970  \U0001F970  \U0001F970  \U0001F970  ")
    # print("\n")
    # channel = connection.channel()

    ##creating queues from the given json file
    try:
        cnt1=0
        for i in json_obj["queues"]:
            channel.queue_declare(queue=i["name"],durable=i["durable"],auto_delete=i["auto_delete"],arguments=i["arguments"])
            print("queue created",i["name"])
            cnt1+=1
        print(f"\U0001F973  \U0001F973  \U0001F973 ......... No of queue got created is:: {cnt1}...........\033[2;35m  \U0001F973  \U0001F973  \U0001F973 ")
        #print("\U0001F973  \U0001F973  \U0001F973  \U0001F973  \U0001F973  \U0001F973  \U0001F973  \U0001F973  \U0001F973   \U0001F973  \U0001F973  \U0001F973  \U0001F973  \U0001F973  \U0001F973  \U0001F973")
    except Exception as error:
       print(Fore.RED+"\U0001F615 \U0001F615 \U0001F615 \U0001F615 Please recheck the json file, it has some error or connection broken.. try again quiting .. \U0001F615 \U0001F615 \U0001F615 \U0001F615")
       print('Error:', error.__class__.__name__)
       exit(1)

    try:
        #testing connection with rabbitmq with given params
        connection = pika.BlockingConnection(parameters)
        if connection.is_open:
            print(" \U0001F970  \U0001F970  \U0001F970  \U0001F970  \033[2;35m ....connection successfully with rabbitmq...... \U0001F970  \U0001F970  \U0001F970  \U0001F970  ")
            print("\n")
            channel = connection.channel()
    except Exception as error:
        print(Fore.RED+"Connection failed with rabbitmq... \U0001FAE3  \U0001FAE3  \U0001FAE3  \U0001FAE3")
        print('Error:', error.__class__.__name__)
        exit(1)
    try:
        cnt2=0
        for i in json_obj["bindings"]:
            channel.queue_bind(exchange=i["source"], queue=i["destination"],routing_key=i["routing_key"],arguments=i["arguments"])
            print("binds created",i["source"],i["destination"],i["routing_key"])
            cnt2 +=1
        print(f" \U0001F973  \U0001F973  \U0001F973  ......... No of bindss got created is:: {cnt2}..........."+'\033[2;35m  \U0001F973  \U0001F973  \U0001F973 ')
        #print("  \U0001F973  \U0001F973  \U0001F973  \U0001F973  \U0001F973  \U0001F973  \U0001F973  \U0001F973  \U0001F973  \U0001F973  \U0001F973  \U0001F973  \U0001F973")
    except Exception as error:
        print(Fore.RED+"\U0001F615 \U0001F615 \U0001F615 \U0001F615 Please recheck the json file, it has some error or connection broken..try again quiting..  \U0001F615 \U0001F615 \U0001F615 \U0001F615 ")
        print('Error:', error.__class__.__name__)
        exit(1)
    print("\n")
    print("\U0001F60E \U0001F60E \U0001F60E \033[1;33m All task done successfully , closing the connection \U0001F60E \U0001F60E \U0001F60E ")
    #closing the connection as task is done   
    connection.close()
    exit(0)
except Exception as error:
  print(Fore.RED+"Connection failed with rabbitmq... \U0001FAE3  \U0001FAE3  \U0001FAE3  \U0001FAE3")
  print('Error:', error.__class__.__name__)
  exit(1)  


