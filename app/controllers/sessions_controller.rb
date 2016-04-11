class SessionsController < ApplicationController
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :json_request?

  def new
    # Renders login page
  end

  def create
    user = User.where(username: params[:username]).first

    respond_to do |format|
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        format.html { redirect_to exercises_path, notice: "Tervetuloa takaisin!"}
        format.json { render json: user }
      else
        format.html {redirect_to :back, alert: "Käyttäjätunnus tai salasana on väärin."}
        format.json { head :unauthorized }
      end
    end
  end

  def destroy
    # Reset session
    session[:user_id] = nil
    session[:exercise_id] = nil
    session[:task_id] = nil
    session[:exhyp_ids] = nil
    respond_to do |format|
      format.html { redirect_to exercises_path}
      format.json { head :ok }
    end
  end

end