class SessionsController < ApplicationController
    def new
      # renderöi kirjautumissivun
    end

    def create
      user = User.find_by username: params[:username]

      if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect_to :root, notice: "Tervetuloa takaisin!"
      else
        redirect_to :back, notice: "Käyttäjätunnus tai salasana on väärin."
      end
    end


    def destroy
      # nollataan sessio
      session[:user_id] = nil
      session[:exercise_id] = nil
      # uudelleenohjataan sovellus pääsivulle 
      redirect_to :root
    end

end