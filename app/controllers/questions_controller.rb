class QuestionsController < ApplicationController
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :json_request?

  before_action :ensure_user_is_logged_in
  before_action :ensure_user_is_admin, except: [:interview_index]
  before_action :set_question, only: [:update, :destroy]

  def index
    questions = Question.where(interview_id: params[:interview_id]).order(:title).group_by(&:required)

    respond_to do |format|
      format.html
      format.json { render json: questions.to_json(include: :question_group) }
    end
  end

  def interview_index
    questions_with_group = Question.where(interview_id: params[:interview_id]).where.not(question_group_id: nil).order(:title).group_by{|q| q.question_group.title }
    questions_without_group = Question.where(interview_id: params[:interview_id]).where(question_group_id: nil).order(:title)
    questions_sorted_by_group = questions_with_group.slice(*questions_with_group.keys.sort)

    respond_to do |format|
      format.html
      format.json { render json: {questions_by_group: questions_sorted_by_group, questions_without_group: questions_without_group} }
    end
  end

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

  def json_create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to edit_interview_path(@question.interview.id, :layout => get_layout), notice: 'Kysymys lisättiin onnistuneesti.' }
        format.json { head :ok }
      else
        format.html { redirect_to edit_interview_path(Interview.find(question_params[:interview_id]), :layout => get_layout), alert: 'Kysymyksen tiedot puuttelliset.' }
        format.json { head :internal_server_error }
      end
    end
  end

  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to edit_interview_path(@question.interview.id, :layout => get_layout), notice: 'Kysymys päivitettiin onnistuneesti.' }
        format.json { head :ok }
      else
        format.html { redirect_to edit_interview_path(@question.interview.id, :layout => get_layout), alert: 'Kysymyksen päivitys epäonnistui.' }
        format.json { head :internal_server_error }
      end
    end
  end

  def destroy
    parent_id = @question.interview_id
    @question.destroy
    respond_to do |format|
      format.html { redirect_to edit_interview_path(parent_id, :layout => get_layout), notice: 'Kysymyksen poisto onnistui!' }
      format.json { head :ok }
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