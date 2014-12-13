class ParticipantsController < ApplicationController
  load_and_authorize_resource
  
  def index
    @participants = Participant.paginate(page: params[:page]).joins(:user)
      .order('users.first_name ASC', 'users.last_name ASC')
      .where(approved_first_deadline: [1, 2])

    if params[:search].present?
      k = "%#{params[:search]}%"
      @participants = @participants
        .where("users.first_name LIKE ? OR users.last_name LIKE ? OR users.email LIKE ?", k, k, k)
    end
  end

  def show
    @participant = Participant.find(params[:id])
  end

  def update
    @participant = Participant.find(params[:id])
    @participant.approved_second_deadline = params[:participant][:approved_second_deadline]

    if @participant.save(validate: false)
      redirect_to participants_path, notice: 'Second deadline extended.'
    else
      render :show
    end
  end
end
