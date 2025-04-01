# frozen_string_literal: true

require 'json'

module MCP
  module Server
    module Stdio
      class Writer
        attr_reader :io

        def initialize(io = STDOUT)
          @io = io
          io.binmode
        end

        def write(response)
          response_str = response.to_json

          headers = {
            "Content-Length" => response_str.bytesize
          }

          headers.each do |k, v|
            io.print "#{k}: #{v}\r\n"
          end

          io.print "\r\n"

          io.print response_str

          io.flush
        end

        def close
          io.close
        end
      end
    end
  end
end
