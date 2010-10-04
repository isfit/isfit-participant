class SearchController < ApplicationController
  def index
    @participants = Participant.search(params[:query])
  end

end
