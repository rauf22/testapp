class User < ApplicationRecord

  def self.to_csv(options = {})
    # attributes = %w{id, name, phone}
    # column_names = %w{id, name, phone}

    # CSV.generate(headers: true) do |csv|
    CSV.generate(options) do |csv|
      csv << column_names

      all.each do |user|
        csv << user.attributes.values_at(*column_names)
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      user = find_by_id(row["id"]) || new
      user.attributes = row.to_hash.slice(*column_names)
      user.save!
    end

  end

end
