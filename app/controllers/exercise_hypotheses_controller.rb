class ExerciseHypothesesController < ApplicationController
  before_action :set_exercise_hypothesis, only: [:show, :edit, :update, :destroy]
  before_action :ensure_user_is_logged_in
  before_action :ensure_user_is_admin, except: [:index, :show]

  # GET /exercise_hypotheses
  # GET /exercise_hypotheses.json
  def index
    @exercise_hypotheses = ExerciseHypothesis.all
  end

  # GET /exercise_hypotheses/1
  # GET /exercise_hypotheses/1.json
  def show
  end

  # GET /exercise_hypotheses/new
  def new
    @exercise_hypothesis = ExerciseHypothesis.new
  end

  # GET /exercise_hypotheses/1/edit
  def edit
  end

  # POST /exercise_hypotheses
  # POST /exercise_hypotheses.json
  def create
    @exercise_hypothesis = ExerciseHypothesis.new(exercise_hypothesis_params)

    respond_to do |format|
      if @exercise_hypothesis.save
        format.html { redirect_to @exercise_hypothesis, notice: 'Exercise hypothesis was successfully created.' }
        format.json { render :show, status: :created, location: @exercise_hypothesis }
      else
        format.html { render :new }
        format.json { render json: @exercise_hypothesis.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /exercise_hypotheses/1
  # PATCH/PUT /exercise_hypotheses/1.json
  def update
    respond_to do |format|
      if @exercise_hypothesis.update(exercise_hypothesis_params)
        format.html { redirect_to @exercise_hypothesis, notice: 'Exercise hypothesis was successfully updated.' }
        format.json { render :show, status: :ok, location: @exercise_hypothesis }
      else
        format.html { render :edit }
        format.json { render json: @exercise_hypothesis.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exercise_hypotheses/1
  # DELETE /exercise_hypotheses/1.json
  def destroy
    @exercise_hypothesis.destroy
    respond_to do |format|
      format.html { redirect_to exercise_hypotheses_url, notice: 'Exercise hypothesis was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exercise_hypothesis
      @exercise_hypothesis = ExerciseHypothesis.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def exercise_hypothesis_params
      params.require(:exercise_hypothesis).permit(:exercise_id, :hypothesis_id, :explanation)
    end
end
