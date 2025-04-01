require 'json'

IO.popen("ruby ./stdio_server.rb", "r+") do |io|
  # Create a proper JSON message
  message = {"jsonrpc": "2.0", "method": "tools/call", "params": {"name": "sup", "arguments": {"message": "hey hey"}}}.to_json

  headers = {
    "Content-Length" => message.bytesize
  }

  headers.each do |k, v|
    io.print "#{k}: #{v}\r\n"
  end

  io.print "\r\n"
  io.print message
  io.flush

  while (buffer = io.gets)
    if (content_length_header = buffer.match(/Content-Length: (\d+)/i))
      content_length = content_length_header[1].to_i
      io.gets
      response = io.read(content_length)
      puts "Received: #{response}"
    end
  end
end
