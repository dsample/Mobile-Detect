require 'json'
require 'to_regexp'
class Detect
	def load_json
		@rules = JSON.parse(IO.read('mobile_detect.json'))
		return @rules
	end
	
	def device_type(ua)
	
		device_types = ["mobile", "tablet", "desktop"]

		results = Hash.new
		result = Hash.new

		device_types.each do |type|
			matches = check_against_patterns ua, @rules[type]
			results[type] = matches unless matches.count == 0
		end
		
		if results.count == 0
			result["type"] = "none"
			result["categories"] = "none"
		else
			categories = Array.new
			results.each do |key, value|
				value.each do |category|
					categories << key + ":" + category
				end
			end
			
			result["type"] = results.keys.join(",")
			result["categories"] = categories.join(",")
		end
		
		return result
	end
	
	def is_mobile(ua)
		categories = check_against_patterns ua, @rules['mobiles']
		if categories.count > 0
			categories.each do |c|
				puts c
			end
		end
	end
	
	def is_tablet(ua)
		categories = check_against_patterns ua, @rules['tablets']
		if categories.count > 0
			categories.each do |c|
				puts c
			end
		end
	end
	
	def check_against_patterns(subject, patterns_json)
		matches = Array.new
		patterns_json.each do |o|
			unless o['regex'].empty?
				if subject =~ ("/" + o['regex'] + "/").to_regexp
					puts "1: " + o['category'] + " : " + o['regex']
					matches << o['category']
				else
					puts "0: " + o['category'] + " : " + o['regex']
				end
			end
		end
		return matches
	end
end

#detect = Detect.new
#detect.load_json
#ua = "Mozilla/5.0(iPad; U; CPU iPhone OS 3_2 like Mac OS X; en-us) AppleWebKit/531.21.10 (KHTML, like Gecko) Version/4.0.4 Mobile/7B314 Safari/531.21.10"
#puts detect.device_type ua
#ua = "Mozilla/5.0 (Linux; Android 4.1.1; Nexus 7 Build/JRO03D) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.166  Safari/535.19"
#puts detect.device_type ua
