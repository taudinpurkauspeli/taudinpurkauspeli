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
        format.html { redirect_to :root, notice: "Tervetuloa takaisin!"}
        format.json { render json: user }
      else
        format.html {redirect_to :back, alert: "Käyttäjätunnus tai salasana on väärin."}
        format.json { head :internal_server_error }
      end
    end
  end

  def destroy
    # Reset session
    session[:user_id] = nil
    session[:exercise_id] = nil
    session[:task_id] = nil
    session[:exhyp_ids] = nil
    redirect_to :root
  end

end