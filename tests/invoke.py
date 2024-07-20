import subprocess
import time
import pandas as pd
import matplotlib.pyplot as plt
from tests.float import Set, ToString

command = "output\\math.cmd"
csv = ".\\output\\csv"
jpg = ".\\output\\plots"

def Invoke(method: str, start: float, end: float, steps: int, validate):
    processes = set()
    max_processes = 5

    step = (end - start) / steps

    data = []

    for i in range(steps):
        j = "{:.3f}".format(start + i * step)
        processes.add(subprocess.Popen([command, f":{method}", j], cwd = ".", stdout = subprocess.PIPE))
        while len(processes) >= max_processes:
            time.sleep(2)
            for p in processes:
                output = p.stdout.readline()
                if output:
                    x, y = output.decode().strip().split(",")
                    fX = float(x)
                    fY = float(y)
                    data.append([fX, fY, validate(fX)])
                    print(f"{method}({x}) = {y} should be {validate(fX)}")
            processes.difference_update([
                p for p in processes if p.poll() is not None])
    
    while len(processes) > 0:
        time.sleep(2)
        for p in processes:
            output = p.stdout.readline()
            if output:
                x, y = output.decode().strip().split(",")
                fX = float(x)
                fY = float(y)
                data.append([fX, fY, validate(fX)])
                print(f"{method}({x}) = {y} should be {validate(fX)}")
        processes.difference_update([
            p for p in processes if p.poll() is not None])

    df = pd.DataFrame(data, columns =['x', 'y', 'c'])
    df = df.sort_values("x")

    return df

def Invoke2(method: str, x: float, start: float, end: float, steps: int, validate):
    processes = set()
    max_processes = 5

    step = (end - start) / steps

    data = []

    fX = "{:.3f}".format(x)

    for i in range(steps):
        j = "{:.3f}".format(start + i * step)
        processes.add(subprocess.Popen([command, f":{method}", fX, j], cwd = ".", stdout = subprocess.PIPE))
        while len(processes) >= max_processes:
            time.sleep(2)
            for p in processes:
                output = p.stdout.readline()
                if output:
                    x0, x1, y = output.decode().strip().split(",")
                    fX0 = float(x0)
                    fX1 = float(x1)
                    fY = float(y)
                    data.append([fX0, fX1, fY, validate(fX0, fX1)])
                    print(f"{method}({x0}, {x1}) = {y} should be {validate(fX0, fX1)}")
            processes.difference_update([
                p for p in processes if p.poll() is not None])
    
    while len(processes) > 0:
        time.sleep(2)
        for p in processes:
            output = p.stdout.readline()
            if output:
                x0, x1, y = output.decode().strip().split(",")
                fX0 = float(x0)
                fX1 = float(x1)
                fY = float(y)
                data.append([fX0, fX1, fY, validate(fX0, fX1)])
                print(f"{method}({x0}, {x1}) = {y} should be {validate(fX0, fX1)}")
        processes.difference_update([
            p for p in processes if p.poll() is not None])

    df = pd.DataFrame(data, columns =['x0', 'x1', 'y', 'c'])
    df = df.sort_values("x1")

    return df

def SaveResults(method, df):
    df.to_csv(f"{csv}\\{method}.csv", index=False)

    df.plot(kind='line',    
            x='x',
            y='y')

    plt.savefig(f"{jpg}\\{method}.jpg")

def SaveResults2(method, df):
    df.to_csv(f"{csv}\\{method}.csv", index=False)

    df.plot(kind='line',    
            x='x1',
            y='y')

    plt.savefig(f"{jpg}\\{method}.jpg")