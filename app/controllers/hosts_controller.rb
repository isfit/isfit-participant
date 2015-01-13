class HostsController < ApplicationController
  require 'will_paginate/array'

  load_and_authorize_resource

  def index
    @hosts = Host.all.paginate(page: params[:page])
  end

  def show
    @host = Host.find(params[:id])
  end

end
