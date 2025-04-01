module Mcp
  module Server
    class RequestHandler
      def handle_request(request)
        handler = Mcp::Server.request_handlers[request["method"]]
        result = handler ? handler.call(request["params"]) : handle_default(request)

        response = {"jsonrpc": "2.0", "result": result}
        response["id"] = request["id"] if request["id"]

        response
      end

      def handle_default(request)
        case request["method"]
        when "tools/list"
          {
            "tools": Mcp::Server.tools.map { |k, v| v.show },
            "nextCursor": "next-page-cursor" # TODO: pagination
          }
        when "tools/call"
          tool_name = request["params"]["name"]
          tool = Mcp::Server.tools[tool_name.to_sym]
          tool.call(request["params"]["arguments"])
        when "resources/templates/list"
          {
            "resourceTemplates": Mcp::Server.resource_templates.map { |k, v| v.show }
          }
        else
          # BUG
          { "method": request["method"]}
        end
      end
    end
  end
end