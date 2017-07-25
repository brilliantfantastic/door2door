class RemoveNotesFromVoters < ActiveRecord::Migration[5.1]
  def change
    remove_column :voters, :notes
  end
end
