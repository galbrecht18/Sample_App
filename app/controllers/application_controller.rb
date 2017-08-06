class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #add basic html so we can set the home page to this and thus we can avoid error on heroku
  def hello
    render html: "Hello world!"
  end

end
