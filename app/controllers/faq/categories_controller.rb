class Faq::CategoriesController < ApplicationController
  before_filter :check_permission
  before_filter :set_category, only: [:edit, :update, :destroy]

  def index
    @categories = Faq::Category.all
    @category = Faq::Category.new
  end

  def edit
  end

  def create
    @category = Faq::Category.new(params[:faq_category])

    if @category.save
      redirect_to faq_categories_url, notice: 'Category was successfully created.'
    else
      render :index
    end
  end

  def update
    if @category.update_attributes(params[:faq_category])
      redirect_to faq_categories_url, notice: 'Category was successfully changed.'
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to faq_categories_url, notice: 'Category was successfully destroyed.'
  end

  private
    def check_permission
      unless can? :destroy, Faq::Category
        redirect_to dashboard_url, alert: 'You don\'t have permission to access that page.'
      end
    end

    def set_category
      @category = Faq::Category.find(params[:id])
    end
end
