class FlightDesignatorValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /^[0-9a-zA-Z]{2,3}[0-9]{1,4}$/
      record.errors[attribute] << (options[:message] || 'is not a valid flight designator')
    end
  end
end