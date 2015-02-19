class AddressLabelPdf < Prawn::Document
  def initialize(participants)
    super(left_margin: 0, right_margin: 0, top_margin:0, bottom_margin:0, page_size: "A4")
    @participants = participants;
    #@placements = [[20,800],[320,800],[20,700],[20,600],[20,500]]
    generate_placements
    generate_labels
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
  def generate_labels
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
             :height => 200,
             :width => 200,
             :style => :italic
  end
end