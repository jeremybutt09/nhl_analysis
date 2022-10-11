import cx_Oracle as ora
import pandas as pd

def oracle_select(connection_string, sql_qry):
    """"THIS FUNCTION IS USED TO MAKE A CALL TO AN ORACLE DATABASE"""
    conStr = connection_string
    conn = ora.connect(conStr)
    cur = conn.cursor()
    sqlTxt = sql_qry
    cur.execute(sqlTxt)
    records = cur.fetchall()
    df = pd.DataFrame.from_records(records, columns=[x[0] for x in cur.description])
    cur.close()
    conn.close()
    return df
