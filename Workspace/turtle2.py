import turtle as t
from enum import Enum
import msvcrt
import time


class Transform:
    posX = 0
    posY = 0
    dir
    speed = 10

t.shape("turtle")
gamePlaying = True
player = Transform()

print("{0} : {1}" .format(player.posX, player.posY))


def playerInput():
    print("입력대기")
    k = input()
    if (k=='w'): player.posY += player.speed
    if (k=='d'): player.posX += player.speed
    if (k=='s'): player.posY -= player.speed
    if (k=='a'): player.posX -= player.speed



while gamePlaying:
    playerInput()
    print("{0} : {1}" .format(player.posX, player.posY))
    t.goto(player.posX, player.posY)




