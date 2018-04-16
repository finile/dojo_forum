class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_draft


  def current_draft
    @draft
  end

end
