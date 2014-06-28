class AddOtherInformationToDialogueApplication < ActiveRecord::Migration
  def change
    add_column :dialogue_applications, :other_information, :text
  end
end
