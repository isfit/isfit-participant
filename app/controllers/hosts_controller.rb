class HostsController < ApplicationController
  require 'will_paginate/array'

  load_and_authorize_resource

  def index
    @hosts = Host.paginate(page: params[:page])
  end

  def show

  end

end
