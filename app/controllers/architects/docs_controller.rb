class Architects::DocsController < ActionController::Base
  helper_method :api_docs

  def index
    render "architects/docs/index", layout: "architects/application"
  end

  def show
    @example = api_docs.find_example(params[:id])
    render "architects/docs/show", layout: "architects/application"
  end

  protected

  def api_docs
    @api_docs ||= Architects::ApiDocs
  end

end
