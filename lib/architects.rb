require 'active_support'
require 'active_support/core_ext'

module Architects
  extend ActiveSupport::Autoload

  require 'architects/railtie' if defined?(::Rails)
  require 'architects/engine' if defined?(::Rails)

  include ActiveSupport::JSON

  eager_autoload do
    autoload :Configuration
    autoload :Version
  end

  mattr_accessor :configuration
  @@configuration = Configuration

  def self.setup
    yield @@configuration
  end

  autoload :Docs
  autoload :ApiDocs

  def self.docs_dir
    Pathname.new(RspecApiDocumentation.configuration.docs_dir.to_s)
  end

  def self.root
    config.architects_root
  end

  def self.config
    configuration
  end

  def self.configuration
    @configuration ||= Configuration.instance
  end
end
