PHP?=php
PHPOPTS=
PHPCMD=$(PHP) $(PHPOPTS)
CONSOLE?=bin/console
CONSOLEOPTS=
CONSOLECMD=$(PHPCMD) $(CONSOLE) $(CONSOLEOPTS)

COMPOSER:=$(shell if which composer &> /dev/null; then which composer; fi)
NPM:=$(shell if which npm &> /dev/null; then which npm; fi)
BOWER:=$(shell if which bower &> /dev/null; then which bower; fi)


help:
	@echo 'Makefile for a Symfony application           '
	@echo '                                             '
	@echo 'Usage:                                       '
	@echo '    make clear  clear the cache              '
	@echo '    make deps   install project dependencies '
	@echo '    make setup  setup project for development'
	@echo '                                             '

clear:
	$(CONSOLECMD) cache:clear

deps:
ifdef COMPOSER
	$(COMPOSER) install
endif
ifdef NPM
	$(NPM) install
endif
ifdef BOWER
	$(BOWER) install
endif

setup:
	$(CONSOLECMD) cache:clear
	$(CONSOLECMD) doctrine:migrations:migrate --no-interaction
	$(CONSOLECMD) h:d:f:l --no-interaction

.PHONY: help clear deps setup
