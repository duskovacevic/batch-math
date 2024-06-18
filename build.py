import os.path

src = ".\\src"
output = ".\\output\\math.cmd"

if os.path.isfile(output):
    os.remove(output)

with open(f"{src}\\constants.cmd") as f:
    lines = f.readlines()

constants = [lines[0]]
for line in lines[1:]:
    constants.append(f"\t{line}")

with open(f"{src}\\main.cmd") as f:
    content = f.read()

content = content.replace("%%CONSTANTS%%", "".join(constants))

with open(output, "w") as f:
    f.write(content)

folders = ["math", "math\\cordic", "float"]

for folder in folders:
    for name in os.listdir(f"{src}\\{folder}"):
        if not name.endswith('.cmd'): continue
        
        with open(f"{src}\\{folder}\\{name}") as f:
            lines = f.readlines()
        
        code = []
        for line in lines:
            if not "@echo" in line and "echo" in line:
                code.append(line.replace("echo", f"echo %_c%[{name}][line {len(code) + 1}]%_r%"))
            else:
                code.append(line)

        with open(output, "a") as f:
            f.write("\n\n")
            f.write("".join(code))

print("Built.")