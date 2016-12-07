require 'socket'
require 'json'
require 'erb'

template = File.read "thanks.erb"
erb_template = ERB.new template
id = 0
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
    body = parts[1]
    params = {}
    params = JSON.parse(body)
		form_letter = erb_template.result(binding)
		Dir.mkdir("output") unless Dir.exists? "output"
  	filename = "output/thanks_#{id}.html"
		File.open(filename,"w") do |file|
    	file.puts form_letter
  	end
		id += 1
  end
  client.puts "Closing the connection. Bye!"
  client.close
}

