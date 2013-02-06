class Host < ActiveRecord::Base
  set_primary_key 'id'
  has_many :participants

  def full_name
    "#{first_name} #{last_name}"
  end

  def full?
    participants.count >= number
  end

  def number_left
    number - participants.count
  end

  def student
    if self[:student].nil?
      "Not registered"
    else
      self[:student] ? "Yes" : "No"
    end
  end

  def self.find_with_free_beds(args)
    Host.find_by_sql(
      ["
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
        WHERE ((h_number > h_participants)
        AND (deleted = 0)
        AND h_first_name LIKE :first_name
        AND last_name LIKE :last_name)",
        {
          first_name: '%' + args[:first_name] + '%',
          last_name: '%' + args[:last_name] + '%'
        }
      ]
    )
  end
end
