class AddressLabelPdf < Prawn::Document
  def initialize(participants,type,cols,rows)
    super(left_margin: 0, right_margin: 0, top_margin:0, bottom_margin:0, page_size: "A4")
    @participants = participants
    @cols = cols.to_i
    @rows = rows.to_i
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
    for i in 1..@rows
      x = 20
      for j in 1..@cols
        @placements.push([x,y])
        x += (600/@cols)
      end
      y -= (840/@rows)
    end
  end
  def print_labels
    i = 0
    @participants.each do |p|
      insert_label("#{p.user.first_name} #{p.user.last_name}\n#{p.user.profile.address}\n#{p.user.profile.postal_code} #{p.user.profile.city}\n#{p.user.profile.country.name}",i)
      i += 1
      if i >= (@cols*@rows) # labels per page
        start_new_page
        i = 0
      end
    end
  end
  def insert_label(text,placement)
    text_box text,
             :at => @placements[placement],
             :height => 800/(@rows+1),
             :width => (600/@cols)-50,
             :style => :italic,
             :overflow => :shrink_to_fit
  end
  def print_envelope #Do not attempt adding duplex printing to this. Horrible things will happen
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