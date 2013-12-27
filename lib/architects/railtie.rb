module Architects
  class Railtie < ::Rails::Railtie
    rake_tasks do
      load "tasks/architects.rake"
    end
  end
end

