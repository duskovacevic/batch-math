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

df = Invoke("asin", -1, 1, 80, lambda x : math.asin(x))
SaveResults("asin", df)

df = Invoke("acos", -1, 1, 80, lambda x : math.acos(x))
SaveResults("acos", df)

df = Invoke("atan", -4, 4, 80, lambda x : math.atan(x))
SaveResults("atan", df)

df = Invoke("sinh", -4, 4, 80, lambda x : math.sinh(x))
SaveResults("sinh", df)

df = Invoke("cosh", -4, 4, 80, lambda x : math.cosh(x))
SaveResults("cosh", df)

df = Invoke("tanh", -4, 4, 80, lambda x : math.tanh(x))
SaveResults("tanh", df)

df = Invoke("asinh", -4, 4, 80, lambda x : math.asinh(x))
SaveResults("asinh", df)

df = Invoke("acosh", 1, 4, 80, lambda x : math.acosh(x))
SaveResults("acosh", df)

df = Invoke("atanh", -0.975, 0.975, 80, lambda x : math.atanh(x))
SaveResults("atanh", df)