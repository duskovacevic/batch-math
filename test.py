from tests.invoke import Invoke, SaveResults
import math

df = Invoke("sin", -math.pi * 2, math.pi * 2, 80, lambda x : math.sin(x))
SaveResults("sin", df)

df = Invoke("cos", -math.pi * 2, math.pi * 2, 80, lambda x : math.cos(x))
SaveResults("cos", df)

df = Invoke("tan", -math.pi * 2, math.pi * 2, 80, lambda x : math.tan(x))
df = df[df.y.lt(10)]
df = df[df.y.gt(-10)]
SaveResults("tan", df)

