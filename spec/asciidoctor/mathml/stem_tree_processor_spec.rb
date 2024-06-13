RSpec.describe Asciidoctor::Mathml::StemTreeProcessor do
	describe 'stem mode conversion rules' do
		context 'when the document is in a not-available-by-default stem mode' do
			it 'does not convert regular stem to MathML' do
				expect(Asciidoctor.convert(<<~INPUT)).to eq <<~OUTPUT.chomp
					:stem: invalid_stem_mode
					
					== stem:[sin x]
					
					Engineers are famous for using stem:[pi = 3].
					Here is another famous engineer equation.
					
					[stem]
					++++
					sin x = x
					++++
					
					Expand this list with more examples!
					
					. stem:[e = 3]
				INPUT
					<div class="sect1">
					<h2 id="_sin_x">\\$sin x\\$</h2>
					<div class="sectionbody">
					<div class="paragraph">
					<p>Engineers are famous for using \\$pi = 3\\$.
					Here is another famous engineer equation.</p>
					</div>
					<div class="stemblock">
					<div class="content">
					\\$sin x = x\\$
					</div>
					</div>
					<div class="paragraph">
					<p>Expand this list with more examples!</p>
					</div>
					<div class="olist arabic">
					<ol class="arabic">
					<li>
					<p>\\$e = 3\\$</p>
					</li>
					</ol>
					</div>
					</div>
					</div>
				OUTPUT
			end
			
			it 'converts explicit asciimath stem to MathML' do
				expect(Asciidoctor.convert(<<~INPUT)).to eq <<~OUTPUT.chomp
					:stem: invalid_stem_mode
					
					== asciimath:[sin x]
					
					Engineers are famous for using asciimath:[pi = 3].
					Here is another famous engineer equation.
					
					[asciimath]
					++++
					sin x = x
					++++
					
					Expand this list with more examples!
					
					. asciimath:[e = 3]
				INPUT
					<div class="sect1">
					<h2 id="_sin_x"><math><mi>sin</mi><mi>x</mi></math></h2>
					<div class="sectionbody">
					<div class="paragraph">
					<p>Engineers are famous for using <math><mi>&#x3C0;</mi><mo>=</mo><mn>3</mn></math>.
					Here is another famous engineer equation.</p>
					</div>
					<div>
					<math><mi>sin</mi><mi>x</mi><mo>=</mo><mi>x</mi></math>
					</div>
					<div class="paragraph">
					<p>Expand this list with more examples!</p>
					</div>
					<div class="olist arabic">
					<ol class="arabic">
					<li>
					<p><math><mi>e</mi><mo>=</mo><mn>3</mn></math></p>
					</li>
					</ol>
					</div>
					</div>
					</div>
				OUTPUT
			end
			
			it 'does not prevent MathJax inclusion' do
				expect(Asciidoctor.convert(<<~INPUT, standalone: true)).to eq <<~OUTPUT.chomp
					:stem: invalid_stem_mode
					:reproducible: true
				INPUT
					<!DOCTYPE html>
					<html lang="en">
					<head>
					<meta charset="UTF-8">
					<meta http-equiv="X-UA-Compatible" content="IE=edge">
					<meta name="viewport" content="width=device-width, initial-scale=1.0">
					<meta name="generator" content="Asciidoctor 2.0.18">
					<title>Untitled</title>
					<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,300italic,400,400italic,600,600italic%7CNoto+Serif:400,400italic,700,700italic%7CDroid+Sans+Mono:400,700">
					<link rel="stylesheet" href="./asciidoctor.css">
					</head>
					<body class="article">
					<div id="header">
					</div>
					<div id="content">
					
					</div>
					<div id="footer">
					<div id="footer-text">
					</div>
					</div>
					<script type="text/x-mathjax-config">
					MathJax.Hub.Config({
					  messageStyle: "none",
					  tex2jax: {
					    inlineMath: [["\\\\(", "\\\\)"]],
					    displayMath: [["\\\\[", "\\\\]"]],
					    ignoreClass: "nostem|nolatexmath"
					  },
					  asciimath2jax: {
					    delimiters: [["\\\\$", "\\\\$"]],
					    ignoreClass: "nostem|noasciimath"
					  },
					  TeX: { equationNumbers: { autoNumber: "none" } }
					})
					MathJax.Hub.Register.StartupHook("AsciiMath Jax Ready", function () {
					  MathJax.InputJax.AsciiMath.postfilterHooks.Add(function (data, node) {
					    if ((node = data.script.parentNode) && (node = node.parentNode) && node.classList.contains("stemblock")) {
					      data.math.root.display = "block"
					    }
					    return data
					  })
					})
					</script>
					<script src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/MathJax.js?config=TeX-MML-AM_HTMLorMML"></script>
					</body>
					</html>
				OUTPUT
			end
		end
		
		context 'when the document is in latexmath stem mode' do
			it 'does not convert regular stem to MathML' do
				expect(Asciidoctor.convert(<<~INPUT)).to eq <<~OUTPUT.chomp
					:stem: latexmath
					
					== stem:[sin x]
					
					Engineers are famous for using stem:[pi = 3].
					Here is another famous engineer equation.
					
					[stem]
					++++
					sin x = x
					++++
					
					Expand this list with more examples!
					
					. stem:[e = 3]
				INPUT
					<div class="sect1">
					<h2 id="_sin_x">\\(sin x\\)</h2>
					<div class="sectionbody">
					<div class="paragraph">
					<p>Engineers are famous for using \\(pi = 3\\).
					Here is another famous engineer equation.</p>
					</div>
					<div class="stemblock">
					<div class="content">
					\\[sin x = x\\]
					</div>
					</div>
					<div class="paragraph">
					<p>Expand this list with more examples!</p>
					</div>
					<div class="olist arabic">
					<ol class="arabic">
					<li>
					<p>\\(e = 3\\)</p>
					</li>
					</ol>
					</div>
					</div>
					</div>
				OUTPUT
			end
			
			it 'converts explicit asciimath stem to MathML' do
				expect(Asciidoctor.convert(<<~INPUT)).to eq <<~OUTPUT.chomp
					:stem: latexmath
					
					== asciimath:[sin x]
					
					Engineers are famous for using asciimath:[pi = 3].
					Here is another famous engineer equation.
					
					[asciimath]
					++++
					sin x = x
					++++
					
					Expand this list with more examples!
					
					. asciimath:[e = 3]
				INPUT
					<div class="sect1">
					<h2 id="_sin_x"><math><mi>sin</mi><mi>x</mi></math></h2>
					<div class="sectionbody">
					<div class="paragraph">
					<p>Engineers are famous for using <math><mi>&#x3C0;</mi><mo>=</mo><mn>3</mn></math>.
					Here is another famous engineer equation.</p>
					</div>
					<div>
					<math><mi>sin</mi><mi>x</mi><mo>=</mo><mi>x</mi></math>
					</div>
					<div class="paragraph">
					<p>Expand this list with more examples!</p>
					</div>
					<div class="olist arabic">
					<ol class="arabic">
					<li>
					<p><math><mi>e</mi><mo>=</mo><mn>3</mn></math></p>
					</li>
					</ol>
					</div>
					</div>
					</div>
				OUTPUT
			end
			
			it 'does not prevent MathJax inclusion' do
				expect(Asciidoctor.convert(<<~INPUT, standalone: true)).to eq <<~OUTPUT.chomp
					:stem: latexmath
					:reproducible: true
				INPUT
					<!DOCTYPE html>
					<html lang="en">
					<head>
					<meta charset="UTF-8">
					<meta http-equiv="X-UA-Compatible" content="IE=edge">
					<meta name="viewport" content="width=device-width, initial-scale=1.0">
					<meta name="generator" content="Asciidoctor 2.0.18">
					<title>Untitled</title>
					<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,300italic,400,400italic,600,600italic%7CNoto+Serif:400,400italic,700,700italic%7CDroid+Sans+Mono:400,700">
					<link rel="stylesheet" href="./asciidoctor.css">
					</head>
					<body class="article">
					<div id="header">
					</div>
					<div id="content">
					
					</div>
					<div id="footer">
					<div id="footer-text">
					</div>
					</div>
					<script type="text/x-mathjax-config">
					MathJax.Hub.Config({
					  messageStyle: "none",
					  tex2jax: {
					    inlineMath: [["\\\\(", "\\\\)"]],
					    displayMath: [["\\\\[", "\\\\]"]],
					    ignoreClass: "nostem|nolatexmath"
					  },
					  asciimath2jax: {
					    delimiters: [["\\\\$", "\\\\$"]],
					    ignoreClass: "nostem|noasciimath"
					  },
					  TeX: { equationNumbers: { autoNumber: "none" } }
					})
					MathJax.Hub.Register.StartupHook("AsciiMath Jax Ready", function () {
					  MathJax.InputJax.AsciiMath.postfilterHooks.Add(function (data, node) {
					    if ((node = data.script.parentNode) && (node = node.parentNode) && node.classList.contains("stemblock")) {
					      data.math.root.display = "block"
					    }
					    return data
					  })
					})
					</script>
					<script src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.9/MathJax.js?config=TeX-MML-AM_HTMLorMML"></script>
					</body>
					</html>
				OUTPUT
			end
		end
		
		[
			['when the document is in asciimath stem mode', ':stem: asciimath'],
			['when the document has no stem mode set',      nil               ],
		].each do |context_description, document_stem_attribute|
			context context_description do
				define_method(:document_stem_attribute) { document_stem_attribute }
				
				it 'converts regular stem as asciimath to MathML' do
					expect(Asciidoctor.convert(<<~INPUT)).to eq <<~OUTPUT.chomp
						#{document_stem_attribute}
						
						== stem:[sin x]
						
						Engineers are famous for using stem:[pi = 3].
						Here is another famous engineer equation.
						
						[stem]
						++++
						sin x = x
						++++
						
						Expand this list with more examples!
						
						. stem:[e = 3]
					INPUT
						<div class="sect1">
						<h2 id="_sin_x"><math><mi>sin</mi><mi>x</mi></math></h2>
						<div class="sectionbody">
						<div class="paragraph">
						<p>Engineers are famous for using <math><mi>&#x3C0;</mi><mo>=</mo><mn>3</mn></math>.
						Here is another famous engineer equation.</p>
						</div>
						<div>
						<math><mi>sin</mi><mi>x</mi><mo>=</mo><mi>x</mi></math>
						</div>
						<div class="paragraph">
						<p>Expand this list with more examples!</p>
						</div>
						<div class="olist arabic">
						<ol class="arabic">
						<li>
						<p><math><mi>e</mi><mo>=</mo><mn>3</mn></math></p>
						</li>
						</ol>
						</div>
						</div>
						</div>
					OUTPUT
				end
				
				it 'converts explicit asciimath stem to MathML' do
					expect(Asciidoctor.convert(<<~INPUT)).to eq <<~OUTPUT.chomp
						#{document_stem_attribute}
						
						== asciimath:[sin x]
						
						Engineers are famous for using asciimath:[pi = 3].
						Here is another famous engineer equation.
						
						[asciimath]
						++++
						sin x = x
						++++
						
						Expand this list with more examples!
						
						. asciimath:[e = 3]
					INPUT
					<div class="sect1">
					<h2 id="_sin_x"><math><mi>sin</mi><mi>x</mi></math></h2>
					<div class="sectionbody">
					<div class="paragraph">
					<p>Engineers are famous for using <math><mi>&#x3C0;</mi><mo>=</mo><mn>3</mn></math>.
					Here is another famous engineer equation.</p>
					</div>
					<div>
					<math><mi>sin</mi><mi>x</mi><mo>=</mo><mi>x</mi></math>
					</div>
					<div class="paragraph">
					<p>Expand this list with more examples!</p>
					</div>
					<div class="olist arabic">
					<ol class="arabic">
					<li>
					<p><math><mi>e</mi><mo>=</mo><mn>3</mn></math></p>
					</li>
					</ol>
					</div>
					</div>
					</div>
					OUTPUT
				end
			end
			
			it 'prevents MathJax inclusion' do
				expect(Asciidoctor.convert(<<~INPUT, standalone: true)).to eq <<~OUTPUT.chomp
					#{document_stem_attribute}
					:reproducible: true
				INPUT
					<!DOCTYPE html>
					<html lang="en">
					<head>
					<meta charset="UTF-8">
					<meta http-equiv="X-UA-Compatible" content="IE=edge">
					<meta name="viewport" content="width=device-width, initial-scale=1.0">
					<meta name="generator" content="Asciidoctor 2.0.18">
					<title>Untitled</title>
					<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,300italic,400,400italic,600,600italic%7CNoto+Serif:400,400italic,700,700italic%7CDroid+Sans+Mono:400,700">
					<link rel="stylesheet" href="./asciidoctor.css">
					</head>
					<body class="article">
					<div id="header">
					</div>
					<div id="content">
					
					</div>
					<div id="footer">
					<div id="footer-text">
					</div>
					</div>
					</body>
					</html>
				OUTPUT
			end
		end
	end
	
	describe 'asciimath conversion' do
		it 'allows escaping of closing square brackets in inline stem' do
			expect(Asciidoctor.convert(<<~INPUT)).to eq <<~OUTPUT.chomp
				asciimath:[F[x\] = y]
			INPUT
				<div class="paragraph">
				<p><math><mi>F</mi><mrow><mo>[</mo><mi>x</mi></mrow></math> = y]</p>
				</div>
			OUTPUT
		end
		
		it 'prints a message when parsing failed' do
			expect{Asciidoctor.convert(<<~INPUT)}.to raise_error(NoMethodError, %q{asciidoctor: FAILED: <stdin>: Failed to load AsciiDoc document - undefined method `[]' for nil}).and output(<<~OUTPUT).to_stderr
				asciimath:[invalid"syntax]
			INPUT
				Failed to parse the following Asciimath code:
				
				invalid"syntax
			OUTPUT
		end
	end
end
