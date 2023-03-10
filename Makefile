# Makefile.in
#
# BitchX - by panasync
#
# targets recognised by this Makefile:
#   all, everything	- compiles BitchX [wserv, scr-bx, plugins]
#   wserv		- compiles wserv
#   scr-bx		- compiles scr-bx
#   dll			- compiles plugins
#   install		- installs BitchX [wserv, scr-bx] [plugins] scripts
#			  man pages help and translation
#   installirc		- installs BitchX [wserv, scr-bx]
#   installwserv	- installs wserv
#   installscr-bx	- installs scr-bx
#   installdll		- installs plugins
#   installscript	- installs the scripts
#   installtranslation	- installs the translation tables
#   installhelp		- installs the help files
#   installman		- installs the manual pages
#   installeverything	- all of the above
#   install_local	- installs BitchX to your home directory
#   clean		- remove all .o files, core, and binaries
#   distclean		- remove all files geneated by compilation/installation
#   bxconf		- compiles and runs bx-configure
#   distrib		- makes a tarball of the BitchX binaries
#   windistrib		- makes a tarball of the BitchX binaries on Win32
#   package		- makes a tarball of the BitchX source
#   depend		- computes the dependencies

SHELL = /bin/sh

srcdir = .

top_srcdir = .
topdir = /home/qowevisa/gits/bitchx
prefix = /usr/local
exec_prefix = ${prefix}

bindir = ${exec_prefix}/bin
sbindir = ${exec_prefix}/sbin
libexecdir = ${exec_prefix}/libexec
datadir = ${prefix}/share
sysconfdir = ${prefix}/etc
sharedstatedir = ${prefix}/com
localstatedir = ${prefix}/var
libdir = ${exec_prefix}/lib
infodir = ${prefix}/share/info
mandir = ${prefix}/share/man
includedir = ${prefix}/include
oldincludedir = /usr/include

local_dir = $(HOME)

# Where the BitchX binary will be installed.
# "make install" will compile and install the program.
INSTALL_IRC = ${bindir}/$(_VERSION_)$(EXEEXT)

# Where the BitchX library will be. Generally this is the place that
# you put the scripts, help pages and translation tables. It is
# very important that you set this correctly.
IRCLIB = ${libdir}/bx

CC = gcc
CPPFLAGS =  -I. -I$(topdir)/include -I$(top_srcdir)/include -I$(srcdir) -I$(srcdir)/include -DHAVE_CONFIG_H
LIBS =  -ltinfo -lm -lcrypt

# Tcl library.
TCL_LIBS = 

# These are for Tcl support.
TCL_OBJS = 
# You don't have the following, so you'll want to leave this blank.
TCL_SRCS = 

# Set this to -g if you want to be able to debug the client, otherwise
# use -O to have the compiler do some optimization instead.
CFLAGS =  -g -O2 -fno-strict-aliasing -Wall

# Set this to -s if you want the binary to be stripped.
LDFLAGS = 

# These are for the cd device player.
CD_SRCS = 
CD_OBJS = 

# This is the executable suffix for the target operating system.
EXEEXT = 

# Extra files.
DEFAULT_CTOOLZ_DIR = ~/.BitchX
DEFAULT_MSGLOGFILE = BitchX.away
DEFAULT_BITCHX_HELP_FILE = BitchX.help
DEFAULT_SCRIPT_HELP_FILE = BitchX.help
DEFAULT_BITCHX_KICK_FILE = BitchX.kick
DEFAULT_BITCHX_QUIT_FILE = BitchX.quit
DEFAULT_BITCHX_IRCNAME_FILE = BitchX.ircnames

# Full path of the directory for BitchX help files.
HELPDIR = $(IRCLIB)/help

# Full path of the directory for the BitchX scripts.
INSTALL_SCRIPT = $(IRCLIB)/script

