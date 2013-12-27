require "singleton"

module Architects
  class Configuration
    include Singleton

    cattr_accessor :mount_at, :root, :doc_path, :title, :layout
    @@mount_at     = "/api/features"
    @@root         = nil # will default to Rails.root if left unset
    @@doc_path     = 'doc/architects'
    @@title        = 'Architects Documentation'
    @@layout       = 'architects/application'

    def self.root=(path)
      @@root = Pathname.new(path.to_s) if path.present?
    end
  end

  mattr_accessor :configuration
  @@configuration = Configuration

  def self.setup
    yield @@configuration
  end
end

