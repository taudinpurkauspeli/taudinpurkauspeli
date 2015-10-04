class QuestionsController < ApplicationController
  before_action :ensure_user_is_logged_in
  before_action :ensure_user_is_admin
  before_action :set_question, only: [:update, :destroy]

  def create
    @task = Task.find(session[:task_id])
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to edit_interview_path(@question.interview.id, :layout => get_layout), notice: 'Kysymys lisättiin onnistuneesti.' }
      else
        format.html { redirect_to edit_interview_path(Interview.find(question_params[:interview_id]), :layout => get_layout), alert: 'Kysymyksen tiedot puuttelliset.' }
      end
    end
  end

  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to edit_interview_path(@question.interview.id, :layout => get_layout), notice: 'Kysymys päivitettiin onnistuneesti.' }
      else
        format.html { redirect_to edit_interview_path(@question.interview.id, :layout => get_layout), alert: 'Kysymyksen päivitys epäonnistui.' }
      end
    end
  end

  def destroy
    parent_id = @question.interview_id
    @question.destroy
    respond_to do |format|
      format.html { redirect_to edit_interview_path(parent_id, :layout => get_layout), notice: 'Kysymyksen poisto onnistui!' }
    end
  end


  private
  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :content, :required, :interview_id, question_group_attributes: [:title])
  end

end