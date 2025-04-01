module MCP
  module Server
    class ResourceTemplate
      attr_reader :uri_template, :name, :description, :mime_type, :handler

      def initialize(uri_template, name = nil, description = nil, mime_type = nil, &handler)
        @uri_template = uri_template
        @name = name
        @description = description
        @mime_type = mime_type
        @handler = handler
      end

      def handler(&block)
        @handler = block
      end

      def name(value)
        @name = value
      end

      def description(value)
        @description = value
      end

      def mime_type(value)
        @mime_type = value
      end

      def show
        {
          "uriTemplate": uri_template,
          "name": @name,
          "description": @description,
          "mimeType": @mime_type
        }
      end
    end
  end
end
