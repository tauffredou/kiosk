.PHONY: run
# Start server
run:
	go run cmd/main.go

.PHONY: help
.DEFAULT_GOAL:= help
help:
	@echo Usage:
	@sed  -E '/^#.*/ {N; s/^#\s*(.*)\n(.*):.*$$/make \2: \x1b[37m\1\x1b[0m/};t;d' Makefile
