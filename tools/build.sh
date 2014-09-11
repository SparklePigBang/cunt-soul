# Creates a PDF out of the README.md file

pandoc -f markdown_github -o rules.pdf README.md
pandoc -f markdown_github -t html5 -o rules.html README.md