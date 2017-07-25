class AddLevelOfInterestToVoters < ActiveRecord::Migration[5.1]
  def change
    add_column :voters, :level_of_interest, :integer
  end
end
