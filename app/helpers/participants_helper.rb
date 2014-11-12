module ParticipantsHelper
  def intToVisaStatus(num)
    if num == 0
      return 'Not applied'
    elsif num == 1
      return 'Acquired'
    elsif num == 2
      return 'Pending'
    end
  end
end
