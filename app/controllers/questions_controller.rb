class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :ensure_user_is_logged_in
  before_action :ensure_user_is_admin, except: [:show]

  def new
    @question = Question.new

    set_view_layout
  end

  def edit

    set_view_layout
  end

  def show

    set_view_layout
  end

  def create
    @task = Task.find(session[:task_id])

    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        question_group = QuestionGroup.find_or_create_by(title:question_params[:question_group_title])
        @question.update(question_group:question_group)
        format.html { redirect_to edit_interview_path(@question.interview.id, :layout => get_layout), notice: 'Kysymysvaihtoehto lisättiin onnistuneesti.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { redirect_to edit_interview_path(Interview.find(question_params[:interview_id]), :layout => get_layout), alert: 'Kysymyksen tiedot puuttelliset.' }
        format.json { render json: @option.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @question.update(question_params)
        question_group = QuestionGroup.find_or_create_by(title:question_params[:question_group_title])
        question_group.questions.push(@question) unless question_group.questions.include?(@question)
        QuestionGroup.delete_unused_groups
        @question.update(question_group:question_group)
        format.html { redirect_to edit_interview_path(@question.interview.id, :layout => get_layout), notice: 'Kysymys päivitettiin onnistuneesti.' }
      else
        format.html { redirect_to edit_interview_path(@question.interview.id, :layout => get_layout), notice: 'Kysymyksen päivitys epäonnistui.' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    parent_id = @question.interview_id
    @question.destroy
    respond_to do |format|
      format.html { redirect_to edit_interview_path(parent_id, :layout => get_layout), notice: 'Kysymyksen poisto onnistui!' }
      format.json { head :no_content }
    end
  end


  private
  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :content, :required, :interview_id, :question_group_title )
  end

end