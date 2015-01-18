# encoding: utf-8
module HostHelper
  def bool_to_friendly(input)
    if input
      'Yes'
    else
      'No'
    end
  end
  def sleeping_to_friendly(input)
    if input == 1
        'Bed'
      elsif input == 2
        'Must borrow mattress'
      elsif input == 0
        'Couch'
      else
        'Not specified'
      end
    end
  def gender_pref_to_friendly(input)
    if input == 1
      'Female'
      elsif input == 2
       'Male'
      else
       'No preference'
      end
    end
end
