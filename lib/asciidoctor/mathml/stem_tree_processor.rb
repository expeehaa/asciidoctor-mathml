require 'asciimath'

module Asciidoctor
	module Mathml
		# Inspired by https://github.com/asciidoctor/asciidoctor-mathematical/blob/6316a270ec6e58a2735f626b089372c5c169aac7/lib/asciidoctor-mathematical/extension.rb
		class StemTreeProcessor < Asciidoctor::Extensions::TreeProcessor
			def process(document)
				if document.backend=='html5'
					default_stem = ['asciimath', nil].include?(document.attr('stem')) ? 'asciimath' : document.attr('stem')
					
					document.find_by(context: :stem, traverse_documents: true).each do |node|
						handle_asciimath_stem_block(node, default_stem)
					end
					
					document.find_by(traverse_documents: true) do |node|
						node.subs && node.subs.include?(:macros)
					end.each do |node|
						handle_prose_block(node, default_stem)
					end
					
					document.find_by(context: :section) do |node|
						handle_section_title(node, default_stem)
					end
					
					# TODO: Remove the need for the condition by converting latexmath to MathML.
					if default_stem=='asciimath'
						# Ensure that the default html5 backend does not add MathJax.
						document.remove_attr('stem')
						document.instance_variable_get(:@header_attributes).delete('stem')
					end
				end
			end
			
			def handle_asciimath_stem_block(node, default_stem)
				if node.attributes[1]=='asciimath' || (node.attributes[1]=='stem' && default_stem=='asciimath')
					node.parent.blocks[node.parent.blocks.index(node)] = create_pass_block(node.parent, <<~HTML, {})
						<div#{node.id ? %Q{ id="#{node.id}"} : ''}#{node.role ? %Q{ class="#{node.role}"} : ''}>
						#{convert_asciimath_to_mathml(node.content)}
						</div>
					HTML
				end
			end
			
			def handle_prose_block(node, default_stem)
				if [:list_item, :table_cell].include?(node.context)
					convert_inline_stem(node.instance_variable_get(:@text), default_stem).tap do |converted_text|
						if !converted_text.nil?
							node.text = converted_text
						end
					end
				else
					convert_inline_stem(node.lines.join("\n"), default_stem).tap do |converted_lines|
						if !converted_lines.nil?
							node.lines = converted_lines.split("\n")
						end
					end
				end
			end
			
			def handle_section_title(node, default_stem)
				convert_inline_stem(node.instance_variable_get(:@title), default_stem).tap do |converted_title|
					if !converted_title.nil?
						node.title = converted_title
					end
				end
			end
			
			def convert_inline_stem(text, default_stem)
				if text
					text.gsub(Asciidoctor::InlineStemMacroRx) do
						match = $~
						
						if match[0].start_with?('\\') # Do not convert the match if the stem macro is escaped.
							match[0][1..-1]
						elsif match[1]!='asciimath' && (match[1]=='stem' && default_stem!='asciimath') # Do not convert the match if it is not designated as asciimath.
							match[0]
						elsif match[3].rstrip.empty?
							''
						else
							%Q{pass:[#{convert_asciimath_to_mathml(match[3].gsub('\\]', ']').rstrip).gsub(']', '\\]')}]}
						end
					end
				else
					nil # No conversion required.
				end
			end
			
			def convert_asciimath_to_mathml(text)
				AsciiMath.parse(CGI.unescape_html(text)).to_mathml
			rescue StandardError
				warn <<~MESSAGE
					Failed to parse the following Asciimath code:
					
					#{text}
				MESSAGE
				
				raise
			end
		end
	end
end
