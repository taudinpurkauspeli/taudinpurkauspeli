require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html, :json
  around_action :log_request, if: :current_user_is_student_in_production

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
    if current_user.nil?
      respond_to do |format|
        format.html { redirect_to exercises_path, alert: "Toiminto vaatii sisäänkirjautumisen"}
        format.json { head :unauthorized }
      end
    end
  end

  def ensure_user_is_admin
    unless current_user.try(:admin)
      respond_to do |format|
        format.html {redirect_to exercises_path, alert: "Sinulla ei ole toimintoon vaadittavia käyttöoikeuksia" }
        format.json { head :forbidden }
      end
    end
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

  def set_current_user
    @current_user = current_user
  end

  private

  def log_request

    new_log_entry = LogEntry.new

    new_log_entry.user_id = current_user.id
    new_log_entry.controller = params[:controller]
    new_log_entry.action = params[:action]

    compressed_params = YAML::dump(params)
    new_log_entry.params = compressed_params

    new_log_entry.exercise_id = session[:exercise_id]
    new_log_entry.task_id = session[:task_id]

    compressed_exhyp_ids = YAML::dump(session[:exhyp_ids])
    new_log_entry.exhyp_ids = compressed_exhyp_ids

    new_log_entry.datetime = DateTime.current
    new_log_entry.request_path = request.url
    new_log_entry.ip = request.ip
    new_log_entry.method = request.method

    yield

    new_log_entry.response_path = response.location
    new_log_entry.flash_notice = flash[:notice]
    new_log_entry.flash_alert = flash[:alert]

    new_log_entry.save

  end

  def current_user_is_student_in_production
    if Rails.env.production?
      user = current_user
      if  user.nil? || user.admin || Rails.env.test?
        return false
      end
      return true
    end
    return false
  end

  protected

  def json_request?
    request.format.json?
  end
end
