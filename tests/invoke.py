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

def SaveResults(method, df):
    df.to_csv(f"{csv}\\{method}.csv", index=False)

    df.plot(kind='line',    
            x='x',
            y='y')

    plt.savefig(f"{jpg}\\{method}.jpg")
    