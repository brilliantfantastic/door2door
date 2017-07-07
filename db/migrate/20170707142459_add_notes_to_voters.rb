class AddNotesToVoters < ActiveRecord::Migration[5.1]
  def change
    add_column :voters, :notes, :text
  end
end
