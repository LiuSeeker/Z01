# Produce PDFs from all Markdown files in a directory
# Lincoln Mullen | http://lincolnmullen.com | lincoln@lincolnmullen.com

## Markdown Template
TEMP-PWD = /home/corsi/tmp/Corsi-Pandoc-Class-Handout
TEMP-TEXT = $(TEMP-PWD)/InsperTemplate.tex
TEMP-SLIDE = $(TEMP-PWD)/InsperTemplateSlide.tex
TEMP-FILTER = $(TEMP-PWD)/filterBox.py
HEADER = $(TEMP-PWD)/cabecalho.png
LOGO = $(TEMP-PWD)/logo.pdf

## SRC
FILE-EXTRA = I-Ferramental
FILE-PROJETO = I-VM

all : EXTRA, PROJETO

PROJETO:	$(FILE-PROJETO).md
	pandoc $< --template=$(TEMP-TEXT) --variable logo=$(LOGO) --variable header=$(HEADER) -f markdown --filter pandoc-latex-tip --filter $(TEMP-FILTER) --pdf-engine=xelatex	-o $(FILE-PROJETO).pdf

EXTRA:	$(FILE-EXTRA).md
	pandoc $< --template=$(TEMP-TEXT) --variable logo=$(LOGO) --variable header=$(HEADER) -f markdown --filter pandoc-latex-tip --filter $(TEMP-FILTER) --pdf-engine=xelatex	-o $(FILE-EXTRA).pdf

EXTRA2:	$(FILE-EXTRA2).md
	pandoc $< --template=$(TEMP-TEXT) --variable logo=$(LOGO) --variable header=$(HEADER) -f markdown --filter pandoc-latex-tip --filter $(TEMP-FILTER) --pdf-engine=xelatex	-o $(FILE-EXTRA2).pdf
