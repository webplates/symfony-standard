PHP?=php
PHPOPTS=
PHPCMD=$(PHP) $(PHPOPTS)
CONSOLE?=bin/console
CONSOLEOPTS=
CONSOLECMD=$(PHPCMD) $(CONSOLE) $(CONSOLEOPTS)

COMPOSER:=$(shell if which composer > /dev/null 2>&1; then which composer; fi)
COMPOSEROPTS=
NPM:=$(shell if which npm > /dev/null 2>&1; then which npm; fi)
BOWER:=$(shell if which bower > /dev/null 2>&1; then which bower; fi)
GULPOPTS=

help:
	@echo 'Makefile for a Symfony application                  '
	@echo '                                                    '
	@echo 'Usage:                                              '
	@echo '    make clear     clear the cache                  '
	@echo '    make deps      install project dependencies     '
	@echo '    make setup     setup project for development    '
	@echo '                   set SCHEMA=true to update schema '
	@echo '                   set FIXTURES=true to run fixtures'
	@echo '    make frontend  execute frontend build           '
	@echo '    make test      execute test suite               '
	@echo '                   set COVERAGE=true to run coverage'
	@echo '                                                    '

clear:
	$(CONSOLECMD) cache:clear

deps:
ifdef COMPOSER
	$(COMPOSER) install $(COMPOSEROPTS)
endif
ifdef NPM
	$(NPM) install
endif
ifdef BOWER
	$(BOWER) install
endif

setup: clear
	$(CONSOLECMD) doctrine:migrations:migrate --allow-no-migration --no-interaction
ifeq ($(SCHEMA), true)
	$(CONSOLECMD) doctrine:schema:update --force --no-interaction
endif
ifeq ($(FIXTURES), true)
	$(CONSOLECMD) h:d:f:l --no-interaction
endif

frontend:
	gulp build $(GULPOPTS)

test:
	$(CONSOLECMD) lint:yaml -v --ansi app
ifeq ($(COVERAGE), true)
	vendor/bin/phpspec run -c phpspec.ci.yml
	vendor/bin/phpunit --coverage-text --coverage-clover build/coverage.clover
else
	vendor/bin/phpspec run
	vendor/bin/phpunit
endif
	vendor/bin/behat

.PHONY: help clear deps setup frontend test
