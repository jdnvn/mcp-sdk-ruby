require 'mcp-sdk' # Assuming your application is in app.rb

MCP::Server.configure do
  tool :sup do
    parameter :message, type: :string, required: true
    parameter :chill, type: :boolean, description: "Suh dude"

    handler do |input|
      "you said '#{input["message"]}'"
    end
  end

  resource "docx:{path}" do
    name "Docx file"
    description "Lists docx files"
    mime_type "application/octet-stream"

    handler do |path|
      "some document text"
    end
  end

  # list_tools do
  #   [{"name": "cool_tool"}]
  # end
end

run MCP::Server::Http.new
