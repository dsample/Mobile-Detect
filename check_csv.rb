require 'csv'

require_relative 'mobile_detect'

usage_data_file = "usage_data.csv"
output_file = "updated_" + usage_data_file
ua_column = 1

add_columns = true

detect = Detect.new
detect.load_json

csvfile = CSV.open(usage_data_file)

CSV.open(output_file, 'wb') do |csv_out|
	csvfile.each do |row|
		device = detect.device_type row[ua_column]
		
		if add_columns
			row << device['type']
			row << device['categories']
		end
		
		csv_out << row
	end
end

csvfile.close
