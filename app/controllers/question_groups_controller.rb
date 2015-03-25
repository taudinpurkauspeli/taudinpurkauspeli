class QuestionGroupsController < ApplicationController
  before_action :set_question_group, only: [:destroy]
  before_action :ensure_user_is_logged_in
  before_action :ensure_user_is_admin

  # POST /hypothesis_group
  # POST /hypothesis_group.json
  def create
    @question_group = QuestionGroup.new(question_group_params)

    respond_to do |format|
      if @question_group.save
        format.html { redirect_to edit_interview_path(Interview.find(question_group_params[:interview_id])), notice: 'Ryhmä lisättiin onnistuneesti.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { redirect_to edit_interview_path(Interview.find(question_group_params[:interview_id])), alert: "Ryhmän luominen epäonnistui."}
      end
    end
  end
 
  def destroy
    @question_group.destroy
    respond_to do |format|
      format.html { redirect_to questions_url}
      format.json { head :no_content }
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