# Default setting for IRCPATH where BitchX will look for
# its script files if the environment variable is undefined.
# Usually, this should contain the same path as used for INSTALL_SCRIPT in
# the Makefile, but it can contain multiple path elements
# separated by colons. The path MUST lead to an existing directory,
# because the 'global' script is expected to be found there.
IRCPATH = $(DEFAULT_CTOOLZ_DIR):$(DEFAULT_CTOOLZ_DIR)/plugins:.:$(PLUGINDIR):$(INSTALL_SCRIPT):$(IRCLIB)

# Path for TRANSLATION variable.
TRANSLATION_PATH = $(IRCLIB)/translation

# This is where the optional plugins will be copied to.
PLUGINDIR = $(IRCLIB)/plugins

# Plugin flags.
SHLIB_LD = gcc -shared
SHLIB_CFLAGS = 
SHLIB_SUFFIX = .so

# This command will be used to install the BitchX files on Win32/OS2EMX
# systems.
WINNT_INSTALL = 

# This program allows you to use screen/xterm's to put new BitchX windows
# on new screen/xterm windows.
INSTALL_WSERV = $(IRCLIB)/wserv$(EXEEXT)

# This program allows you to screen BitchX and reattach to it later.
INSTALL_SCRBX = ${bindir}/scr-bx$(EXEEXT)

# Set gzip and bzip2 options.
GZIP_ENV = --best
BZIP2 = -9 --repetitive-best

# Standard programs.
RM = rm -f
LN = ln -s
CP = cp -f
MV = mv -f

INSTALL = /usr/bin/install -c
INSTALL_DATA = ${INSTALL} -m 644

VERSION = BitchX-1.2.1
_VERSION_ = BitchX

MAKE_BIN = make
MAKE = $(MAKE_BIN) $(MFLAGS)
MFLAGS = \
	'local_dir=$(HOME)'				\
	'INSTALL_IRC=$(INSTALL_IRC)'			\
	'IRCLIB=$(IRCLIB)'				\
	'CC=$(CC)'					\
	'CFLAGS=$(CFLAGS)'				\
	'HELPDIR=$(HELPDIR)'				\
        'INSTALL_WSERV=$(INSTALL_WSERV)'                \
	'IRCPATH=$(IRCPATH)'				\
	'TRANSLATION_PATH=$(TRANSLATION_PATH)'		\
	'LDFLAGS=$(LDFLAGS)'				\
	'LIBS=$(LIBS)'					\
	'LN=$(LN)'					\
	'RM=$(RM)'					\
	'TCL_SRCS=$(TCL_SRCS)'				\
	'TCL_OBJS=$(TCL_OBJS)'				\
	'CD_PLAY=$(CD_PLAY)'				\
	'CD_SRCS=$(CD_SRCS)'				\
	'CD_OBJS=$(CD_OBJS)'				\
	'TCL_LIBS=$(TCL_LIBS)'				\
	'PLUGINDIR=$(PLUGINDIR)'			\
	'_VERSION_=$(_VERSION_)'			\
	'VERSION=$(VERSION)'				\
	'INSTALL_DATA=$(INSTALL_DATA)'			\
	'INSTALL_SCRIPT=$(INSTALL_SCRIPT)'		\
	'EXEEXT=$(EXEEXT)'				\
	'SHLIB_CFLAGS=$(SHLIB_CFLAGS)'			\
	'SHLIB_SUFFIX=$(SHLIB_SUFFIX)'

## Makefile starts here.

all: Makefile .config.h $(_VERSION_) wserv scr-bx dll done

.config.h:
	@if test ! -f $(topdir)/.config.h ; then touch $(topdir)/.config.h; fi

install: all installbin installdll installscript installman installhelp \
	installtranslation reallydone

installeverything: install

everything: all

$(_VERSION_): .config.h
	cd source \
	  && $(MAKE) all

dll/dummy:

dll: .config.h $(srcdir)/Makefile dll/Makefile dll/dummy
	cd dll \
	  && $(MAKE) all

