class TitlesController < ApplicationController
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :json_request?

  before_action :ensure_user_is_logged_in
  before_action :ensure_user_is_admin
  before_action :set_title, only: [:destroy, :update]


  # GET /titles_all.json
  def titles_all
    @titles = Title.all

    respond_to do |format|
      format.html
      format.json {render json: @titles}
    end
  end


  # POST /titles
  # POST /titles.json
  def create
    @title = Title.new(title_params)
    respond_to do |format|
      if @title.save
        format.html { redirect_to titles_path(:layout => get_layout), notice: 'Kysymyksen luominen onnistui!' }
        format.json { head :ok }
      else
        format.html { redirect_to titles_path(:layout => get_layout), alert: 'Kysymyksen luominen epäonnistui!' }
        format.json { head :internal_server_error }
      end
    end
  end

  def update
    #TODO: Check what to do with Rails validations

    respond_to do |format|
      if @title.update(title_params)
        format.html
        format.json { head :ok }
      else
        format.html
        format.json { head :internal_server_error }
      end
    end
  end

  # DELETE /titles/1
  # DELETE /titles/1.json
  def destroy
    @title.destroy
    respond_to do |format|
      format.html { redirect_to titles_url(:layout => get_layout), notice: 'Kysymyksen poisto onnistui!' }
      format.json { head :ok }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_title
    @title = Title.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def title_params
    params.require(:title).permit(:text, :bank_id)
  end
end
