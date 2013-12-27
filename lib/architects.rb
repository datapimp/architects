require 'active_support'
require 'active_support/core_ext'

module Architects
  extend ActiveSupport::Autoload

  require 'architects/railtie' if defined?(::Rails)

  include ActiveSupport::JSON

  eager_autoload do
    autoload :Configuration
  end

  autoload :DSL

  def self.configuration
    @configuration ||= Configuration.new
  end
end
