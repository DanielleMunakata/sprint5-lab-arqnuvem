import boto3, pandas as pd, os

bucket = "lab-sprint5-arqnuvem-danielle19out2025"  # coloque seu bucket correto
s3 = boto3.client("s3")
local = "/data/raw/sales.csv"  # arquivo local a ser enviado

# RAW
s3.upload_file(local, bucket, "raw/sales.csv")

# TRUSTED
df = pd.read_csv(local).dropna()
df.columns = [c.strip().lower().replace(" ", "_") for c in df.columns]
df.to_csv("/data/trusted/trusted_sales.csv", index=False)
s3.upload_file("/data/trusted/trusted_sales.csv", bucket, "trusted/sales.csv")

# CLIENT
client = df[['order_id','amount']]
client.to_csv("/data/client/client_sales.csv", index=False)
s3.upload_file("/data/client/client_sales.csv", bucket, "client/sales.csv")

print("Pipeline executado com sucesso!")
