from subprocess import Popen, PIPE
from tests.float import Set
from enum import Enum

class Method(Enum):
    sin = 1
    cos = 2
    tan = 3

def Invoke(method : Method, value : float) -> float:
    p = Popen([f"tests\\runner.cmd", f":{method.name}", Set(str(value))], cwd = ".", stdout = PIPE)
    p.wait()
    