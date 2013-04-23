class HostsController < ApplicationController
  before_filter :authenticate_user!

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

    if params[:has_free_beds].nil?
      @hosts = @q
        .result(distinct: true)
        .where(deleted: 0)
        .paginate(per_page: 10, page: params[:page])
    else
      @hosts = Host
        .find_with_free_beds(
          first_name: params[:q][:first_name_cont],
          last_name: params[:q][:last_name_cont]
        )
        .paginate(per_page: 10, page: params[:page])
    end
  end

  def show
    @host = Host.find(params[:id])

    @q = Participant.search(params[:q])
    @results = @q
      .result(distinct: true)
      .where("guaranteed = 1 OR dialogue = 1")
      .where("checked_in IS NOT NULL AND host_id IS NULL")

    @participants_count = @results.count

    @participants = @results
      .order("checked_in ASC")
      .limit(50)
      .shuffle

    beds = Host.select("SUM(number) AS sum").where(deleted: 0)[0].sum
    taken_beds = Participant.where("host_id IS NOT NULL").count
    @free_beds = beds - taken_beds
  end

end
