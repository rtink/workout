class DashboardsController < ApplicationController
    
  def index
    @athletes = User.paginate :page => params[:page], :per_page => 10
  end
    
end