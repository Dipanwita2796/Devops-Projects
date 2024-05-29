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

po_base_path="./exceptiondata"
po_json_name="exceptiondata.json"




def po_exceptiondata():
    podf=df[df["Doctype"]=="PO"]
    row_count=len(podf.index)
    with open(po_json_name, 'r') as f:
        po=json.loads(f.read())
    for j in range(row_count):
        if (podf["exception_status"].iloc[j]=="YES"):
            my_dict={}
            my_dict['doctype']=podf["Doctype"].iloc[j]
            my_dict['dmscode']=podf["dmscode"].iloc[j]
            my_dict['exceptiondetails']=[]
            my_dict['extrainfos']={}
            my_dict['version']={"$numberLong": "0"}
            exceptiondetails_dict={}
            exceptiondetails_dict['typeid']=podf["typeid"].iloc[j]
            exceptiondetails_dict['exceptions']=[]
            exception_dict={}
            exception_dict['ruleid']=podf["ruleid"].iloc[j]
            exception_dict['displaykeys']=[podf["displaykeys"].iloc[j]]
            exception_dict['exceptionmsg']=podf["exceptionmsg"].iloc[j]
            exceptiondetails_dict['exceptions'].append(exception_dict)

            my_dict['exceptiondetails'].append(exceptiondetails_dict)

           
            po[0]["affecteddocs"].append(my_dict)

    with open(po_base_path+"/"+"exceptiondata"+".json",'w',encoding='utf-8') as f:
        json.dump(po,f,ensure_ascii=False)           
    return True




po_exceptiondata()