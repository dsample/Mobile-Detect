lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mobile_detect/version'

Gem::Specification.new do |gem|
	gem.name	= "mobile_detect"
	gem.version	= Mobile_Detect::VERSION
	gem.authors	= ['Duncan Sample']
	gem.email	= ['gems@antimatters.co.uk']
	gem.description	= %q{Mobile_Detect}
	gem.summary	= %q{Detect mobiles and tablets}
	gem.homepage	= 'https://github.com/dsample/Mobile-Detect'
	gem.license	= 'Apache2'

	gem.add_runtime_dependency 'json'
	gem.add_runtime_dependency 'to_regexp'
	gem.add_runtime_dependency 'rake'

	gem.files	= `git ls-files`.split($/)
	gem.executables	= gem.files.grep(%r{^bin/}).map{|f| File.basename(f)}
	gem.test_files	= gem.files.grep(%r{^(test|spec)})
	gem.require_paths	= ['lib']
end
