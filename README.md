kkuthesis
=========

KKU Thesis is a LaTex and BiBTex classes. 

It forks from https://sourceforge.net/projects/kkuthesis/, 
KKU Thesis LaTeX Class by Aj.Kittiong.

Difference 
========

1. Add support to write thesis in English and some BibTeX format suported.

2. Use pdflatex intead of latex command 

Main Files
========

*.ttx  - working files, these files will be convert to *.tex files

kkuthesis.cls - latex class file for English kkuthesis

REFERENCES.bib - example BibTeX database file

kkuapa.bst - BibTex in APA reference style 

publication/*.jpg  - example publication 

image/* example images,

Usage
========
1. Copy all file to working directory

2. Segment Thai words from each working file (.ttx) to LaTeX file (.tex) 

	swath -f latex -u u,t < thesis.ttx > thesis.tex

3. start latex twice, first for generate, second for update table of content

	pdflatex thesis.tex
	
	pdflatex thesis.tex

4. start BiBTex processor, and then regenerate latex outputfile

	bibtex thesis.aux
	pdflatex thesis.tex
