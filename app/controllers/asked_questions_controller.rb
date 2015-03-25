class AskedQuestionsController < ApplicationController
  before_action :ensure_user_is_logged_in


  def create

    @asked_question = AskedQuestion.new(asked_question_params)
     @task = Task.find(session[:task_id])

     respond_to do |format|
      if @asked_question.save
        format.html { redirect_to @asked_question.question.interview.subtask.task }
      else
        format.html { redirect_to tasks_url, alert: "Toimenpiteen suoritus epäonnistui." }
      end
    end
  end


  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def asked_question_params
    params.require(:asked_question).permit(:user_id, :question_id)
  end
end
