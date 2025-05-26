from socket import *

portNum = 8080

serverSock = socket(AF_INET, SOCK_STREAM)
serverSock.bind(('', 8080))
serverSock.listen(1)

print("%d번 포트로 접속 대기중..." %portNum)

connectionSock, addr = serverSock.accept()

print(str(addr), "에서 접속됨")

data = connectionSock.recv(1024)
print("받은 데이터 : ", data.decode("utf-8"))

connectionSock.send("I am server".encode("utf-8"))
print("메시지 전송됨")

while True:
    sendData = input(">>>")
    connectionSock.send(sendData("UTF-8"))

    recvDate = connectionSock.recv(1024)
    print("상대방 : " , recvDate.decode("UTF-8"))