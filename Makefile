.PHONY: start-kiosk
# Start kiosk device VM
start-kiosk:
	vagrant up

.PHONY: stop-kiosk
# Stop kiosk device VM
stop-kiosk:
	vagrant destroy -f

.PHONY: install-kiosk
# Reinstall kiosk
install-kiosk:
	vagrant provision

.PHONY:
# Reset kiosk device
reset-kiosk:
	$(MAKE) stop-kiosk
	$(MAKE) start-kiosk

.PHONY:
# Start kiosk server
kiosk-server:
	$(MAKE) -C backend run

.PHONY: help
.DEFAULT_GOAL:= help
help:
	@echo Usage:
	@sed  -E '/^#.*/ {N; s/^#\s*(.*)\n(.*):.*$$/make \2: \x1b[37m\1\x1b[0m/};t;d' Makefile

