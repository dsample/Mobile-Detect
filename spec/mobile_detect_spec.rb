require 'spec_helper'

describe Mobile_Detect::Detect do
	before(:all) do
		@detect = Mobile_Detect::Detect.new
		@detect.load_json
		@test_devices = CSV.open(File.join(File.dirname(__FILE__), '..', 'tests', 'test_devices.csv'))
	end
	
	describe "test_devices" do
	
		it "detects all test devices correctly" do
			@test_devices.each do |row|
				detection = @detect.device_type(row[2])
				expect(detection["type"]).to eq(row[1]), "Device: " + row[0] + " detect as " + detection["type"] + detection['categories'].inspect
				#detection["type"].should be(row[1]), "Device: " + row[0] + " detected as " + detection["type"] + " instead of " + row[1]
			end
		end
		
		it "should return 'none' for an unknown device" do
			detection = @detect.device_type("Funky unknown useragent string")
			expect(detection["type"]).to eq("none")
			expect(detection["categories"]).to eq("none")
		end
		
	end
	
	describe "is_mobile?" do
	
		it "should be true for an iPhone" do
			ua = "Mozilla/5.0 (iPhone; CPU iPhone OS 5_0 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9A334 Safari/7534.48.3"
			@detect.is_mobile?(ua).should be_true
		end

		it "should be false for an iPad" do
			ua = "Mozilla/5.0 (iPad; CPU OS 5_0 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9A334 Safari/7534.48.3"
			@detect.is_mobile?(ua).should be_false
		end
	
	end

	describe "is_tablet?" do
		it "should be true for an iPad" do
			ua = "Mozilla/5.0 (iPad; CPU OS 5_0 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9A334 Safari/7534.48.3"
			@detect.is_mobile?(ua).should be_false
			@detect.is_tablet?(ua).should be_true
		end
	
		it "should be false for an iPad" do
			ua = "Mozilla/5.0 (iPhone; CPU iPhone OS 5_0 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9A334 Safari/7534.48.3"
			@detect.is_tablet?(ua).should be_false
		end

	end
	
end
