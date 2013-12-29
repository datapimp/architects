class Architects::ScreensController < ActionController::Base
  helper_method :docs

  def index
    render "architects/screen/index", layout: "architects/application"
  end

  def show
    @screen = docs.find_screen(params[:id])
    render "architects/screens/show", layout: "architects/application"
  end

  protected

  def docs
    @docs ||= Architects::Docs
  end

end
