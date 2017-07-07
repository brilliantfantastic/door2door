require "pg_search"

module Searchable
  extend ActiveSupport::Concern

  included do
    self.include PgSearch

    self.pg_search_scope :search, against: {
      first_name: "A",
      last_name: "B"
    },
    using: {
      tsearch: { dictionary: "english", prefix: true }
    }
  end
end
