class Object
  def reload!
    require 'machinist/active_record'
    require 'sham'
    require 'faker'

    require File.expand_path('../support/schema.rb', __FILE__)
    require File.expand_path('../support/models.rb', __FILE__)

    require 'smooth'

    true
  end
end

reload!

