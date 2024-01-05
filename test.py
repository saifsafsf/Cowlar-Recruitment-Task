import pandas as pd

df = pd.read_csv('data/customer_dataset.csv')

df['unit_price'] = df['unit_price'].str.replace(pat=',', repl='').astype(float)
df['quantity-price'] = df['quantity'] * df['unit_price']
print(df.groupby('customer_id').sum('quantity-price').sort_values('quantity-price', ascending=False))