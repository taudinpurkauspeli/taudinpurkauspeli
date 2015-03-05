class HypothesesController < ApplicationController
  before_action :set_hypothesis, only: [:show, :edit, :update, :destroy]
  before_action :ensure_user_is_logged_in
  before_action :ensure_user_is_admin, except: [:index, :show]

  # GET /hypotheses
  # GET /hypotheses.json
  def index
    @exercise = current_exercise
    if @exercise

      @user = current_user
      @hypotheses_of_exercise = @exercise.hypotheses
      #all hypotheses and hypotheses for current exercise
      @hypothesis_bank = @exercise.get_hypothesis_bank
      @hypothesis_groups = HypothesisGroup.all
      @exercise_hypotheses = @exercise.get_exercise_hypotheses

      unless @user.admin
        #checked hypotheses for current user
        @checked_hypotheses = @exercise.get_checked_hypotheses_for(@user)
        @unchecked_hypotheses = @exercise.get_unchecked_hypotheses_for(@user)
      end

      #new instances
      @new_exercise_hypothesis = ExerciseHypothesis.new
      @new_hypothesis_group = HypothesisGroup.new
      @new_hypothesis =Hypothesis.new
      @new_checked_hypothesis = CheckedHypothesis.new
    else
      redirect_to exercises_path, notice: 'Valitse ensin case, jota haluat tarkastella!'
    end

  end

  # GET /hypotheses/1
  # GET /hypotheses/1.json
  def show
  end

  # GET /hypotheses/new
  def new
    @hypothesis = Hypothesis.new
  end

  # GET /hypotheses/1/edit
  def edit
  end

  # POST /hypotheses
  # POST /hypotheses.json
  def create
    @hypothesis = Hypothesis.new(hypothesis_params)
    respond_to do |format|
      if @hypothesis.save
        format.html { redirect_to hypotheses_path, notice: 'Hypoteesin luominen onnistui!' }
        format.json { render :show, status: :created, location: @hypothesis }
      else
        format.html { render :new }
        format.json { render json: @hypothesis.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hypotheses/1
  # PATCH/PUT /hypotheses/1.json
  def update
    respond_to do |format|
      if @hypothesis.update(hypothesis_params)
        format.html { redirect_to @hypothesis, notice: 'Hypoteesin päivitys onnistui!' }
        format.json { render :show, status: :ok, location: @hypothesis }
      else
        format.html { render :edit }
        format.json { render json: @hypothesis.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hypotheses/1
  # DELETE /hypotheses/1.json
  def destroy
    @hypothesis.destroy
    respond_to do |format|
      format.html { redirect_to hypotheses_url, notice: 'Hypoteesin poisto onnistui!' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_hypothesis
    @hypothesis = Hypothesis.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def hypothesis_params
    params.require(:hypothesis).permit(:name, :hypothesis_group_id)
  end
end
