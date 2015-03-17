class HypothesisGroupsController < ApplicationController
  before_action :set_hypothesis_group, only: [:destroy]
  before_action :ensure_user_is_logged_in
  before_action :ensure_user_is_admin

  # POST /hypothesis_group
  # POST /hypothesis_group.json
  def create
    @hypothesis_group = HypothesisGroup.new(hypothesis_group_params)
    respond_to do |format|
      if @hypothesis_group.save
        format.html { redirect_to hypotheses_url}
      else
        format.html { redirect_to hypotheses_url, alert: "Työhypoteesiryhmän luominen epäonnistui."}
      end
    end
  end

  # DELETE /hypothesis_group/1
  # DELETE /hypothesis_group/1.json
  def destroy
    @hypothesis_group.destroy
    respond_to do |format|
      format.html { redirect_to hypotheses_url}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hypothesis_group
      @hypothesis_group = HypothesisGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hypothesis_group_params
      params.require(:hypothesis_group).permit(:name)
    end
end
