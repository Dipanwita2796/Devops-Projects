import json
import os
import pandas as pd
import numpy as np
import math


xls = pd.ExcelFile('Staticdata_v12-13092023 1.xlsx')
df1 = pd.read_excel(xls, 'static_data')
df= df1.replace(np.nan, '', regex=True)
df.columns = df.iloc[0]
df = df[1:]
print(df.columns)

po_base_path="./kvdata"
po_json_name="kvdata.json"
#inv_base_path="./invoicedata"
#inv_json_name="invoice.json"

# c=['dmscode', 'Doctype', 'sowid', 'contractname', 'coupacontractid',
#        'parentcontractname', 'internalcoupacontractid', 'bf_level', 'bf_name',
#        'bf_code', 'engagementtype', 'engagementrisk', 'purchase_id',
#        'currency', 'country', 'cost_centre', 'spend_sub_category',
#        'legal_entity', 'contract_start_date', 'contract_end_date',
#        'purchase_order_date', 'net_amount', 'report_value', 'referenceid',
#        'vendorgroupname', 'vendorgroupid', 'vendorentityname',
#        'vendorentityid', 'vendorcountry', 'vendorcurrency']



def po_mapping():
    podf=df[df["Doctype"]=="PO"]
    row_count=len(podf.index)
    # with open(po_json_name, 'r') as f:
    #     po=json.loads(f.read()) 
    po = json.load(open(po_json_name, "r"))
    podf["contract_start_date"]=pd.to_datetime(podf['contract_start_date'], format='%d/%m/%y').dt.strftime('%d/%m/%Y')
    podf["contract_end_date"]=pd.to_datetime(podf['contract_end_date'], format='%d/%m/%y').dt.strftime('%d/%m/%Y')
    podf["purchase_order_date"]=pd.to_datetime(podf['purchase_order_date'], format='%d/%m/%y').dt.strftime('%d/%m/%Y')
    # print(podf["purchase_order_date"])
    l=[]
    for j in range(row_count):
        po[0]["dmscode"]=podf["dmscode"].iloc[j]
        po[0]["sowid"]=podf["sowid"].iloc[j]
        po[0]["internalsowid"]=podf["internalsowid"].iloc[j]
        po[0]["internalid"]=podf["internalid"].iloc[j]
        po[0]["vendordetails"]["vendorgroupname"]=podf["vendorgroupname"].iloc[j]
        po[0]["vendordetails"]["vendorgroupid"]=podf["vendorgroupid"].iloc[j]
        po[0]["vendordetails"]["vendorentityname"]=podf["vendorentityname"].iloc[j]
        po[0]["vendordetails"]["vendorentityid"]=podf["vendorentityid"].iloc[j]
        po[0]["vendordetails"]["vendorcountry"]=podf["vendorcountry"].iloc[j]
        po[0]["vendordetails"]["vendorcurrency"]=podf["vendorcurrency"].iloc[j]
        po[0]["docuploadtimestamp"]["$numberLong"]=str(podf["contract_start_date_epoch"].iloc[j])
        po[0]["updatedat"]["$numberLong"]=str(podf["contract_end_date_epoch"].iloc[j])
        po[0]["documentdate"]["$numberLong"]=str(podf["purchase_order_date_epoch"].iloc[j])

        if podf["bf_level"].iloc[j]==4:
            l=[]
            l.append(po[0]["levels"][0])
            po[0]["levels"]=l
            po[0]["levels"].append({"_id":str(podf["bf_code"].iloc[j]), "level":"4", "name":str(podf["bf_name"].iloc[j])})
        elif podf["bf_level"].iloc[j]==5:
            l=[]
            l.append(po[0]["levels"][0])
            po[0]["levels"]=l
            xls2 = pd.ExcelFile('BF_Levels_for_Drop_Down.xlsx')
            df_bf = pd.read_excel(xls2, 'bf_mapping')
            bf_code_list=df_bf["bflevel_5_id"].values.tolist()
            if podf["bf_code"].iloc[j] in bf_code_list:
                row_num=bf_code_list.index(podf["bf_code"].iloc[j])
                level4={}
                level4["_id"]=str(df_bf["bflevel_4_id"].iloc[row_num])
                level4["level"]="4"
                level4["name"]=str(df_bf["bflevel_4"].iloc[row_num])
                po[0]["levels"].append(level4)
                level5={}
                level5["_id"]=str(df_bf["bflevel_5_id"].iloc[row_num])
                level5["level"]="5"
                level5["name"]=str(df_bf["bflevel_5"].iloc[row_num])
                po[0]["levels"].append(level5)
        else:
            l=[]
            l.append(po[0]["levels"][0])
            po[0]["levels"]=l
            
        for i in range(len(po[0]["elements"])):
            
            if po[0]["elements"][i]["fieldname"]=="contract_number":
                po[0]["elements"][i]["value"]=podf["sowid"].iloc[j]

            if po[0]["elements"][i]["fieldname"]=="purchase_id":
                po[0]["elements"][i]["value"]=podf["purchase_id"].iloc[j]
             
            if po[0]["elements"][i]["fieldname"]=="currency":
                po[0]["elements"][i]["value"]=podf["currency"].iloc[j]
                
            if po[0]["elements"][i]["fieldname"]=="country_legal_entity":
                po[0]["elements"][i]["value"]=podf["country"].iloc[j]
                
            if po[0]["elements"][i]["fieldname"]=="net_amount":
                po[0]["elements"][i]["value"]=podf["net_amount"].iloc[j]
                
            if po[0]["elements"][i]["fieldname"]=="report_value":
                po[0]["elements"][i]["value"]=podf["report_value"].iloc[j]
                
            if po[0]["elements"][i]["fieldname"]=="cost_centre":
                po[0]["elements"][i]["value"]=podf["cost_centre"].iloc[j]
                
            if po[0]["elements"][i]["fieldname"]=="spend_sub_category":
                po[0]["elements"][i]["value"]=podf["spend_sub_category"].iloc[j]
                
            if po[0]["elements"][i]["fieldname"]=="receiver_name":
                po[0]["elements"][i]["value"]=podf["legal_entity"].iloc[j]
                
            if po[0]["elements"][i]["fieldname"]=="supplier_name":
                po[0]["elements"][i]["value"]=podf["vendorentityname"].iloc[j]
            
            if po[0]["elements"][i]["fieldname"]=="rtb-percentage_5152ede3-7b9f-481a-9765-e881f0735866":
                po[0]["elements"][i]["value"]=podf["RTB"].iloc[j]

            if po[0]["elements"][i]["fieldname"]=="ctb-percentage_5152ede3-7b9f-481a-9765-e881f0735866":
                po[0]["elements"][i]["value"]=podf["CTB"].iloc[j]

            if po[0]["elements"][i]["fieldname"]=="contract_start_date":
                po[0]["elements"][i]["value"]=podf["contract_start_date"].iloc[j]
                
            if po[0]["elements"][i]["fieldname"]=="contract_end_date":
                po[0]["elements"][i]["value"]=podf["contract_end_date"].iloc[j]
                
            if po[0]["elements"][i]["fieldname"]=="vendor_name":
                po[0]["elements"][i]["value"]=podf["vendorentityname"].iloc[j]
                
            if po[0]["elements"][i]["fieldname"]=="purchase_order_date":
                po[0]["elements"][i]["value"]=podf["purchase_order_date"].iloc[j]
                continue
        with open(po_base_path+"/"+str(podf["dmscode"].iloc[j])+"_"+"po_kvdata"+".json",'w',encoding='utf-8') as f:
            json.dump(po,f,ensure_ascii=False)           
    return True



