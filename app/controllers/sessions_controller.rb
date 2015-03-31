class SessionsController < ApplicationController
  def new
    # Renders login page
  end

  def create
    user = User.find_by username: params[:username]
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to :root, notice: "Tervetuloa takaisin!"
    else
      redirect_to :back, alert: "Käyttäjätunnus tai salasana on väärin."
    end
  end

  def destroy
    # Reset session
    session[:user_id] = nil
    session[:exercise_id] = nil
    session[:task_id] = nil
    redirect_to :root
  end

end