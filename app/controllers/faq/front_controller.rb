class Faq::FrontController < ApplicationController
  def index
    @categories = Faq::Category.with_questions
  end
end
