module ParticipantsHelper

  def validate_table_cell(p, id)
    validate_deadlines = [5,6,8]
    if validate_deadlines.include? id and DeadlinesUser.where("deadline_id = ? and user_id = ?", id, p.user.id).first and not DeadlinesUser.where("deadline_id = ? and user_id = ?", id, p.user.id).first.approved 
      return "<td class=deadline-check>Yes</td>".html_safe
    else
      if p.user.deadlines.where(:id => id).count > 0
        return "<td class=deadline-yes>Yes</td>".html_safe
      else
        return "<td class=deadline-no>No</td>".html_safe
      end
    end
  end

end
