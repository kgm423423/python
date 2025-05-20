class Position:
    posX:int = 0
    posY:int = 0
    def __init__(self, inputX=0, inputY=0):
        self.posX = inputX
        self.posY = inputY


class Transform(Position):
    rotate:int = 0
    speed = 0 

    def __init__(self, inputX=0, inputY=0, input_rotate=0, input_speed=0):
         self.posX = inputX
         self.posY = inputY
         self.rotate = input_rotate
         self.speed = input_speed

    def hitCheck(self, obj):
        if (isinstance(obj, Position)):
            if (self.posX == obj.posX and self.posY == obj.posY):
                return True
            else:
                return False
            
            
SIZE_MULTIPLES = 25
ENEMY_RESPAWN_DELAY = 10

import turtle as t
import random
t.shape("turtle")
t.penup()

playerPos = Transform(0,0,0,2)

enemyList = []
bulletList = []
gameOver = False
playTime = 0


def turtleMove(turtlePos, inputValue):
    d = int(turtlePos.speed * SIZE_MULTIPLES)
    if (inputValue == 'w'): turtlePos.posY += d ; turtlePos.rotate = 0
    if (inputValue == 'd'): turtlePos.posX += d ; turtlePos.rotate = 1
    if (inputValue == 's'): turtlePos.posY -= d ; turtlePos.rotate = 2
    if (inputValue == 'a'): turtlePos.posX -= d ; turtlePos.rotate = 3


def turtleDraw(turtle):
    turtle[0].goto(turtle[1].posX, turtle[1].posY)
    if (turtle[1].rotate == 0): turtle[0].setheading(90)
    if (turtle[1].rotate == 1): turtle[0].setheading(0)
    if (turtle[1].rotate == 2): turtle[0].setheading(270)
    if (turtle[1].rotate == 3): turtle[0].setheading(180)


def makeEnemy():
    if (playTime % ENEMY_RESPAWN_DELAY == 0):
        x = (random.randint(-10, 10)*SIZE_MULTIPLES)
        y = (random.randint(-10, 10)*SIZE_MULTIPLES)
        r = random.randint(0, 3)
        s = 1 
        enemyTurtle = t.Turtle()
        enemyTurtle.color("red")
        enemyTurtle.penup()
        enemyList.append((enemyTurtle, Transform(x,y,r,s)))


def enemyMove(enemy:Transform):
    if (playerPos.posX < enemy.posX):
        turtleMove(enemy, "a")
    elif(playerPos.posX > enemy.posX):
        turtleMove(enemy, "d")
    elif(playerPos.posY < enemy.posY):
        turtleMove(enemy, "s")
    elif(playerPos.posY > enemy.posY):
        turtleMove(enemy, "w")

    if ( (enemy.posX == playerPos.posX) and (enemy.posY == playerPos.posY) ):
        gameOver = True

    print(f"{playerPos.posX}, {playerPos.posY} | {enemy.posX}, {enemy.posY} ")
    print(gameOver)



# 게임 플레이
while not gameOver:
    # 플레이어 이동
    turtleMove(playerPos, input())
    # 적 이동
    makeEnemy()
    for enemy in enemyList:
        enemyMove(enemy[1])
    # UI 표시
    turtleDraw((t,playerPos))
    for enemy in enemyList:
        turtleDraw(enemy)

        
    playTime += 1

input("종료 대기 ... ")





