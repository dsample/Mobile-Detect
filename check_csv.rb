require 'csv'

require_relative 'mobile_detect'

usage_data_file = "usage_data.csv"
ua_column = 1

add_columns = true

usage_data_file = ARGV[0] if ARGV[0] && ARGV[0] != '--'
ua_column = ARGV[1].to_i if ARGV[1] && ARGV[1] != '--'
output_file = ARGV[2] if ARGV[2] && ARGV[2] != '--'

output_file = File.dirname(usage_data_file) + "/updated_" + File.basename(usage_data_file) unless output_file

detect = Detect.new
detect.load_json

csvfile = CSV.open(usage_data_file)

verbose = true if ARGV.include?("-v") || ARGV.include?("--verbose")

CSV.open(output_file, 'wb') do |csv_out|
	csvfile.each do |row|
		device = detect.device_type row[ua_column]
		
		if add_columns
			row << device['type']
			row << device['categories']
		end
		
		puts(row[0] + ": " + device['type'] + ": " + device['categories']) if verbose

		csv_out << row
	end
end

csvfile.close
