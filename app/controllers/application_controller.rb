class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # määritellään, että metodit tulevat käyttöön myös näkymissä
  helper_method :current_user
  helper_method :current_task
  helper_method :current_exercise
  helper_method :current_user_is_admin
  
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

  def current_user_is_admin
  	u = current_user
  	unless u.nil?
  		return u.admin
  	end
  	return false
  end

  def ensure_user_is_logged_in
    redirect_to signin_path, notice: "Toiminto vaatii sisäänkirjautumisen" if current_user.nil?
  end

  def ensure_user_is_admin
    if current_user_is_admin == false
      redirect_to signin_path, notice: "Sinulla ei ole toimintoon vaadittavia käyttöoikeuksia"
    end  
  end

  def create_subtask(parameters)
    subtask = Subtask.new(task_id:parameters[:task_id], task_text_id:parameters[:task_text_id])
    respond_to do |format|
      if subtask.save
        return true
      else
        return false
      end
    end
  end

  def create_task_text(parameters)
    task_text = TaskText.new(content:parameters[:content])
    respond_to do |format|
      if task_text.save
        if create_subtask(task_id:parameters[:task_id], task_text_id:task_text.id)
          return true
        else
          return false
        end
      else
        return false
      end
    end

  end

end
