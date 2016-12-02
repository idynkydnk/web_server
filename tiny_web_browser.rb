require 'socket'

host = 'localhost'
port = 2000
path = "/index.html"

request = "GET #{path} HTTP/1.0\r\n\r\n"

socket = TCPSocket.open(host,port)
socket.print(request)
while line = socket.gets
  puts line.chop
end
socket.close