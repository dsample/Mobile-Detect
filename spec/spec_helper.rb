require 'simplecov'
require 'coveralls'
Coveralls.wear!
SimpleCov.start

require 'csv'
require 'mobile_detect'

RSpec.configure do |config|
	config.treat_symbols_as_metadata_keys_with_true_values = true
	config.run_all_when_everything_filtered = true
	#config.filter_run :focus

	config.order = 'random'
end