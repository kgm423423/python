from socket import *

clientSock = socket(AF_INET, SOCK_STREAM)
clientSock.connect(("127.0.0.1", 8080))

print("연결됨")
clientSock.send("I am a client".encode("utf-8"))

print("메시지 전송됨")

data = clientSock.recv(1024)
print("받은 데이터 : ", data.decode("utf-8"))