# Makefile for ThuThesis

# Compiling method: xelatex
METHOD = xelatex
# Basename of thesis
THESISMAIN = thesis
# Basename of shuji
SHUJIMAIN = shuji

PACKAGE=tongjithesis
EPS=$(wildcard figures/*.eps)
THESISCONTENTS=$(THESISMAIN).tex chapters/*.tex $(EPS)
BIBFILE=/Users/wangjian/Dropbox/Papers/library.bib
SHUJICONTENT=$(SHUJIMAIN).tex
CLSFILE=$(PACKAGE).cls $(PACKAGE).cfg

# make deletion work on Windows
ifdef SystemRoot
   RM = del /Q
else
   RM = rm -f
endif

###### for thesis

thesis: clean $(THESISMAIN).pdf

ifeq ($(METHOD), xelatex)

$(THESISMAIN).pdf: $(CLSFILES) $(THESISCONTENTS) $(THESISMAIN).bbl
	xelatex -shell-escape $(THESISMAIN)
	xelatex -shell-escape $(THESISMAIN)

$(THESISMAIN).bbl: $(BIBFILE)
	xelatex -shell-escape $(THESISMAIN)
	-bibtex $(THESISMAIN)
	-$(RM) $(THESISMAIN).pdf

endif

###### for shuji
shuji: $(SHUJIMAIN).pdf

ifeq ($(METHOD),xelatex)

$(SHUJIMAIN).pdf: $(CLSFILES) $(SHUJICONTENTS)
	xelatex -shell-escape $(SHUJIMAIN).tex

endif

clean: 
	-@$(RM) \
		*~ \
		*.aux \
		*.bak \
		*.bbl \
		*.blg \
		*.dvi \
		*.glo \
		*.gls \
		*.idx \
		*.ilg \
		*.ind \
		*.ist \
		*.log \
		*.out \
		*.ps \
		*.thm \
		*.toc \
		*.lof \
		*.lot \
		*.loe \
		chapters/*.aux \
		chapters/*.log

