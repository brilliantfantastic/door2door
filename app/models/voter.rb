class Voter < ApplicationRecord
  include Searchable

  belongs_to :address, dependent: :destroy, optional: true
  accepts_nested_attributes_for :address
end
