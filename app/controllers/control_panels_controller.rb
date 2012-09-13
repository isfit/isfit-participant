class ControlPanelsController < ApplicationController

  load_and_authorize_resource

  def index
    redirect_to edit_control_panel_path(ControlPanel.first)
  end

  def update
    @cp = ControlPanel.first

    respond_to do |format|
      if @cp.update_attributes(params[:control_panel])
        format.html { redirect_to(edit_control_panel_path(ControlPanel.first), :notice => 'Settings saved!') }
      else
        format.html { redirect_to(@cp, :notice => 'Failed to save settings!') }
      end
    end
  end

  def edit
    @cp = ControlPanel.first
  end
end
