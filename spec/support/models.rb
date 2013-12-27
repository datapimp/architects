class Person < ActiveRecord::Base
  belongs_to :parent, :class_name => "Person", :foreign_key => :parent_id

  before_save :defaults

  class << self
    attr_accessor :legit_tracker
  end

  self.legit_tracker = 0

  def defaults
    self.legit = (self.class.legit_tracker % 2 == 0)
    self.class.legit_tracker += 1
  end
end

Dir[File.expand_path('../../blueprints/*.rb', __FILE__)].each do |f|
  require f
end

class Models
  def self.make
    10.times do 
      Person.make  
    end
  end
end