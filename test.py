from tests.invoke import Invoke, Method
from tests.float import ToString
import math
import os
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.metrics import mean_squared_error

csv = ".\\output\\csv\\test_result.csv"

if os.path.isfile(csv):
    os.remove(csv)

x = -2.0
while x <= 2.0:
    print(x)
    Invoke(Method.sin, x)
    x += 0.5

df = pd.read_csv(csv, header=None, dtype={"X": str, "Y": str}, converters={i: str for i in range(2)})
df.columns = ["X", "Y"]

df["fX"] = df.apply(lambda row: float(ToString(row.X)), axis = 1)
df["fY"] = df.apply(lambda row: float(ToString(row.Y)), axis = 1)

df.sort_values("fX")

df["Xc"] = df.apply(lambda row: math.sin(row.fX), axis = 1)

# print(df.head())

df.plot(kind='line',    
        x='fX',
        y='fY')

plt.savefig(".\\output\\plots\\test.jpg")

mse = mean_squared_error(df["Xc"], df["fY"])

print(mse)