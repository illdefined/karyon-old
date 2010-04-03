.PHONY: all clean config menuconfig silentconfig
.POSIX:

CC         = clang
CPP        = $(CC) -E

CFLAGS     = -std=c99 -O3 -ffreestanding -Wall -pedantic
CPPFLAGS   = -nostdinc -Iinclude
LDFLAGS    = -nostdlib

HOSTCC     = clang
HOSTCFLAGS = -O3

conf-src   = util/kconfig/conf.c \
             util/kconfig/zconf.tab.c

mconf-src  = util/kconfig/mconf.c \
             util/kconfig/zconf.tab.c \
             util/kconfig/lxdialog/checklist.c \
             util/kconfig/lxdialog/menubox.c \
             util/kconfig/lxdialog/util.c \
             util/kconfig/lxdialog/inputbox.c \
             util/kconfig/lxdialog/textbox.c \
             util/kconfig/lxdialog/yesno.c

all: stageone
	$(MAKE) -f stageone stagetwo
	$(MAKE) -f stagetwo karyon

clean:
	rm -f -- conf mconf stageone stagetwo karyon

config: conf
	./$< Kconfig

silentconfig: conf
	./$< -s Kconfig

menuconfig: mconf
	./$< Kconfig

conf: $(conf-src)
	$(HOSTCC) $(HOSTCFLAGS) -o $@ $(conf-src)

mconf: $(mconf-src)
	$(HOSTCC) $(HOSTCFLAGS) -o $@ $(mconf-src) -lcurses

.config: silentconfig

stageone: .config rules makefile
	cat .config rules makefile >$@

stagetwo: .config rules makefile $(src-y)
	cat .config rules makefile >$@
	$(CPP) $(CPPFLAGS) -M -MT karyon $(src-y) >>$@

karyon:
	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) -o $@ $(src-y)
