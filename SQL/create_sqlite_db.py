import os
import pandas as pd
import sqlite3

# Определяем абсолютный путь до файла CSV
BASE_DIR = os.path.dirname(os.path.abspath(__file__))  # директория скрипта
csv_path = os.path.join(BASE_DIR, '..', 'data', 'AB_NYC_2019.csv')
db_path = os.path.join(BASE_DIR, '..', 'data', 'airbnb.db')

df = pd.read_csv(csv_path)

conn = sqlite3.connect(db_path)
df.to_sql('airbnb', conn, if_exists='replace', index=False)
conn.close()

print("База данных успешно создана.")
