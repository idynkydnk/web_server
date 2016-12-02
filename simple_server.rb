require 'socket'

server = TCPServer.open(2000)
loop {
  client = server.accept
  request = client.gets.chomp
  parts = request.split(" ")
  if parts[0] == "GET"
    client.puts "it worked!"
  end
  client.puts(Time.now.ctime)
  client.puts "Closing the connection. Bye!"
  client.close
}

