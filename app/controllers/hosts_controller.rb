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

    if params[:has_free_beds].nil?
      @hosts = @q
        .result(distinct: true)
        .where(deleted: 0)
        .paginate(per_page: 10, page: params[:page])
    else
      @hosts = @q
        .result(distinct: true)
        .find_by_sql("
          SELECT h_id AS id, h_first_name AS first_name, last_name, h_number AS number, h_participants
          FROM (
            SELECT h_id, h_first_name, last_name, number AS h_number, SUM(c) AS h_participants, deleted
            FROM (
              SELECT h.id AS h_id, h.first_name AS h_first_name, h.last_name, number, COUNT(p.host_id) AS c, deleted
              FROM hosts as h
              LEFT OUTER JOIN participants AS p on h.id = p.host_id
              GROUP BY h.id
              UNION
              SELECT h.id AS h_id, h.first_name AS h_first_name, h.last_name, number, COUNT(*) AS c, deleted
              FROM hosts AS h
              INNER JOIN participants AS p ON h.id = p.host_id
              GROUP BY h.id
            ) AS all_hosts_with_beds_and_participant_count
            GROUP BY h_id
          ) AS filtered_deleted_and_full
          WHERE ((h_number > h_participants) AND (deleted = 0))")
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
