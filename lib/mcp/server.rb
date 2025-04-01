module MCP
  module Server
    autoload :Configuration, "mcp/server/configuration"
    autoload :Http, "mcp/server/http"

    class << self
      def configure(&block)
        self.instance_eval(&block) if block_given?
      end

      def tools
        @tools ||= {}
      end

      def resource_templates
        @resource_templates ||= {}
      end

      def request_handlers
        @request_handlers ||= {}
      end

      def tool(name, &block)
        tool = Tool.new(name)
        tool.instance_eval(&block)
        tools[name] = tool
      end

      def resource(uri, &block)
        resource_template = ResourceTemplate.new(uri)
        resource_template.instance_eval(&block)
        resource_templates[uri] = resource_template
      end

      def list_tools(&block)
        request_handlers["tools/list"] = block
      end

      def http
        Http.new
      end

      def stdio
        reader = Stdio::Reader.new
        writer = Stdio::Writer.new
        request_handler = RequestHandler.new

        reader.read do |request|
          response = request_handler.handle_request(request)
          writer.write(response)
        end
      end
    end
  end
end
