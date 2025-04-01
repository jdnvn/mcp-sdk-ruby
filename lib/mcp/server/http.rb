require 'json'

module Mcp
  module Server
    class Http
      def initialize
        @request_handler = RequestHandler.new
      end

      def call(env)
        req = Rack::Request.new(env)
        path = req.path_info

        case path
        when "/sse"
          sse(env)
        end
      end

      private
      
      def sse(env)
        body = env['rack.input'].read

        begin
          request = JSON.parse body
        rescue JSON::ParserError
          return [400, {"content-type" => "application/json"}, [{"message": "Bad Request"}.to_json]]
        end

        response = @request_handler.handle_request(request)

        [200, { "content-type" => "application/json" }, [response.to_json]]
      end
    end
  end
end
