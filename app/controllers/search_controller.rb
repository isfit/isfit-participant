class SearchController < ApplicationController
  access_control do
    allow :admin
  end
  def index
    @participants = Participant.search(params[:query])
  end

end
