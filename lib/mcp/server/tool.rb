module MCP
  module Server
    class Tool
      attr_accessor :name, :description, :parameters

      def initialize(name, description = nil, parameters = {}, &handler)
        @name = name
        @description = description
        @parameters = parameters
        @required_parameters = []
        @handler = handler
      end

      def call(input)
        # TODO: validate and handle errors
        output = @handler.call(input)
  
        {
          "content": [
            {
              "type": "text",
              "text": output
            }
          ]
        }
      end

      def parameter(name, type:, description: nil, required: false)
        @parameters[name.to_sym] = { "type": type }.tap do |param|
          param["description"] = description if description
        end
        @required_parameters << name.to_sym if required
      end

      def description(value)
        @description = value
      end

      def handler(&block)
        @handler = block
      end

      def show
        {
          name: @name,
          description: @description,
          inputSchema: input_schema
        }
      end

      private

      def input_schema
        {
          "type": "object",
          "properties": @parameters,
          "required": @required_parameters
        }
      end
    end
  end
end
