import json


with open("queueconfigdetails-dev.json", 'r') as f:
        json_data=json.loads(f.read())

#print(json_data)

queue_list= json_data['queues']
#print(queue_list)

filtered_queue_list = [record for record in queue_list if not list(record.values())[0].startswith('rpc')]
#print(filtered_queue_list)

exchange_list=json_data['exchanges']
#print(exchange_list)

binding_list=json_data['bindings']
#print(binding_list)

filtered_binding_list = [record for record in binding_list if not list(record.values())[0].startswith('nameko')]
#print(filtered_binding_list)

filtered_binding_list1 = [record for record in filtered_binding_list if not record.get("destination", "").startswith("kvfin")]
#print(filtered_binding_list1)

filtered_binding_list2 = [record for record in filtered_binding_list1 if not record.get("destination", "").startswith("kv")]

filtered_binding_list3 = [record for record in filtered_binding_list2 if not record.get("destination", "").startswith("agreement")]

filtered_binding_list4 = [record for record in filtered_binding_list3 if not record.get("destination", "").startswith("sps")]

filtered_binding_list5 = [record for record in filtered_binding_list4 if not record.get("destination", "").startswith("sho")]

filtered_binding_list6 = [record for record in filtered_binding_list5 if not record.get("destination", "").startswith("ptr")]

filtered_binding_list7 = [record for record in filtered_binding_list6 if not record.get("destination", "").startswith("shareholders")]

filtered_binding_list8 = [record for record in filtered_binding_list7 if not record.get("destination", "").startswith("po")]

filtered_binding_list9 = [record for record in filtered_binding_list8 if not record.get("destination", "").startswith("pa")]

filtered_binding_list10 = [record for record in filtered_binding_list9 if not record.get("destination", "").startswith("inv")]

filtered_binding_list11 = [record for record in filtered_binding_list10 if not record.get("destination", "").startswith("nclt")]

filtered_binding_list12 = [record for record in filtered_binding_list11 if not record.get("destination", "").startswith("multidoc")]

filtered_binding_list13 = [record for record in filtered_binding_list12 if not record.get("destination", "").startswith("mcaf")]

filtered_binding_list14 = [record for record in filtered_binding_list13 if not record.get("destination", "").startswith("frm")]

filtered_binding_list15 = [record for record in filtered_binding_list14 if not record.get("destination", "").startswith("cam")]

filtered_binding_list16 = [record for record in filtered_binding_list15 if not record.get("destination", "").startswith("bst")]

filtered_binding_list17 = [record for record in filtered_binding_list16 if not record.get("destination", "").startswith("bank_reference_letter")]
#print(filtered_binding_list17)





final_json={"queues":filtered_queue_list,"exchanges":exchange_list,"bindings":filtered_binding_list17}
#print(final_json) 


with open("queueconfigdetails-final"+".json",'w',encoding='utf-8') as f:
            json.dump(final_json,f,ensure_ascii=False) 