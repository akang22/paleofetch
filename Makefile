CFLAGS=-std=gnu11 -Wall -ggdb -Wextra -lX11 -lpci
CACHE=$(shell if [ "$$XDG_CACHE_HOME" ]; then echo "$$XDG_CACHE_HOME"; else echo "$$HOME"/.cache; fi)

all: paleofetch

clean:
	rm -f paleofetch $(CACHE)/paleofetch

paleofetch: paleofetch.c paleofetch.h config.h
	$(eval battery_path := $(shell ./config_scripts/battery_config.sh))
	gcc paleofetch.c -g -o paleofetch $(CFLAGS) -D $(battery_path)

install: paleofetch
	mkdir -p $(PREFIX)/bin
	install ./paleofetch /usr/bin/paleofetch