# def invoice_mapping():
#     invdf=df[df["doctype"]=="INV"]
#     row_count=len(invdf.index)
#     with open(inv_json_name, 'r') as f:
#         invoice=json.loads(f.read())
#     invdf["invoice_date"]=pd.to_datetime(invdf["invoice_date"], format='%d/%m/%y').dt.strftime('%d/%m/%Y')
#     for j in range(row_count):
#         invoice[0]["dmscode"]=invdf["dmscode"].iloc[j]
#         invoice[0]["vendordetails"]["vendorgroupname"]=invdf["vendorgroupname"].iloc[j]
#         invoice[0]["vendordetails"]["vendorgroupid"]=invdf["vendorgroupid"].iloc[j]
#         invoice[0]["vendordetails"]["vendorentityname"]=invdf["vendorentityname"].iloc[j]
#         invoice[0]["vendordetails"]["vendorentityid"]=invdf["vendorentityid"].iloc[j]
#         invoice[0]["vendordetails"]["vendorcountry"]=invdf["vendorcountry"].iloc[j]
#         invoice[0]["vendordetails"]["vendorcurrency"]=invdf["vendorcurrency"].iloc[j]
#         invoice[0]["internalid"]=invdf["internalid"].iloc[j]
#         invoice[0]["docuploadtimestamp"]["$numberLong"]=str(invdf["contract_start_date_epoch"].iloc[j])
#         invoice[0]["updatedat"]["$numberLong"]=str(invdf["contract_end_date_epoch"].iloc[j])
#         invoice[0]["documentdate"]["$numberLong"]=str(invdf["invoice_date_epoch"].iloc[j])
        
#         for i in range(len(invoice[0]["elements"])):
            
#             if invoice[0]["elements"][i]["fieldname"]=="invoice_id":
#                 invoice[0]["elements"][i]["value"]=invdf["invoice_id"].iloc[j]

#             if invoice[0]["elements"][i]["fieldname"]=="purchase_id":
#                 invoice[0]["elements"][i]["value"]=invdf["purchase_id"].iloc[j]
             
#             if invoice[0]["elements"][i]["fieldname"]=="invoice_date":
#                 invoice[0]["elements"][i]["value"]=invdf["invoice_date"].iloc[j]

#             if invoice[0]["elements"][i]["fieldname"]=="report_value":
#                 invoice[0]["elements"][i]["value"]=invdf["report_value"].iloc[j]
                
#             if invoice[0]["elements"][i]["fieldname"]=="net_amount":
#                 invoice[0]["elements"][i]["value"]=invdf["invoice_amount"].iloc[j]
                
#             if invoice[0]["elements"][i]["fieldname"]=="supplier_name":
#                 invoice[0]["elements"][i]["value"]=invdf["vendorentityname"].iloc[j]
                
#             if invoice[0]["elements"][i]["fieldname"]=="receiver_name":
#                 invoice[0]["elements"][i]["value"]=invdf["legal_entity"].iloc[j]
                
#             if invoice[0]["elements"][i]["fieldname"]=="vendor_name":
#                 invoice[0]["elements"][i]["value"]=invdf["vendorentityname"].iloc[j]

#             if invoice[0]["elements"][i]["fieldname"]=="gross_amount":
#                 invoice[0]["elements"][i]["value"]=invdf["invoice_amount"].iloc[j]
#                 continue
#         with open(inv_base_path+"/"+str(invdf["dmscode"].iloc[j])+"_"+"invoice"+".json",'w',encoding='utf-8') as f:
#             json.dump(invoice,f,ensure_ascii=False)           
#     return True

po_mapping()
#invoice_mapping()