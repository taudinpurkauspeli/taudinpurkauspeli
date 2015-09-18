require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder

  around_action :say_hi

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # määritellään, että metodit tulevat käyttöön myös näkymissä
  helper_method :current_user
  helper_method :current_task
  helper_method :current_exercise

  def current_exercise
    return nil if session[:exercise_id].nil?
    Exercise.find(session[:exercise_id])
  end

  def current_user
    return nil if session[:user_id].nil?
    User.find(session[:user_id])
  end

  def current_task
    return nil if session[:task_id].nil?
    Task.find(session[:task_id])
  end
  
  def ensure_user_is_logged_in
    redirect_to exercises_path, alert: "Toiminto vaatii sisäänkirjautumisen" if current_user.nil?
  end

  def ensure_user_is_admin
    redirect_to exercises_path, alert: "Sinulla ei ole toimintoon vaadittavia käyttöoikeuksia" unless current_user.try(:admin)
  end

  def get_layout
    if params[:layout] === "false" || params[:layout] == false
      return false
    else
      return true
    end
  end

  def set_view_layout
    if params[:layout] === "false" || params[:layout] == false
      render :layout => false
    end
  end

  private

  def say_hi
    if !current_user.try(:admin)
      logged_item = {}
      logged_item[:user_id] = current_user.id
      logged_item[:controller] = params[:controller]
      logged_item[:action] = params[:action]
      logged_item[:params] = params
      logged_item[:exercise_id] = session[:exercise_id]
      logged_item[:task_id] = session[:task_id]
      logged_item[:exhyp_ids] = session[:exhyp_ids]
      logged_item[:datetime] = DateTime.current
      logged_item[:path] = request.path
      logged_item[:ip] = request.ip
      logged_item[:method] = request.method
    end
    yield
    logged_item[:response] = response.location

    byebug
  end
  
end
