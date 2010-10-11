class HomeController < ApplicationController
  before_filter :authenticate_user!
  set_tab :home

  def index
  end

end
