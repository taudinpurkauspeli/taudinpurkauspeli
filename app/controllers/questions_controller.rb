class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :ensure_user_is_logged_in
  before_action :ensure_user_is_admin, except: [:show]

  def new
    @question = Question.new
  end

  def edit
  end

  def show
  end

  def create
    @task = Task.find(session[:task_id])
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to edit_interview_path(@question.interview.id), notice: 'Kysymysvaihtoehto lisättiin onnistuneesti.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { redirect_to edit_interview_path(Interview.find(question_params[:interview_id])), alert: 'Kysymyksen tiedot puuttelliset.' }
        format.json { render json: @option.errors, status: :unprocessable_entity }
      end
    end
  end


    def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to edit_interview_path(@question.interview.id), notice: 'Kysymys päivitettiin onnistuneesti.' }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    parent_id = @question.interview_id
    @question.destroy
    respond_to do |format|
      format.html { redirect_to edit_interview_path(parent_id), notice: 'Kysymyksen poisto onnistui!' }
      format.json { head :no_content }
    end
  end


private
  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :content, :required, :interview_id, :question_group_id )
  end

end