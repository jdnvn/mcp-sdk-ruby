require 'mcp-sdk'

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

  tools [
    MCP::Server::Tool.new("my_cool_tool", "the cooliest", {}) do
      "cool"
    end
  ]

  # list_tools do
  #   [{"name": "cool_tool"}]
  # end
end

run MCP::Server::Http.new
