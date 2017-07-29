.DEFAULT_GOAL := build
CRAMOPTS ?= --shell=/usr/bin/zsh
CRAM_ROOT ?= cram
CRAM_PATH ?= $(CRAM_ROOT)

PREFIX   ?= /usr/local
LIBDIR   ?= $(DESTDIR)$(PREFIX)/lib
BINDIR   ?= $(DESTDIR)$(PREFIX)/bin
MANDIR   ?= $(DESTDIR)$(PREFIX)/man/man1

CHECK_PATH = $(PWD)/$(BROOTDIR)/fakeroot/usr/local/bin:/bin:/usr/bin:/usr/local/bin

BROOTDIR   = _build
BLIBDIR    = $(BROOTDIR)/lib
BBINDIR    = $(BROOTDIR)/bin
BMANDIR    = $(BROOTDIR)/man/man1

DIRS = $(BLIBDIR) $(BBINDIR)

CMDS = $(patsubst src/x-env/%.sh,%,$(wildcard src/x-env/*))
MANS = $(patsubst Documentation/x-env/%.rst,x-env-%.1,$(wildcard Documentation/x-env/*))

BCMDS = $(BBINDIR)/x-env   $(addprefix $(BBINDIR)/x-env-,$(CMDS))
BMANS = $(BMANDIR)/x-env.1 $(addprefix $(BMANDIR)/,$(MANS))

ICMDS = $(BINDIR)/x-env    $(addprefix $(BINDIR)/x-env-,$(CMDS))
IMANS = $(MANDIR)/x-env.1  $(addprefix $(MANDIR)/,$(MANS))

.PHONY: build
build: $(BCMDS) $(BMANS)

$(BBINDIR)/x-env-%: src/x-env/%.sh

	install -m755 -D $< $@

$(BBINDIR)/x-env: src/x-env.sh

	install -m755 -D $< $@

$(BMANDIR):

	install -d $@

$(BMANDIR)/x-env-%.1: Documentation/x-env/%.rst $(BMANDIR)

	rst2man $< $@

$(BMANDIR)/%.1: Documentation/$(subst x-env-,x-env/,%).rst $(BMANDIR)

	rst2man $< $@


.PHONY: install
install: $(ICMDS) $(IMANS)

$(BINDIR)/%: $(BBINDIR)/%

	install -m755 -D $< $@

$(MANDIR)/%: $(BMANDIR)/%

	install -m644 -D $< $@


.PHONY: clean
clean:

	$(RM) -r $(BROOTDIR) $(CRAM_ROOT)/*.t.err


.PHONY: check
check: build

	mkdir -p $(BROOTDIR)/fakeroot
	DESTDIR=$(BROOTDIR)/fakeroot $(MAKE) install
	env -i PATH=$(CHECK_PATH) cram $(CRAMOPTS) $(CRAM_PATH)
