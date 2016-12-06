require 'socket'
require 'json'

server = TCPServer.open(2000)
loop {
  client = server.accept
  request = client.gets.chomp
  parts = request.split(" ")
  if parts[0] == "GET"
    if File.file?(parts[1]) 
      chars = 0
      File.open(parts[1]).each { |line| chars += line.length}
      client.puts "Content-Length: #{chars}"
      client.puts "#{parts[2]} 200 OK"
      client.puts(Time.now.ctime)
      File.open(parts[1]).each { |line| client.puts line }
    else
    client.puts "#{parts[2]} 404 NOT FOUND"
    end
  elsif parts[0] == "POST"
    params = {}
    client.puts parts[1]
  end
  client.puts "Closing the connection. Bye!"
  client.close
}

