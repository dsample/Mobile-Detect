require 'csv'

require_relative 'mobile_detect'

usage_data_file = "usage_data.csv"
ua_column = 1

add_columns = true

detect = Detect.new
detect.load_json

#ua = "Mozilla/5.0(iPad; U; CPU iPhone OS 3_2 like Mac OS X; en-us) AppleWebKit/531.21.10 (KHTML, like Gecko) Version/4.0.4 Mobile/7B314 Safari/531.21.10"
#puts detect.device_type ua
#ua = "Mozilla/5.0 (Linux; Android 4.1.1; Nexus 7 Build/JRO03D) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.166  Safari/535.19"
#puts detect.device_type ua

csvfile = CSV.open(usage_data_file)
#csv_out = CSV::Writer.generate(File.open('updated_' + usage_data_file, 'wb'))

CSV.open('updated_' + usage_data_file, 'wb') do |csv_out|
	csvfile.each do |row|
		device = detect.device_type row[ua_column]
		
		if add_columns
			row << device['type']
			row << device['categories']
		end
		
		csv_out << row
	end
	
end
#csv_out.close
