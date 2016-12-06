require 'socket'

hostname = 'localhost'
port = 2000
path = "index.html"

s = TCPSocket.open(hostname, port, path)

while line = s.gets
  puts line.chop
end
s.close
