ifneq ($(MAKECMDGOALS),clean)
ifneq ($(MAKECMDGOALS),config)
ifneq ($(MAKECMDGOALS),distclean)

-include .config
-include .depend

ARCH        := $(patsubst "%",%,$(CONFIG_ARCH))

CC          := $(patsubst "%",%,$(CONFIG_CC))
CPP         := $(CC) -E

CFLAGS      := -pipe -O2 -ffreestanding -Wall -pedantic
CFLAGS      += -fmerge-all-constants -fstrict-overflow
CFLAGS      += -fwhole-program -frename-registers
CFLAGS      += -fno-common -freg-struct-return

ifdef CONFIG_GCC
CFLAGS      += -fshort-enums
endif

CPPFLAGS    := -std=c99 -nostdinc -Iinclude -Iarch/$(ARCH)/include
LDFLAGS     := -nostdlib -static -Wl,-T karyon.ld

-include arch/$(ARCH)/makefile

karyon: .depend karyon.ld
	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) -o $@ $(src-y)

karyon.ld: .config arch/$(ARCH)/karyon.ld.S
	$(CPP) $(CPPFLAGS) -P -D__ASSEMBLY__ -o $@ arch/$(ARCH)/karyon.ld.S

.depend: .config $(src-y)
	$(CPP) $(CPPFLAGS) -M -MT karyon $(src-y) >$@

.config: conf
	KCONFIG_AUTOHEADER="include/config.h" \
	./conf -s Kconfig

endif
endif
endif

HOSTCC      ?= clang

HOSTCFLAGS  ?= -pipe -O2 -w
HOSTLDFLAGS ?= -s

include util/kconfig/makefile

conf: $(src-conf)
	$(HOSTCC) $(HOSTCFLAGS) $(HOSTLDFLAGS) -o $@ $^

mconf: $(src-mconf)
	$(HOSTCC) $(HOSTCFLAGS) $(HOSTLDFLAGS) -o $@ $^ -lcurses

clean:
	rm -f conf mconf karyon

config: mconf
	./mconf Kconfig

distclean: clean
	rm -f .config .config.old .depend include/config.h

.PHONY: clean config distclean
