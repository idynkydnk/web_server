require 'socket'
require 'json'

host = 'localhost'
port = 2000
path = "index.html"

puts "GET or POST?"
method = "POST"

if method == "GET"
  request = "GET #{path} HTTP/1.0\r\n\r\n"
elsif method == "POST"
  puts "Name?"
  name = gets.chomp
  puts "Email?"
  email = gets.chomp
  viking = { :viking => { :name => name, :email => email }}
  viking_json = viking.to_json
  content_length = viking_json.length
  puts content_length
  request = "POST #{viking_json} HTTP/1.0\r\n\r\n" 
end


socket = TCPSocket.open(host,port)
socket.print(request)
while line = socket.gets
  puts line.chop
end
socket.close
