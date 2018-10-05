class OwnFilesController < ApplicationController
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :json_request?

  before_action :ensure_user_is_logged_in
  before_action :ensure_user_is_admin, except: [:index, :show]
  before_action :set_own_file, only: [:show, :update, :destroy]

  # GET /own_files
  # GET /own_files.json
  def index
    @own_files = OwnFile.all.order(:name)

    respond_to do |format|
      format.html
      format.json { render json: @own_files }
    end
  end

  # GET /own_files/1
  # GET /own_files/1.json
  def show
    respond_to do |format|
      format.html
      format.json { render json: {own_file: @own_file} }
    end
  end

  # PATCH/PUT /exercises_one/1
  # PATCH/PUT /exercises_one/1.json
  def update
    respond_to do |format|
      if @own_file.update(own_file_params)
        format.html { redirect_to own_file_path(@own_file.id, :layout => get_layout), notice: 'Tiedoston päivitys onnistui!' }
        format.json { head :ok }
      else
        format.html { redirect_to own_file_path(@own_file.id, :layout => get_layout), alert: 'Tiedoston päivitys epäonnistui!' }
        format.json { head :internal_server_error }
      end
    end
  end

  # POST /own_files
  # POST /own_files.json
  def create
    @own_file = OwnFile.new(own_file_params)
    respond_to do |format|
      if @own_file.save
        format.html { redirect_to own_file_path(@own_file.id, :layout => get_layout), notice: 'Tiedoston luominen onnistui!' }
        format.json { render json: @own_file }
      else
        format.html { redirect_to new_own_file_path(:layout => get_layout), alert: 'Tiedoston luominen epäonnistui!' }
        format.json { head :internal_server_error }
      end
    end
  end


  # DELETE /exercises/1
  # DELETE /exercises/1.json
  def destroy
    @own_file.destroy
    respond_to do |format|
      format.html { redirect_to own_files_url, notice: 'Tiedoston poistaminen onnistui!' }
      format.json { head :ok }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_own_file
    @own_file = OwnFile.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def own_file_params
    params.require(:own_file).permit(:name, :description, :data)

  end
end
