require "csv"

# rubocop:disable Rails/Output
class DataMigration::LoadGender < ::CommandObject
  attr_reader :directory, :combined_directory

  def initialize(directory = Rails.root.join("data", "names_per_year"),
                 combined_directory = Rails.root.join("data", "names_combined"))
    @directory = directory
    @combined_directory = combined_directory
    @names = {}
    @compiled_names = {}
  end

  def load_files
    ::Dir.entries(directory).each do |file|
      add_to_names(directory, file, "txt")
      print "."
    end
  end

  def add_to_names(directory, file, extension)
    return false unless file =~ /\A.*?\.#{extension}\z/

    ::CSV.foreach(File.join(directory, file)) do |(name, gender, occurances)|
      if @names.key?("#{gender} #{name}")
        @names["#{gender} #{name}"][:occurances] += occurances.to_i
      else
        @names["#{gender} #{name}"] = { name: name,
                                        gender: gender,
                                        occurances: occurances.to_i }
      end
    end
  end

  def write_combined_names
    puts "\nWriting combined.csv"

    CSV.open(File.join(combined_directory, "combined.csv"), "wb") do |csv|
      @names.values.each do |name|
        csv << name.values
      end
    end

    true
  end

  def populate_names
    filename = Rails.env == "test" ? "combined_test.csv" : "combined.csv"

    if File.exist?(File.join(combined_directory, filename))
      puts "\n#{filename} exists. Loading from this file rather than all the yob files."
      add_to_names(combined_directory, filename, "csv")
      return true
    end

    puts "\nLoading from yob files."
    load_files
    write_combined_names
    true
  end

  def compiled_names # rubocop:disable Metrics/AbcSize
    @names.reduce({}) do |accum, (_key, value)|
      value[:name].downcase!
      value[:gender].downcase!

      accum[value[:name]] = { name: value[:name], "f" => 0, "m" => 0 } unless accum.key?(value[:name])

      if value[:gender] == "f"
        accum[value[:name]]["f"] += value[:occurances].to_i
      else
        accum[value[:name]]["m"] += value[:occurances].to_i
      end

      accum
    end
  end

  def gender_probability
    compiled_names.map do |(_key, value)|
      female_percentage = value["f"].to_f / (value["f"] + value["m"]).to_f

      { name: value[:name], female: female_percentage, male: (1.0 - female_percentage) }
    end
  end

  def call
    return false unless ::Gender.first.nil?

    populate_names
    ::MultiInsert.call(gender_probability, { model: ::Gender, ignore_attributes: ["id"], page_size: 1_000 })
    ::MultiInsert.call(gender_probability, { model: ::GenderNoIndex, ignore_attributes: ["id"], page_size: 1_000 })

    @names.clear if @names.present?
    true
  end
end
# rubocop:enable Rails/Output
