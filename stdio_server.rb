require 'mcp-sdk' # Assuming your application is in app.rb

Mcp::Server.configure do
  tool :sup do
    parameter :hey, type: :string, required: true
    parameter :yo, type: :boolean, description: "Suh dude"

    handler do |input|
      "you said '#{input["hey"]}'"
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

Mcp::Server.stdio