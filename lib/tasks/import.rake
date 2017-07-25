namespace :voters do
  desc "Imports voters from a CSV file"
  task import: :environment do
    require "csv"

    file_path = ENV["FILE_PATH"]
    voters = []
    invalid = []

    CSV.foreach(file_path, headers: true, skip_blanks: true) do |row|
      begin
        first_name = sanitize_field row[7]
        last_name = sanitize_field row[9]
        street = sanitize_field row[10]
        city = sanitize_field row[12]
        zip_code = sanitize_field row[14]

        voter = Voter.new first_name: first_name, last_name: last_name
        voter.build_address street: street, city: city, zip_code: zip_code

        if voter.valid?
          voter.save
          voters << voter
        else
          invalid << { data: row, errors: voter.errors.full_messages }
        end

      rescue Exception
        invalid << { data: row, errors: ["Could not process row"] }
      end
    end

    puts "PROCESSED #{ActionController::Base.helpers.pluralize voters.count, "voter"}."
    puts "----------------------------------------------"
    puts "THERE was "\
      "#{ActionController::Base.helpers.pluralize invalid.count, "invalid row"}."
    puts "----------------------------------------------"
    invalid.each do |invalid_row|
      puts invalid_row[:errors]
      puts invalid_row[:data]
      puts "----------------------------------------------"
    end
  end

  def sanitize_field(field)
    field&.strip&.encode("UTF-8", invalid: :replace, undef: :replace)
  end
end
