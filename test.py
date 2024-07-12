from tests.invoke import Invoke
import math

#Invoke("sin", -math.pi * 2, math.pi * 2, 20, lambda x : math.sin(x))
#Invoke("cos", -math.pi * 2, math.pi * 2, 20, lambda x : math.cos(x))
Invoke("tan", -math.pi * 2, math.pi * 2, 80, lambda x : math.tan(x))

