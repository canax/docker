#!/usr/bin/env make
#
# An Anax module.
# See organisation on GitHub: https://github.com/canax

# ------------------------------------------------------------------------
#
# General stuff, reusable for all Makefiles.
#

# Detect OS
OS = $(shell uname -s)

# Defaults
ECHO = echo

# Make adjustments based on OS
ifneq (, $(findstring CYGWIN, $(OS)))
	ECHO = /bin/echo -e
endif

# Colors and helptext
NO_COLOR	= \033[0m
ACTION		= \033[32;01m
OK_COLOR	= \033[32;01m
ERROR_COLOR	= \033[31;01m
WARN_COLOR	= \033[33;01m

# Which makefile am I in?
WHERE-AM-I = $(CURDIR)/$(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
THIS_MAKEFILE := $(call WHERE-AM-I)

# Echo some nice helptext based on the target comment
HELPTEXT = $(ECHO) "$(ACTION)--->" `egrep "^\# target: $(1) " $(THIS_MAKEFILE) | sed "s/\# target: $(1)[ ]*-[ ]* / /g"` "$(NO_COLOR)"

# Check version  and path to command and display on one line
CHECK_VERSION = printf "%-15s %-10s %s\n" "`basename $(1)`" "`$(1) --version $(2)`" "`which $(1)`"

# Print out colored action message
ACTION_MESSAGE = $(ECHO) "$(ACTION)---> $(1)$(NO_COLOR)"



# target: help                    - Displays help.
.PHONY:  help
help:
	@$(call HELPTEXT,$@)
	@sed '/^$$/q' $(THIS_MAKEFILE) | tail +3 | sed 's/#\s*//g'
	@$(ECHO) "Usage:"
	@$(ECHO) " make [target] ..."
	@$(ECHO) "target:"
	@egrep "^# target:" $(THIS_MAKEFILE) | sed 's/# target: / /g'



# ------------------------------------------------------------------------
#
# Specifics for this project.
#
D  := docker
DC := docker-compose



# target: update                  - Create the Dockerfiles from source.
.PHONY: update
update:
	@$(call HELPTEXT,$@)
	./update.bash



# target: build                   - Build the docker images.
.PHONY: build
build: update build-php-cli build-php-apache build-remserver
	@$(call HELPTEXT,$@)
	#--no-cache 



# target: build-php-cli           - Build images php-cli (option="--no-cache").
.PHONY: build-php-cli
build-php-cli: update
	@$(call HELPTEXT,$@)
	$(D) build $(options) --file php74/cli/Dockerfile  \
		--tag anax/dev:latest               \
		--tag anax/dev:cli                  \
		--tag anax/dev:latest-cli           \
		--tag anax/dev:php74                \
		--tag anax/dev:php74-cli            \
		php74/cli
	$(D) build $(options) --file php73/cli/Dockerfile  \
		--tag anax/dev:php73                \
		--tag anax/dev:php73-cli            \
		php73/cli
	$(D) build $(options) --file php72/cli/Dockerfile  \
		--tag anax/dev:php72                \
		--tag anax/dev:php72-cli            \
		php72/cli
	$(D) build $(options) --file php71/cli/Dockerfile  \
		--tag anax/dev:php71                \
		--tag anax/dev:php71-cli            \
		php71/cli
	$(D) build $(options) --file php70/cli/Dockerfile  \
		--tag anax/dev:php70                \
		--tag anax/dev:php70-cli            \
		php70/cli
	$(D) build $(options) --file php56/cli/Dockerfile  \
		--tag anax/dev:php56                \
		--tag anax/dev:php56-cli            \
		php56/cli



# target: build-php-apache        - Build images php-apache.
.PHONY: build-php-apache
build-php-apache: update
	@$(call HELPTEXT,$@)
	$(D) build $(options) --file php74/apache/Dockerfile  \
		--tag anax/dev:apache		           \
		--tag anax/dev:latest-apache           \
		--tag anax/dev:php74-apache            \
		php74/apache
	$(D) build $(options) --file php73/apache/Dockerfile  \
		--tag anax/dev:php73-apache            \
		php73/apache
	$(D) build $(options) --file php72/apache/Dockerfile  \
		--tag anax/dev:php72-apache            \
		php72/apache
	$(D) build $(options) --file php71/apache/Dockerfile  \
		--tag anax/dev:php71-apache            \
		php71/apache
	$(D) build $(options) --file php70/apache/Dockerfile  \
		--tag anax/dev:php70-apache            \
		php70/apache
	$(D) build $(options) --file php56/apache/Dockerfile  \
		--tag anax/dev:php56-apache            \
		php56/apache



# target: build-remserver         - Build images remserver.
.PHONY: build-remserver
build-remserver: update
	@$(call HELPTEXT,$@)
	$(D) build $(options) \
		--file php72/apache/Dockerfile-clone-repo-make-install 	\
		--build-arg REPO=https://github.com/canax/remserver-website.git	\
		--tag anax/dev:remserver	           \
		--tag anax/dev:remserver-apache        \
		--tag anax/dev:remserver-php72         \
		--tag anax/dev:remserver-php72-apache  \
		php72/apache



# target: push                    - Push the docker images to Docker cloud.
.PHONY: push
push:
	@$(call HELPTEXT,$@)
	# cli
	$(D) push anax/dev:latest
	$(D) push anax/dev:cli
	$(D) push anax/dev:latest-cli
	# $(D) push anax/dev:php74
	# $(D) push anax/dev:php74-cli
	$(D) push anax/dev:php73
	$(D) push anax/dev:php73-cli
	$(D) push anax/dev:php72
	$(D) push anax/dev:php72-cli
	$(D) push anax/dev:php71
	$(D) push anax/dev:php71-cli
	$(D) push anax/dev:php70
	$(D) push anax/dev:php70-cli
	$(D) push anax/dev:php56
	$(D) push anax/dev:php56-cli

	# Apache
	$(D) push anax/dev:apache
	$(D) push anax/dev:latest-apache
	# $(D) push anax/dev:php74-apache
	$(D) push anax/dev:php73-apache
	$(D) push anax/dev:php72-apache
	$(D) push anax/dev:php71-apache
	$(D) push anax/dev:php70-apache
	$(D) push anax/dev:php56-apache

	# REM server
	$(D) push anax/dev:remserver
	$(D) push anax/dev:remserver-apache
	$(D) push anax/dev:remserver-php72
	$(D) push anax/dev:remserver-php72-apache
