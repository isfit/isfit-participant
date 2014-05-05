module ApplicationHelper
  # include Acl9Helpers
  def format(str)
    bc = BlueCloth.new(str)
    bc.to_html.html_safe
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction)
  end
  
  def pdf_image_tag(image, options = {})
    options[:src] = File.expand_path(RAILS_ROOT) + '/public/images/' + image
    tag(:img, options)
  end

  def gender_to_string(gender_id)
    case gender_id
      when 0
        'Male'
      when 1
        'Female'
      else
        'Other'
    end
  end
end

module ActiveRecord
  class Base  
    def self.to_select(index={}, conditions=nil)
      find(:all, :conditions => conditions).to_select(index)
    end
  end
end

class Array
  def to_select(index)
    self.collect { |x| [x.const_get(index),x.id] }
  end
  def to_select_title
    self.collect { |x| [x.title, x.id] }
  end
  def to_select_name
    self.collect { |x| [x.name, x.id] }
  end
end
