Bundler.require(:default, :test)

require 'asciidoctor/mathml'

RSpec.configure do |config|
	config.disable_monkey_patching!
	
	config.expect_with :rspec do |c|
		c.syntax = :expect
	end
end
