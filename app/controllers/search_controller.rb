class SearchController < ApplicationController
  load_and_authorize_resource
  
  def index
    @participants = Participant.search(params[:query])
  end

end
