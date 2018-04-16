class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  def after_sign_in_path_for(resource)
   session.fetch 'user_return_to', new_article_path
  end



end
