require_relative 'lib/asciidoctor/mathml/version'

Gem::Specification.new do |spec|
	spec.name    = 'asciidoctor-mathml'
	spec.version = Asciidoctor::Mathml::VERSION
	spec.authors = ['expeehaa']
	spec.email   = ['expeehaa@outlook.com']
	
	spec.summary  = 'AsciiDoctor extension to convert STEM to MathML'
	spec.homepage = 'https://github.com/expeehaa/asciidoctor-mathml'
	spec.license  = 'MIT'
	
	spec.metadata['allowed_push_host'] = 'https://rubygems.org'
	spec.metadata['homepage_uri'     ] = spec.homepage
	spec.metadata['source_code_uri'  ] = 'https://github.com/expeehaa/asciidoctor-mathml'
	
	spec.files         = Dir['lib/**/*']
	spec.require_paths = ['lib']
	
	spec.add_runtime_dependency 'asciidoctor'
	spec.add_runtime_dependency 'asciimath'
end
