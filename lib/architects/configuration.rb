require "singleton"

module Architects
  class Configuration
    include Singleton

    cattr_accessor :mount_at, :root, :doc_path, :title, :layout, :screens_path, :screen_type, :images_path
    @@mount_at     = "/architects"
    @@root         = nil # will default to Rails.root if left unset
    @@screens_path = nil
    @@doc_path     = 'doc/architects'
    @@title        = 'Architects Documentation'
    @@layout       = 'architects/application'
    @@screen_type  = 'iphone'
    @@images_path  = nil

    def self.root=(path)
      @@root = Pathname.new(path.to_s) if path.present?
    end

    def architects_root
      Pathname.new root.join(doc_path).to_s
    end

    def screens_path
      self.class.screens_path ||= architects_root.join("screen_images")
    end
  end

end

