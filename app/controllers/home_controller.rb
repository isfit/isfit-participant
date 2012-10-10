class HomeController < ApplicationController
  before_filter :authenticate_user!
  set_tab :home

  def index
      @deadlines = Deadline.all 
      @important_articles = Article.where("publish_at > #{Time.now.to_i}" ).where("sticky = 1").order("created_at DESC").limit(1)
      @articles = Article.where("publish_at > #{Time.now.to_i}" ).where("sticky < 1").order("created_at DESC").limit(5)
      if current_user.has_role?(:admin)
        render :template => 'home/index1'
      elsif current_user.has_role?(:functionary) || current_user.has_role?(:theme) || current_user.has_role?(:dialogue)
        @lastten = Question.find(:all, :joins=>"JOIN participants p  ON p.id = questions.participant_id JOIN functionaries_participants fp ON fp.participant_id = p.id JOIN functionaries f ON f.id = fp.functionary_id", :conditions=>"questions.question_status_id = 1 AND fp.functionary_id ="+current_user.functionary.id.to_s, :order=>"created_at DESC", :limit=>"10")
        if current_user.has_role?(:dialogue)
          @lastten = Question.find(:all, :conditions=>"questions.question_status_id = 1 AND dialogue=1", :order=>"created_at DESC", :limit=>"10")
        end
        render :template => 'home/index2'
      elsif current_user.has_role?(:participant)
        render :template => 'home/index3'
      elsif current_user.has_role?(:sec)
        redirect_to participants_path
      else
        render :template => 'home/index'
      end
  end

end
