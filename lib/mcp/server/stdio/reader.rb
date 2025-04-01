# frozen_string_literal: true

require "json"

module Mcp
  module Server
    module Stdio
      class Reader
        def initialize(io = STDIN)
          @io = io
          io.binmode
        end

        def read(&block)
          while (buffer = io.gets)
            next unless (content_length_header = buffer.match(/Content-Length: (\d+)/i))

            content_length = content_length_header[1].to_i
            io.gets
            request_bytes = io.read(content_length)
            request = JSON.parse(request_bytes, symbolize_names: true)
            return block.call(request)
          end
        end

        def close
          io.close
        end

        private

        attr_reader :io
      end
    end
  end
end
