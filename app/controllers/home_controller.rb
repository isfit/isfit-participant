class HomeController < ApplicationController
  before_filter :authenticate_user!
  set_tab :home

  def index
      if current_user.has_role?(:admin)
        render :template => 'home/index1'
      elsif current_user.has_role?(:functionary)
        render :template => 'home/index2'
      elsif current_user.has_role?(:participant)
        render :template => 'home/index3'
      else
        render :template => 'home/index'
      end
  end

end
