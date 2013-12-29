Architects::Engine.routes.draw do
  root :to => "home#index", :as => :architects_home
  get "/docs", :to => "docs#index", :as => :architects_docs
  get "/docs/*id", :to => "docs#show", :as => :architects_doc
  get "/screens", :to => "screens#index", :as => :architects_screens
  get "/screens/*id", :to => "screens#show", :as => :architects_screen
end
