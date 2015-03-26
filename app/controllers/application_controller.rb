class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # määritellään, että metodit tulevat käyttöön myös näkymissä
  helper_method :current_user
  helper_method :current_task
  helper_method :current_exercise
  helper_method :current_user_is_admin
  helper_method :user_can_start_task
  
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

  def user_can_start_task(user, exercise, level)
    return user.get_number_of_tasks_by_level(exercise, level - 1) == exercise.get_number_of_tasks_by_level(level - 1)
  end

  def current_user_is_admin
  	u = current_user
  	unless u.nil?
  		return u.admin
  	end
  	return false
  end

  def ensure_user_is_logged_in
    redirect_to signin_path, alert: "Toiminto vaatii sisäänkirjautumisen" if current_user.nil?
  end

  def ensure_user_is_admin
    redirect_to signin_path, alert: "Sinulla ei ole toimintoon vaadittavia käyttöoikeuksia" unless current_user_is_admin  
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
end
