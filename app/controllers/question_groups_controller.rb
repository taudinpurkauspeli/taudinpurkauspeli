class QuestionGroupsController < ApplicationController
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :json_request?

  before_action :ensure_user_is_logged_in
  before_action :ensure_user_is_admin
  before_action :set_question_group, only: [:destroy]

  def index
    @question_groups = QuestionGroup.all
    respond_to do |format|
      format.html
      format.json { render json: @question_groups }
    end
  end

  # POST /question_group
  # POST /question_group.json
  def create
    @question_group = QuestionGroup.new(title: question_group_params[:title])

    respond_to do |format|
      if @question_group.save
        format.html { redirect_to edit_interview_path(Interview.find(question_group_params[:interview_id]), :layout => get_layout), notice: 'Ryhmä lisättiin onnistuneesti.' }
      else
        format.html { redirect_to edit_interview_path(Interview.find(question_group_params[:interview_id]), :layout => get_layout), alert: "Ryhmän luominen epäonnistui."}
      end
    end
  end

  def destroy
    @question_group.destroy
    respond_to do |format|
      format.html { redirect_to questions_url(:layout => get_layout)}
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_question_group
    @question_group = QuestionGroup.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def question_group_params
    params.require(:question_group).permit(:title, :interview_id)
  end
end
