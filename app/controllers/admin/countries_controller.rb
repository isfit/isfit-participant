class Admin::CountriesController < ApplicationController
  before_filter :set_country, only: [:edit, :update]

  load_and_authorize_resource

  def index
    @countries = Country.joins('LEFT OUTER JOIN users ON users.id = countries.user_id')
      .order('countries.name ASC')
  end

  def edit
  end

  def update
    if @country.update_attributes(params[:country])
      redirect_to admin_countries_url, notice: 'Country was update_attributes.'
    else
      render :edit
    end
  end

  private
    def set_country
      @country = Country.find(params[:id])
    end
end
