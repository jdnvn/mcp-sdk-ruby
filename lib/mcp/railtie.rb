# In your gem's lib/mcp/railtie.rb
module MCP
  class Railtie < Rails::Railtie
    initializer 'mcp.inflections' do
      ActiveSupport::Inflector.inflections(:en) do |inflect|
        inflect.acronym 'MCP'
      end
    end
  end
end
