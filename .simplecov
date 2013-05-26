require 'simplecov-gem-adapter'

if ENV['TRAVIS']
	require 'coveralls'
	Coveralls.wear!
else
	SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
		SimpleCov::Formatter::HTMLFormatter
	]
end

#SimpleCov.at_exit do
#  SimpleCov.minimum_coverage 90	# Set a minimum coverage threshold
#  SimpleCov.maximum_coverage_drop 5	# Don't allow more than this percentage drop
#  SimpleCov.refuse_coverage_drop	# Don't allow any drop in coverage
#end

SimpleCov.start 'gem' do
	add_filter '/spec/'
end
