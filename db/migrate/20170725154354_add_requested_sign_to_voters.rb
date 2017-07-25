class AddRequestedSignToVoters < ActiveRecord::Migration[5.1]
  def change
    add_column :voters, :requested_sign, :boolean
  end
end
