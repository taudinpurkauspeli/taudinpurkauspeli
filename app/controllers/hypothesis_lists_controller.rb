class HypothesisListsController < ApplicationController
  before_action :set_hypothesis_list, only: [:show, :edit, :update, :destroy]

  # GET /hypothesis_lists
  # GET /hypothesis_lists.json
  def index
    @hypothesis_lists = HypothesisList.all
  end

  # GET /hypothesis_lists/1
  # GET /hypothesis_lists/1.json
  def show
  end

  # GET /hypothesis_lists/new
  def new
    @hypothesis_list = HypothesisList.new
  end

  # GET /hypothesis_lists/1/edit
  def edit
  end

  # POST /hypothesis_lists
  # POST /hypothesis_lists.json
  def create
    @hypothesis_list = HypothesisList.new(hypothesis_list_params)

    respond_to do |format|
      if @hypothesis_list.save
        format.html { redirect_to @hypothesis_list, notice: 'Hypothesis list was successfully created.' }
        format.json { render :show, status: :created, location: @hypothesis_list }
      else
        format.html { render :new }
        format.json { render json: @hypothesis_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hypothesis_lists/1
  # PATCH/PUT /hypothesis_lists/1.json
  def update
    respond_to do |format|
      if @hypothesis_list.update(hypothesis_list_params)
        format.html { redirect_to @hypothesis_list, notice: 'Hypothesis list was successfully updated.' }
        format.json { render :show, status: :ok, location: @hypothesis_list }
      else
        format.html { render :edit }
        format.json { render json: @hypothesis_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hypothesis_lists/1
  # DELETE /hypothesis_lists/1.json
  def destroy
    @hypothesis_list.destroy
    respond_to do |format|
      format.html { redirect_to hypothesis_lists_url, notice: 'Hypothesis list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hypothesis_list
      @hypothesis_list = HypothesisList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hypothesis_list_params
      params.require(:hypothesis_list).permit(:hypothesis_id, :exercise_id, :explanation)
    end
end
