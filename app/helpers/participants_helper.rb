module ParticipantsHelper

  def validate_table_cell(d, id)
    validate_deadlines = [5,6,8]
    if validate_deadlines.include? id and d.detect { |f| f["deadline_id"] == id } and not d.select{ |f| f["deadline_id"] == id}.first.approved 
      return "<td class=deadline-check>Yes</td>".html_safe
    else
      if d.detect { |f| f["deadline_id"] == id }
        return "<td class=deadline-yes>Yes</td>".html_safe
      else
        return "<td class=deadline-no>No</td>".html_safe
      end
    end
  end

end
