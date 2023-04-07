require 'asciidoctor'

require_relative 'mathml/stem_tree_processor'
require_relative 'mathml/version'

module Asciidoctor
	module Mathml
		Asciidoctor::Extensions.register do
			treeprocessor Asciidoctor::Mathml::StemTreeProcessor
		end
	end
end
