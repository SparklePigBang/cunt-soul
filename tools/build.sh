# Creates a PDF out of the README.md file

cd ..
pandoc -f markdown_github -t pdf -o rules.pdf README.md
pandoc -f markdown_github -t html5 -o rules.html README.md