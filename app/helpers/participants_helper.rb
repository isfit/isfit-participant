module ParticipantsHelper
  def intToVisaStatus(num)
    if num == 1
      return 'Acquired'
    elsif num == 2
      return 'Pending'
    else
      return 'Not applied'
    end
  end
  def intToYesNo(num)
    if num == 0
      return 'No'
    elsif num == 1
      return 'Yes'
    else
      return 'Unknown'
    end
  end
end
