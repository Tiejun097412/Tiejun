
Poem = Poem

all_file = ${Poem}.tex 

pdf: ${Poem}.pdf

${Poem}.pdf: ${all_file}
	xelatex ${Poem}.tex
	bibtex  ${Poem}.aux
	xelatex ${Poem}.tex
	xelatex ${Poem}.tex
	evince  ${Poem}.pdf&

view:
	evince ${Poem}.pdf&

.PHONY:clean  
clean:
	-rm -f *.ps *.dvi *.aux *.toc *.idx *.ind *.ilg *.log *.out *~ *.tid *.tms *.pdf *.bak *.blg *.bbl

