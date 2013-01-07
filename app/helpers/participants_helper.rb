module ParticipantsHelper

  def validate_table_cell(d, id)
    validate_deadlines = [5,6,8]
    if validate_deadlines.include? id and d.detect { |f| f["deadline_id"] == id } and not d.select{ |f| f["deadline_id"] == id}.first.approved 
      return "<td class=part-yellow>Yes</td>".html_safe
    else
      if d.detect { |f| f["deadline_id"] == id }
        return "<td class=part-green>Yes</td>".html_safe
      else
        return "<td class=part-red>No</td>".html_safe
      end
    end
  end

  def deadline_approved(deadline)
    if deadline.count == 0
      return "You have not finished this deadline"
    elsif deadline.first.approved
      return "Yes"
    elsif not deadline.first.approved
      return "Please wait for approval"
    end
  end

end
