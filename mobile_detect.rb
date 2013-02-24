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
		categories = check_against_patterns ua, @rules['mobile']
		if categories.count > 0
			categories.each do |c|
				puts c
			end
		end
	end
	
	def is_tablet(ua)
		categories = check_against_patterns ua, @rules['tablet']
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
					#puts "1: " + o['category'] + " : " + o['regex']
					matches << o['category']
				else
					#puts "0: " + o['category'] + " : " + o['regex']
				end
			end
		end
		return matches
	end
end
