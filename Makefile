# ---------------------------------------------------------------------------
#
# General setup
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

# target: help                    - Displays help with targets available.
.PHONY:  help
help:
	@$(call HELPTEXT,$@)
	@$(ECHO) "Usage:"
	@$(ECHO) " make [target] ..."
	@$(ECHO) "target:"
	@egrep "^# target:" Makefile | sed 's/# target: / /g'



# ---------------------------------------------------------------------------
#
# Specifics
# 
D  := docker
DC := docker-compose



# target: build                   - Build the docker images.
.PHONY: build
build:
	@$(call HELPTEXT,$@)
	#--no-cache=true 
	$(D) build --file php72/apache/Dockerfile  \
		--tag anax/dev:latest                  \
		--tag anax/dev:php72                   \
		--tag anax/dev:php72-apache            \
		php72/apache
	$(D) build --file php71/apache/Dockerfile  \
		--tag anax/dev:php71                   \
		--tag anax/dev:php71-apache            \
		php71/apache
	$(D) build --file php70/apache/Dockerfile  \
		--tag anax/dev:php70                   \
		--tag anax/dev:php70-apache            \
		php70/apache
	$(D) build --file php56/apache/Dockerfile  \
		--tag anax/dev:php56                   \
		--tag anax/dev:php56-apache            \
		php56/apache
 


# target: push                    - Push the docker images to Docker cloud.
.PHONY: push
push:
	@$(call HELPTEXT,$@)
	$(D) push anax/dev:latest
	$(D) push anax/dev:php72
	$(D) push anax/dev:php72-apache
	$(D) push anax/dev:php71
	$(D) push anax/dev:php71-apache
	$(D) push anax/dev:php70
	$(D) push anax/dev:php70-apache
	$(D) push anax/dev:php56
	$(D) push anax/dev:php56-apache
