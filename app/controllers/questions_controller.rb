class QuestionsController < ApplicationController
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :json_request?

  before_action :ensure_user_is_logged_in
  before_action :ensure_user_is_admin, except: [:interview_index, :ask]
  before_action :set_question, only: [:update, :destroy, :ask]
  before_action :set_current_user, only: [:ask, :interview_index]

  def index
    questions = Question.where(interview_id: params[:interview_id]).joins(:title).order('titles.text').group_by(&:required)

    respond_to do |format|
      format.html
      format.json { render json: questions.to_json(include: [:question_group, :title]) }
    end
  end

  def interview_index
    questions_with_group = Question.where(interview_id: params[:interview_id]).where.not(question_group_id: nil)
                               .joins(:title).order('titles.text').group_by{|q| q.question_group.title }
    questions_sorted_by_group = questions_with_group.slice(*questions_with_group.keys.sort)
    handled_sorted_questions = questions_with_group(questions_sorted_by_group)

    questions_without_group = Question.where(interview_id: params[:interview_id]).where(question_group_id: nil).joins(:title).order('titles.text')
    handled_questions_without_group = questions_without_group(questions_without_group)

    respond_to do |format|
      format.html
      format.json { render json: {questions_by_group: handled_sorted_questions, questions_without_group: handled_questions_without_group} }
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

  def ask
    @current_user.ask_question(@question)
    respond_to do |format|
        format.html { }
        format.json { render json: {asked_last: @question.id} }
    end
  end


  private
  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :content, :required, :interview_id, question_group_attributes: [:title])
  end

  def questions_with_group(questions_sorted)

    questions_handled = Hash.new()

    questions_sorted.each do |question_group, questions|

      ready_questions = Array.new()

      questions.each do |question|
        json_question = question.as_json
        json_question["asked"] = @current_user.has_asked_question?(question)
        ready_questions << json_question
      end

      questions_handled[question_group] = ready_questions
    end

    return  questions_handled
  end

  def questions_without_group(questions)

    ready_questions = Array.new()

    questions.each do |question|
      json_question = question.as_json
      json_question["asked"] = @current_user.has_asked_question?(question)
      ready_questions << json_question
    end

    return  ready_questions
  end

end