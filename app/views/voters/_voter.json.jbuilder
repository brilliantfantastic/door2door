json.extract! voter, :id, :first_name, :last_name, :registered, :created_at, :updated_at
json.url voter_url(voter, format: :json)
