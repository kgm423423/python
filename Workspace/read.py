# f = open("C:/Users/human/Desktop/python/Workspace/새파일.txt", 'rt', encoding="UTF-8")
with open("C:/Users/human/Desktop/python/Workspace/새파일.txt", 'rt', encoding="UTF-8") as f:
    while True:
        line = f.readline()
        if not line: break 
        print(line, end="")
# f.close()