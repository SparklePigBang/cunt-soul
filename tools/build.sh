# Creates an HTML document and a PDF out of the README.md file
# Requirements: pandoc pdflatex

# Create a temporary directory, deleting the non-directory file `tmp` if it exists 
if [ ! -d tmp ]; then
	if [ -e tmp ]; then rm tmp; fi
	mkdir tmp
fi

# Generate the PDF by generating the latex file, making sure tables wrap, and then using pdflatex
pandoc \
	-f markdown_github \
	-o tmp/rules.latex \
	--variable geometry="margin=2cm" \
	--variable fontfamily="bookman" \
	--variable table-second-width="16cm" \
	--standalone \
	--smart \
	--template=templates/pandoc-template.latex \
	README.md
sed -i 's/{@{}ll@{}}/{@{}lp{16cm}@{}}/g' tmp/rules.latex
pdflatex -output-directory tmp rules.latex
mv -f tmp/rules.pdf .

# Generate the HTML page then sort out pandoc's weird email link issue
pandoc \
	-f markdown_github \
	-t html5 \
	-o rules.html \
	--smart \
	--standalone \
	--template=templates/pandoc-template.html5 \
	--email-obfuscation=none \
	README.md
sed -i 's#&lt;a href=&quot;mailto:\([-a-zA-Z0-9.@_]\+\)&quot;&gt;\1&lt;/a&gt;#\1#g' rules.html

# Clean up
rm -r tmp