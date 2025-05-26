f = open("새파일.txt", 'wt', encoding="UTF-8")
for i in range(1, 11):
    date = "%d번째 줄 입니다.\n" % i
    f.write(date)
f.close() 