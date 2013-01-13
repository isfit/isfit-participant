class HostsController < ApplicationController
  before_filter :authenticate_user!
  set_tab :host

  require 'will_paginate/array'

  load_and_authorize_resource

  def add_bed
    @host = Host.find(params[:id])
    @host.number += 1
    @host.save
    flash[:notice] = "Added 1 bed for host successfully"
    redirect_to(host_path(@host))
  end

  def remove_bed
    @host = Host.find(params[:id])
    @host.number -= 1
    @host.save
    flash[:notice] = "Removed 1 bed for host successfully"
    redirect_to(host_path(@host))
  end

  def index
    @q = Host.search params[:q]

    @hosts = @q.result(distinct: true).where(deleted: 0)
    @hosts = @hosts.delete_if { |h| h.full? } unless params[:has_free_beds].nil?
    @hosts = @hosts.paginate(per_page: 10, page: params[:page])
  end

  def show
    @host = Host.find(params[:id]) 

    @q = Participant.search(params[:q])
    @results = @q
      .result(distinct: true)
      .where("checked_in IS NOT NULL AND host_id IS NULL")

    @participants_count = @results.count

    @participants = @results
      .order("checked_in ASC")
      .limit(50)
      .shuffle
  end

end
