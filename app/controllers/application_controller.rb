class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # määritellään, että metodit tulevat käyttöön myös näkymissä
  helper_method :current_user
  helper_method :current_user_is_admin

  def current_user
    return nil if session[:user_id].nil? 
    User.find(session[:user_id]) 
  end

  def current_user_is_admin

  	u = current_user
  	unless u.nil?
  		return u.admin
  	end
  	return false


  end
end
