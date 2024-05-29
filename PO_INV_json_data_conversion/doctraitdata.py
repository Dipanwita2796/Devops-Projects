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

po_base_path="./doctrait"
po_json_name="doctraitdata.json"
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



def doctraitdata():
    podf=df[df["Doctype"]=="PO"]
    row_count=len(podf.index)
    with open(po_json_name, 'r') as f:
        po=json.loads(f.read())
    print(po)
    podf["contract_start_date"]=pd.to_datetime(podf['contract_start_date'], format='%d/%m/%y').dt.strftime('%d/%m/%Y')
    podf["contract_end_date"]=pd.to_datetime(podf['contract_end_date'], format='%d/%m/%y').dt.strftime('%d/%m/%Y')
    podf["purchase_order_date"]=pd.to_datetime(podf['purchase_order_date'], format='%d/%m/%y').dt.strftime('%d/%m/%Y')
    # print(podf["purchase_order_date"])
    l=[]
    for j in range(row_count):
        po[0]["dmscode"]=podf["dmscode"].iloc[j]
        #po[0]["tenantid"]=podf["tenantid"].iloc[j]
        po[0]["metadata"]["vendordetails"]["vendorgroupname"]=podf["vendorgroupname"].iloc[j]
        po[0]["metadata"]["vendordetails"]["vendorgroupid"]=podf["vendorgroupid"].iloc[j]
        po[0]["metadata"]["vendordetails"]["vendorentityname"]=podf["vendorentityname"].iloc[j]
        po[0]["metadata"]["vendordetails"]["vendorentityid"]=podf["vendorentityid"].iloc[j]
        po[0]["metadata"]["vendordetails"]["vendorcountry"]=podf["vendorcountry"].iloc[j]
        po[0]["metadata"]["vendordetails"]["vendorcurrency"]=podf["vendorcurrency"].iloc[j]
        po[0]["metadata"]["vendordetails"]["vendorcurrency"]=podf["vendorcurrency"].iloc[j]
        po[0]["metadata"]["spend_sub_category"]=podf["spend_sub_category"].iloc[j]
        po[0]["metadata"]["receiver_name"]=podf["legal_entity"].iloc[j]
        po[0]["metadata"]["cost_centre"]=podf["cost_centre"].iloc[j]


        

        if podf["bf_level"].iloc[j]==4:
            l=[]
            l.append(po[0]["metadata"]["levels"][0])
            po[0]["metadata"]["levels"]=l
            po[0]["metadata"]["levels"].append({"_id":str(podf["bf_code"].iloc[j]), "level":"4", "name":str(podf["bf_name"].iloc[j])})
        elif podf["bf_level"].iloc[j]==5:
            l=[]
            l.append(po[0]["metadata"]["levels"][0])
            po[0]["metadata"]["levels"]=l
            xls2 = pd.ExcelFile('BF_Levels_for_Drop_Down.xlsx')
            df_bf = pd.read_excel(xls2, 'bf_mapping')
            bf_code_list=df_bf["bflevel_5_id"].values.tolist()
            if podf["bf_code"].iloc[j] in bf_code_list:
                row_num=bf_code_list.index(podf["bf_code"].iloc[j])
                level4={}
                level4["_id"]=str(df_bf["bflevel_4_id"].iloc[row_num])
                level4["level"]="4"
                level4["name"]=str(df_bf["bflevel_4"].iloc[row_num])
                po[0]["metadata"]["levels"].append(level4)
                level5={}
                level5["_id"]=str(df_bf["bflevel_5_id"].iloc[row_num])
                level5["level"]="5"
                level5["name"]=str(df_bf["bflevel_5"].iloc[row_num])
                po[0]["metadata"]["levels"].append(level5)
        else:
            l=[]
            l.append(po[0]["metadata"]["levels"][0])
            po[0]["metadata"]["levels"]=l
        with open(po_base_path+"/"+str(podf["dmscode"].iloc[j])+"_"+"po_kvdata"+".json",'w',encoding='utf-8') as f:
            json.dump(po,f,ensure_ascii=False)           
    return True


doctraitdata()