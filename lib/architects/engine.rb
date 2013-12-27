module Architects
  class Engine < ::Rails::Engine
    isolate_namespace Architects

    initializer :assets, group: :all do |app|
      # default the root if it's not set
      Architects.configuration.root ||= app.root
    end

    config.after_initialize do |app|
      # prepend routes so a catchall doesn't get in the way
      if Architects.configuration.mount_at.present?
        app.routes.prepend do
          mount Architects::Engine => Architects.configuration.mount_at
        end
      end
    end

  end
end

