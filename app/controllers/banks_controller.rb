class BanksController < ApplicationController
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :json_request?

  before_action :ensure_user_is_logged_in
  before_action :ensure_user_is_admin
  before_action :set_bank, only: [:destroy, :show, :update]

  def index
    @banks = Bank.all.order(:name)
    respond_to do |format|
      format.html
      format.json { render json: @banks }
    end
  end

  def banks_and_titles
    banks = Bank.all.order(:name).to_json(include: :titles)
    respond_to do |format|
      format.html
      format.json { render json: banks }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @bank }
    end
  end

  def update
    #TODO: Check what to do with Rails validations

    respond_to do |format|
      if @bank.update(bank_params)
        format.html
        format.json { head :ok }
      else
        format.html
        format.json { head :internal_server_error }
      end
    end
  end

  # POST /banks
  # POST /banks.json
  def create
    @bank = Bank.new(bank_params)
    respond_to do |format|
      if @bank.save
        format.html { redirect_to banks_url(:layout => get_layout)}
        format.json { head :ok }
      else
        format.html { redirect_to banks_url(:layout => get_layout), alert: "Kysymyspankin luominen epäonnistui."}
        format.json { head :internal_server_error }
      end
    end
  end

  # DELETE /banks/1
  # DELETE /banks/1.json
  def destroy
    @bank.destroy
    respond_to do |format|
      format.html { redirect_to banks_url(:layout => get_layout)}
      format.json { head :ok }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_bank
    @bank = Bank.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def bank_params
    params.require(:bank).permit(:name)
  end

end
