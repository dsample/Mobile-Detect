require_relative '../mobile_detect'
require 'csv'
describe Detect do
	before(:all) do
		@detect = Detect.new
		@detect.load_json
		@test_devices = CSV.open(File.dirname(__FILE__) + "/../tests/test_devices.csv")
	end
	
	it "detects all devices correctly" do
		@test_devices.each do |row|
			detection = @detect.device_type(row[2])
			expect(detection["type"]).to eq(row[1]), "Device: " + row[0] + " detect as " + detection["type"]
			#detection["type"].should be(row[1]), "Device: " + row[0] + " detected as " + detection["type"] + " instead of " + row[1]
		end
	end
end
