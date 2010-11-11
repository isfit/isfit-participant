class HomeController < ApplicationController
  before_filter :authenticate_user!
  set_tab :home

  def index
      @deadlines = Deadline.all 
      @important_articles = Article.where("publish_at > #{Time.now.to_i}" ).where("sticky = 1").order("created_at DESC").limit(1)
      @articles = Article.where("publish_at > #{Time.now.to_i}" ).where("sticky < 1").order("created_at DESC").limit(5)
      if current_user.has_role?(:admin)
        render :template => 'home/index1'
      elsif current_user.has_role?(:functionary)
        @lastten = Question.find(:all, :joins=>"JOIN functionaries ON functionaries.id = participants.functionary_id", :joins=>"JOIN participants ON participants.id = questions.participant_id", :conditions=>"questions.id NOT IN (SELECT DISTINCT answers.question_id FROM answers) AND participants.functionary_id ="+current_user.functionary.id.to_s, :order=>"created_at DESC", :limit=>"10")
        if current_user.has_role?(:dialogue)
          @lastten = Question.find(:all, :conditions=>"questions.id NOT IN (SELECT DISTINCT answers.question_id FROM answers) AND dialogue=1", :order=>"created_at DESC", :limit=>"10")
        end
        render :template => 'home/index2'
      elsif current_user.has_role?(:participant)
        render :template => 'home/index3'
      else
        render :template => 'home/index'
      end
  end

end
