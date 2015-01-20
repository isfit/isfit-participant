class HostsController < ApplicationController
  require 'will_paginate/array'

  load_and_authorize_resource

  def index
    @hosts = Host.get_all_non_deleted
    if params[:search].present?
      k = "%#{params[:search]}%"
      @hosts = @hosts
      .where("firstname LIKE ? OR lastname LIKE ?", k, k)
    end
    @hosts = @hosts.paginate(page: params[:page])
  end

  def show
    @host = Host.find(params[:id])
  end

end
