import turtle as t
import math
import random
import sys

MAX_SIZE = 100
t.shape("turtle")
t.speed(0)

while True:
    #1 입력 받기
    while True:
        inputStr = input("input Angle:")

        if (inputStr == "cls"): #지우기
            t.clear()
            continue
        elif(inputStr == "exit"):
            sys.exit("0")
        else:
            try:                #예외 처리
                n = int(inputStr)
                if (n<3):
                    raise Exception()
            except:
                print("입력 오류 재입력")
                continue

        break
    
    sideLen = 2*MAX_SIZE*math.pi/n
    turnAngle = 360/n


    #2 Offset 맞추기
    t.penup()
    t.setx(sideLen/2 * (-1))
    t.pendown()


    #3 그리기
    r = random.randrange(0,3) #색상 랜덤 선택 
    print(r)
    if (r == 0): t.color("red")
    if (r == 1): t.color("green")
    if (r == 2): t.color("blue")

    for i in range(n):
        t.forward(sideLen)
        t.left(turnAngle)


