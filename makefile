.PHONY: all clean config menuconfig silentconfig
.POSIX:
.SILENT:

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
	printf "\033[k\033[0;33mCleaning up…\033[m\r"; \
	if rm -f -- conf mconf stageone stagetwo karyon; \
	then \
		printf "\033[k\033[0;34mSuccessfully cleaned up.\033[m\n"; \
	else \
		printf "\033[k\033[0;31mFailed to clean up!\033[m\n"; \
		exit 1; \
	fi

config: conf
	./$< Kconfig

silentconfig: conf
	./$< -s Kconfig

menuconfig: mconf
	./$< Kconfig

conf: $(conf-src)
	printf "\033[k\033[0;33mCompiling \033[1;33m$@\033[0;33m…\033[m\r"; \
	if $(HOSTCC) $(HOSTCFLAGS) -o $@ $(conf-src); \
	then \
		printf "\033[k\033[0;32mSuccessfully compiled \033[1;32m$@\033[0;32m.\033[m\n"; \
	else \
		printf "\033[k\033[0;31mFailed to compile \033[1;31m$@\033[0;31m!\033[m\n"; \
		exit 1; \
	fi

mconf: $(mconf-src)
	printf "\033[k\033[0;33mCompiling \033[1;33m$@\033[0;33m…\033[m\r"; \
	if $(HOSTCC) $(HOSTCFLAGS) -o $@ $(mconf-src) -lcurses; \
	then \
		printf "\033[k\033[0;32mSuccessfully compiled \033[1;32m$@\033[0;32m.\033[m\n"; \
	else \
		printf "\033[k\033[0;31mFailed to compile \033[1;31m$@\033[0;31m!\033[m\n"; \
		exit 1; \
	fi

.config: silentconfig

stageone: .config rules makefile
	printf "\033[k\033[0;33mGenerating dependency stage one…\033[m\r"; \
	if \
		cat .config rules makefile >$@; \
	then \
		printf "\033[k\033[0;36mSuccessfully generated dependency stage one.\033[m\n"; \
	else \
		printf "\033[k\033[0;31mFailed to generate dependency stage one!\033[m\n"; \
		exit 1; \
	fi

stagetwo: .config rules makefile $(src-y)
	printf "\033[k\033[0;33mGenerating dependency stage two…\033[m\r"; \
	if \
		cat .config rules makefile >$@ && \
		$(CPP) $(CPPFLAGS) -M -MT karyon $(src-y) >>$@; \
	then \
		printf "\033[k\033[0;36mSuccessfully generated dependency stage two.\033[m\n"; \
	else \
		printf "\033[k\033[0;31mFailed to generate dependency stage two!\033[m\n"; \
		exit 1; \
	fi

karyon:
	printf "\033[k\033[0;33mCompiling \033[1;33m$@\033[0;33m…\033[m\r"; \
	if $(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) -o $@ $(src-y); \
	then \
		printf "\033[k\033[0;32mSuccessfully compiled \033[1;32m$@\033[0;32m.\033[m\n"; \
	else \
		printf "\033[k\033[0;31mFailed to compile \033[1;31m$@\033[0;31m!\033[m\n"; \
		exit 1; \
	fi
