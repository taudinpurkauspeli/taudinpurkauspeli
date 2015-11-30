class DiagnoseDiseasesController < ApplicationController

 # before_action :ensure_user_is_logged_in
 # before_action :ensure_user_is_admin

  def index
    render layout: "diagnose_diseases_layout.html.erb"
  end

end