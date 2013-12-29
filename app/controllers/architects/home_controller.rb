class Architects::HomeController < ActionController::Base
  def index
    render "architects/home/index", layout: "architects/application"
  end
end
