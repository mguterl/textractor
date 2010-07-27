#
# Makefile for docx2txt
#

INSTALLDIR ?= /usr/local/bin

INSTALL = $(shell which install 2>/dev/null)
ifeq ($(INSTALL),)
$(error "Need 'install' to install docx2txt")
endif

PERL = $(shell which perl 2>/dev/null)
ifeq ($(PERL),)
$(warning "*** Make sure 'perl' is installed and is in your PATH, before running the installed script. ***")
endif

Dx2TFILES = docx2txt.sh docx2txt.pl docx2txt.config

install: $(Dx2TFILES)
	[ -d $(INSTALLDIR) ] || mkdir -p $(INSTALLDIR)
	$(INSTALL) -m 755 $^ $(INSTALLDIR)

.PHONY: install