installdll: $(srcdir)/Makefile dll/Makefile installdirs dll
	cd dll \
	  && $(MAKE) 'DESTDIR=$(DESTDIR)' install

installdll_local: $(srcdir)/Makefile dll/Makefile
	cd dll \
	  && $(MAKE) 'PLUGINDIR=$(local_dir)/.BitchX/plugins'

installhelp: installdirs
	cd $(top_srcdir)/bitchx-docs && \
		for d in `find . -name .svn -prune -o -type d ! -name . -print`; do \
			umask 022 && ../mkinstalldirs "$(DESTDIR)$(HELPDIR)/$$d"; \
			for f in "$$d/"*; do \
				if test -f "$$f"; then \
					$(INSTALL_DATA) "$$f" "$(DESTDIR)$(HELPDIR)/$$d"; \
				fi; \
			done; \
		done
	for f in $(top_srcdir)/bitchx-docs/*; do \
		if test -f "$$f"; then \
			$(INSTALL_DATA) "$$f" "$(DESTDIR)$(HELPDIR)"; \
		fi; \
	done;
	-(find "$(DESTDIR)$(HELPDIR)" -type f ! -name '*.bz2' ! -name '*.gz' | \
		(xargs bzip2 -9f || xargs gzip -9f)) 2>/dev/null

installbin: installirc installwserv installscr-bx

installirc: installdirs $(_VERSION_)
	$(INSTALL) source/$(_VERSION_)$(EXEEXT) $(DESTDIR)$(bindir)/$(VERSION)$(EXEEXT)
	$(RM) $(DESTDIR)$(INSTALL_IRC)
	$(LN) $(VERSION)$(EXEEXT) $(DESTDIR)$(INSTALL_IRC)
	$(INSTALL_DATA) $(top_srcdir)/BitchX.help $(DESTDIR)$(IRCLIB)/$(DEFAULT_BITCHX_HELP_FILE)
	$(INSTALL_DATA) $(top_srcdir)/BitchX.ircnames $(DESTDIR)$(IRCLIB)/$(DEFAULT_BITCHX_IRCNAME_FILE)
	$(INSTALL_DATA) $(top_srcdir)/BitchX.quit $(DESTDIR)$(IRCLIB)/$(DEFAULT_BITCHX_QUIT_FILE)
	$(INSTALL_DATA) $(top_srcdir)/BitchX.reasons $(DESTDIR)$(IRCLIB)/$(DEFAULT_BITCHX_KICK_FILE)
	$(WINNT_INSTALL)

install_local: all local_installdirs installdll_local
	$(INSTALL) source/$(_VERSION_)$(EXEEXT) $(local_dir)/bin/$(VERSION)$(EXEEXT)
	$(INSTALL) $(local_dir)/bin/$(VERSION)$(EXEEXT) $(local_dir)/bin/$(_VERSION_)$(EXEEXT)
	$(INSTALL) source/scr-bx$(EXEEXT) $(local_dir)/bin/scr-bx$(EXEEXT)
	$(INSTALL_DATA) $(top_srcdir)/BitchX.help $(DEFAULT_CTOOLZ_DIR)/$(DEFAULT_BITCHX_HELP_FILE)
	$(INSTALL_DATA) $(top_srcdir)/BitchX.ircnames $(DEFAULT_CTOOLZ_DIR)/$(DEFAULT_BITCHX_IRCNAME_FILE)
	$(INSTALL_DATA) $(top_srcdir)/BitchX.quit $(DEFAULT_CTOOLZ_DIR)/$(DEFAULT_BITCHX_QUIT_FILE)
	$(INSTALL_DATA) $(top_srcdir)/BitchX.reasons $(DEFAULT_CTOOLZ_DIR)/$(DEFAULT_BITCHX_KICK_FILE)

wserv: .config.h $(srcdir)/source/wserv.c $(srcdir)/source/term.c $(srcdir)/Makefile
	cd source \
	  && $(MAKE) wserv

scr-bx: .config.h $(srcdir)/source/scr-bx.c $(srcdir)/source/term.c $(srcdir)/Makefile
	cd source \
	  && $(MAKE) scr-bx

installwserv: installdirs wserv
	$(INSTALL) source/wserv $(DESTDIR)$(INSTALL_WSERV)

installscr-bx: installdirs scr-bx
	$(INSTALL) source/scr-bx $(DESTDIR)$(INSTALL_SCRBX)

installscript: installdirs
	-@( \
		if test -d $(top_srcdir)/script; then \
			for i in $(top_srcdir)/script/*; do \
				$(INSTALL_DATA) "$$i" $(DESTDIR)$(INSTALL_SCRIPT); \
			done; \
			chmod -x $(DESTDIR)$(INSTALL_SCRIPT)/*; \
		fi; \
	)

installtranslation: installdirs
	-@( \
		if test -d $(top_srcdir)/translation; then \
			for i in $(top_srcdir)/translation/*; do \
				$(INSTALL_DATA) "$$i" $(DESTDIR)$(TRANSLATION_PATH); \
			done; \
			chmod -x $(DESTDIR)$(TRANSLATION_PATH)/*; \
		fi; \
	)
	(find $(DESTDIR)$(TRANSLATION_PATH) -type f ! -name '*.bz2' ! -name '*.gz' | \
		(xargs bzip2 -9f || xargs gzip -9f) || :) 2>/dev/null

installman: installdirs
	-@( \
		if test -d $(top_srcdir)/doc; then \
			cd $(top_srcdir)/doc; \
			for i in BitchX.1; do \
			if test -f $$i; then \
				$(INSTALL_DATA) $$i $(DESTDIR)$(mandir)/man1; \
			fi; \
			done; \
		fi; \
	)
	(find $(DESTDIR)$(mandir)/man1/BitchX.1 -type f ! -name '*.bz2' ! -name '*.gz' | \
		(xargs bzip2 -9f || xargs gzip -9f) || :) 2>/dev/null

installdirs:
	umask 022 && $(top_srcdir)/mkinstalldirs $(DESTDIR)$(bindir) $(DESTDIR)$(IRCLIB) \
		$(DESTDIR)$(mandir)/man1 $(DESTDIR)$(TRANSLATION_PATH) $(DESTDIR)$(INSTALL_SCRIPT) \
		$(DESTDIR)$(HELPDIR)

local_installdirs:
	umask 022; $(top_srcdir)/mkinstalldirs $(local_dir)/bin $(DEFAULT_CTOOLZ_DIR) $(DEFAULT_CTOOLZ_DIR)/plugins $(DEFAULT_CTOOLZ_DIR)/logs

config: bxconf

bxconf: $(srcdir)/Makefile $(srcdir)/bx-conf/Makefile.in
	cd bx-conf \
	  && $(MAKE) all
	$(topdir)/bxconfigure || :

clean:
	-@(if test -f source/Makefile; then cd source; $(MAKE) clean; fi)
	-@(if test -f dll/Makefile; then cd dll; $(MAKE) clean; fi)
	-@(if test -f bx-conf/Makefile; then cd bx-conf; $(MAKE) clean; fi)

distclean: clean
	-@(if test -f source/Makefile; then cd source; $(MAKE) distclean; fi)
	-@(if test -f dll/Makefile; then cd dll; $(MAKE) distclean; fi)
	-@(if test -f bx-conf/Makefile; then cd bx-conf; $(MAKE) distclean; fi)
	-$(RM) config.status
	-$(RM) config.cache config.log stamp-h stamp-h[0-9]*
	-$(RM) include/defs.h include/sig.inc
	-$(RM) *~ *.rej core *.orig .#*
	-$(RM) include/*~ include/*.rej include/core include/*.orig include/.#*
	-$(RM) source/*~ source/*.rej source/core source/*.orig source/.#*
	-$(RM) bitchx-docs/.#* bx-conf/.#* contrib/.#* dll/.#* doc/.#*
	-$(RM) script/.#* macros/.#* translation/.#*
	-$(RM) doc/*~ doc/BitchX.bat *.spec
	-$(RM) Makefile
	-$(CP) $(top_srcdir)/doc/Makefile $(top_srcdir)/Makefile
	-$(CP) $(top_srcdir)/doc/Makefile Makefile

export: distclean
	$(top_srcdir)/autogen.sh || :

package: export
	cd ..; tar -cvf $(VERSION).tar $(_VERSION_); gzip $(_VERSION_)
	cd ..; tar --use bzip2 -cvf $(VERSION).tar $(_VERSION_); bzip2 $(_VERSION_)

distrib: export source/$(_VERSION_)$(EXEEXT)
	$(CP) source/$(_VERSION_)$(EXEEXT) $(_VERSION_)$(EXEEXT)
	strip --strip-all $(_VERSION_)$(EXEEXT); gzip $(_VERSION_)$(EXEEXT)
	tar -cvf $(VERSION)-bin.tar dll/*$(SHLIB_SUFFIX) \
		dll/hint/BitchX.hints BitchX.*; gzip $(VERSION)-bin.tar

windistrib: install
	tar -cvf $(VERSION).tar \"($IRCLIB)\"; gzip $(VERSION).tar
	tar --use bzip2 -cvf $(VERSION).tar \"($IRCLIB)\"; bzip2 $(VERSION).tar

dep: depend

depend:
	cd source \
	  && $(MAKE) depend

Makefile: $(srcdir)/Makefile.in $(srcdir)/source/Makefile.in \
		$(srcdir)/dll/Makefile.in config.status
	cd $(topdir) \
	  && $(SHELL) ./config.status

config.status: $(srcdir)/configure
	$(SHELL) ./config.status --recheck
#$(srcdir)/configure: $(srcdir)/configure.in
#	cd $(srcdir) && autoconf || :

$(top_srcdir)/aclocal.m4: 
	cd $(top_srcdir)/macros && ./mkaclocal

include/defs.h: stamp-h
	@if test ! -f $@; then \
		rm -f stamp-h; \
		$(MAKE) stamp-h; \
		else :; fi
stamp-h: $(srcdir)/include/defs.h.in $(topdir)/config.status
	@rm -f stamp-h stamp-hT
	@echo timestamp > stamp-hT 2> /dev/null
	cd $(topdir) \
	  && \
	     $(SHELL) ./config.status
	@mv stamp-hT stamp-h
$(srcdir)/include/defs.h.in: $(srcdir)/./stamp-h.in
	@if test ! -f $@; then \
		rm -f $(srcdir)/./stamp-h.in; \
		$(MAKE) $(srcdir)/./stamp-h.in; \
	else :; fi
$(srcdir)/./stamp-h.in: $(top_srcdir)/configure.in
	@rm -f $(srcdir)/./stamp-h.in $(srcdir)/./stamp-h.inT
	@echo timestamp > $(srcdir)/./stamp-h.inT 2> /dev/null
	cd $(top_srcdir) && autoheader
	@mv $(srcdir)/./stamp-h.inT $(srcdir)/./stamp-h.in

done:
	@echo
	@echo Now type \"$(MAKE_BIN) install\" to install $(_VERSION_) globally \(if you\'re root\), or
	@echo else you can type \"$(MAKE_BIN) install_local\" to install $(_VERSION_) to your home
	@echo directory.

reallydone:
	@echo
	@echo $(_VERSION_) is now installed.
	@echo Type \"$(INSTALL_IRC)\" to start.

.PHONY: clean done reallydone installdirs local_installdirs

# Tell versions [3.59,3.63) of GNU make to not export all variables.
# Otherwise a system limit (for SysV at least) may be exceeded.
.NOEXPORT:
