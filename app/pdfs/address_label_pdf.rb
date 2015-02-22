class AddressLabelPdf < Prawn::Document
  def initialize(participants,type)
    super(left_margin: 0, right_margin: 0, top_margin:0, bottom_margin:0, page_size: "A4")
    @participants = participants
    generate_placements
    if type == '1'
      print_envelope
    elsif type == '2'
      print_return_labels
    else
      print_labels
    end
  end
  def generate_placements
    @placements = []
    y = 820
    for i in 0..6
      @placements.push([20,y])
      @placements.push([320,y])
      y -=120
    end
  end
  def print_labels
    i = 0
    @participants.each do |p|
      insert_label("#{p.user.first_name} #{p.user.last_name}\n#{p.user.profile.address}\n#{p.user.profile.postal_code} #{p.user.profile.city}\n#{p.user.profile.country.name}",i)
      i += 1
      if i >= 14 # labels per page
        start_new_page
        i = 0
      end
    end
  end
  def insert_label(text,placement)
    text_box text,
             :at => @placements[placement],
             :height => 100,
             :width => 250,
             :style => :italic,
             :overflow => :shrink_to_fit
  end
  def print_envelope
    @participants.each do |p|
      text_box "#{p.user.first_name} #{p.user.last_name}\n#{p.user.profile.address}\n#{p.user.profile.postal_code} #{p.user.profile.city}\n#{p.user.profile.country.name}",
      :at => [520,780],
               :height => 200,
               :width => 200,
               :style => :italic,
               :rotate => 270
      start_new_page
    end
  end
  def print_return_labels
    for i in 0..13
      insert_label("Avs.: ISFiT 2015\nPostterminalen NTNU\n7491 Trondheim\nNorway",i)
    end
  end
end