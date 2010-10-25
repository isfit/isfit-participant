class HomeController < ApplicationController
  before_filter :authenticate_user!
  set_tab :home

  def index
      if current_user.has_role?(:admin)
        render :template => 'home/index1'
      elsif current_user.has_role?(:functionary)
        @lastten = Question.find(:all, :conditions=>"questions.id NOT IN (SELECT DISTINCT answers.question_id FROM answers)", :order=>"created_at DESC", :limit=>"10")
        render :template => 'home/index2'
      elsif current_user.has_role?(:participant)
        @articles = Article.where("publish_at > #{Time.now.to_i}" ).order("created_at DESC").limit(1)
        render :template => 'home/index3'
      else
        render :template => 'home/index'
      end
  end

end
