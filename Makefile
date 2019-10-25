PY?=python3
PELICAN?=pelican
PELICANOPTS= -t ./notmyidea

export LANG=C

BASEDIR=$(CURDIR)
INPUTDIR=$(BASEDIR)/content
OUTPUTDIR=$(BASEDIR)/output
CONFFILE=$(BASEDIR)/pelicanconf.py
PUBLISHCONF=$(BASEDIR)/publishconf.py

DEBUG ?= 0
ifeq ($(DEBUG), 1)
	PELICANOPTS += -D
endif

RELATIVE ?= 0
ifeq ($(RELATIVE), 1)
	PELICANOPTS += --relative-urls
endif

help:
	@echo 'Makefile for a pelican Web site                                 '
	@echo '                                                                '
	@echo 'Usage:                                                          '
	@echo '  make html               (re)generate the web site             '
	@echo '  make clean              remove the generated files            '
	@echo '  make regenerate         regenerate files upon modification    '
	@echo '  make publish            generate using production settings    '
	@echo '  make serve [PORT=8000]  serve site at http://localhost:8000   '
	@echo '  make rsync              copy production files to mimiker      '
	@echo '                                                                '
	@echo 'Set the DEBUG variable to 1 to enable debugging.                '
	@echo 'Set the RELATIVE variable to 1 to enable relative urls          '
	@echo '                                                                '

html:
	$(PELICAN) $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS)

clean:
	[ ! -d $(OUTPUTDIR) ] || rm -rf $(OUTPUTDIR)
	rm -rf __pycache__
	find -iname '*~' -delete

regenerate:
	$(PELICAN) -r $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS)

serve:
ifdef PORT
	$(PELICAN) -lr $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS) -p $(PORT)
else
	$(PELICAN) -lr $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS)
endif

publish:
	$(PELICAN) $(INPUTDIR) -o $(OUTPUTDIR) -s $(PUBLISHCONF) $(PELICANOPTS)

rsync: publish
	rsync -avz output/ mimiker:/var/www/html/

.PHONY: html help clean regenerate serve publish rsync

# vim: ts=8 sw=8 noet
