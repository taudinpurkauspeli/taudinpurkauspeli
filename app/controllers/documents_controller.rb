class DocumentsController < ApplicationController
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :json_request?

  before_action :ensure_user_is_logged_in
  before_action :ensure_user_is_admin, except: [:index, :show]
  before_action :set_document, only: [:show, :update, :destroy]

  # GET /documents
  # GET /documents.json
  def index
    @documents = Document.all.with_attached_data.order(:name)

    docs = @documents.map do |doc|
      json_doc = doc.as_json
      to_return = json_doc
      if doc.data.attached?
        to_return = json_doc.merge({data: url_for(doc.data)})
      else
        to_return = json_doc
      end
      to_return
    end

    respond_to do |format|
      format.html {}
      format.json {
        render json: docs
      }
    end
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    respond_to do |format|
      format.html {}
      format.json { render json: {document: @document} }
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      @document.name = document_params[:name]
      @document.description = document_params[:description]

      if @document.save
        format.html { redirect_to document_path(@document.id, :layout => get_layout), notice: 'Tiedoston päivitys onnistui!' }
        format.json { head :ok }
      else
        format.html { redirect_to document_path(@document.id, :layout => get_layout), alert: 'Tiedoston päivitys epäonnistui!' }
        format.json { head :internal_server_error }
      end
    end
  end

  # POST /documents
  # POST /documents.json
  def create

    name = document_params[:name]
    description = document_params[:description]
    data = document_params[:file]

    @document = Document.new(name: name, description: description, data: data)
    respond_to do |format|
      if @document.save
        format.html { redirect_to document_path(@document.id, :layout => get_layout), notice: 'Tiedoston luominen onnistui!' }
        format.json { render json: @document }
      else
        format.html { redirect_to new_document_path(:layout => get_layout), alert: 'Tiedoston luominen epäonnistui!' }
        format.json { head :internal_server_error }
      end
    end
  end


  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url, notice: 'Tiedoston poistaminen onnistui!' }
      format.json { head :ok }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_document
    @document = Document.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def document_params
    params.permit(:name, :description, :file)

  end
end
