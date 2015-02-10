class HypothesisGroupController < ApplicationController
  before_action :set_hypothesis_group, only: [:show, :edit, :update, :destroy]
  before_action :ensure_user_is_logged_in
  before_action :ensure_user_is_admin, except: [:index, :show]

  def index
    @hypothesis_group = HypothesisGroup.all
  end

  # GET /hypothesis_group/1
  # GET /hypothesis_group/1.json
  def show
  end

  # GET /hypothesis_group/new
  def new
    @hypothesis_group = HypothesisGroup.new
  end

  # GET /hypothesis_group/1/edit
  def edit
  end

  # POST /hypothesis_group
  # POST /hypothesis_group.json
  def create
    @hypothesis_group = HypothesisGroup.new(hypothesis_group_params)

    respond_to do |format|
      if @hypothesis_group.save
        format.html { redirect_to hypotheses_url}
        format.json { render :show, status: :created, location: @hypothesis_group }
      else
        format.html { render :new }
        format.json { render json: @hypothesis_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hypothesis_group/1
  # PATCH/PUT /hypothesis_group/1.json
  def update
    respond_to do |format|
      if @hypothesis_group.update(hypothesis_group_params)
        format.html { redirect_to @hypothesis_group, notice: 'Työhypoteesiluokan nimi vaihdettu.' }
        format.json { render :show, status: :ok, location: @hypothesis_group }
      else
        format.html { render :edit }
        format.json { render json: @hypothesis_group.errors, status: :unprocessable_entity }
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
