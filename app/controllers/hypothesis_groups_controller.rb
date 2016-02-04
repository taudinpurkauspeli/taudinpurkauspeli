class HypothesisGroupsController < ApplicationController
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :json_request?

  before_action :ensure_user_is_logged_in
  before_action :ensure_user_is_admin
  before_action :set_hypothesis_group, only: [:destroy, :show, :update]

  def index
    @hypothesis_groups = HypothesisGroup.all
    respond_to do |format|
      format.html
      format.json { render json: @hypothesis_groups }
    end
  end

  def hypothesis_groups_and_hypotheses
    hypothesis_groups = HypothesisGroup.all.to_json(include: :hypotheses)
    respond_to do |format|
      format.html
      format.json { render json: hypothesis_groups }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @hypothesis_group }
    end
  end

  def update
    #TODO: Check what to do with Rails validations

    respond_to do |format|
      if @hypothesis_group.update(hypothesis_group_params)
        format.html
        format.json { head :ok }
      else
        format.html
        format.json { head :internal_server_error }
      end
    end
  end

  # POST /hypothesis_groups
  # POST /hypothesis_groups.json
  def create
    @hypothesis_group = HypothesisGroup.new(hypothesis_group_params)
    respond_to do |format|
      if @hypothesis_group.save
        format.html { redirect_to hypotheses_url(:layout => get_layout)}
        format.json { head :ok }
      else
        format.html { redirect_to hypotheses_url(:layout => get_layout), alert: "Diffiryhmän luominen epäonnistui."}
        format.json { head :internal_server_error }
      end
    end
  end

  # DELETE /hypothesis_group/1
  # DELETE /hypothesis_group/1.json
  def destroy
    @hypothesis_group.destroy
    respond_to do |format|
      format.html { redirect_to hypotheses_url(:layout => get_layout)}
      format.json { head :ok }
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
