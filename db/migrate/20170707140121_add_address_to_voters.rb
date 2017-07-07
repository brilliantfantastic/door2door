class AddAddressToVoters < ActiveRecord::Migration[5.1]
  def change
    add_reference :voters, :address, foreign_key: true
  end
end
