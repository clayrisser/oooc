CWD := $(shell pwd)
TMPDIR := $(shell mktemp -d)

.PHONY: all
all:
	@echo

.PHONY: start
start:
	@echo "hello: world" | sh src/run.sh

.PHONY: sudo
sudo:
	@if [ $(shell id -u) -ne 0 ]; then echo "please run as root" 1>&2 && false; fi

.PHONY: install
install: jq yq /usr/lib/oooc /usr/bin/oooc

.PHONY: uninstall
uninstall: sudo
	-@rm -rf /usr/oooc /usr/bin/oooc 2>/dev/null || true

/usr/lib/oooc: sudo
	@mkdir -p /usr/lib/oooc
	@cp src/sanitize.pl src/run.sh /usr/lib/oooc

/usr/bin/oooc: sudo
	@cp src/oooc.sh /usr/bin/oooc
	@chmod +x /usr/bin/oooc

.PHONY: jq
jq: sudo
ifneq ($(shell which jq >/dev/null && echo $$?), 0)
ifeq ($(shell which apt-get >/dev/null && echo $$?), 0)
	@sudo apt-get install -y jq
endif
endif

.PHONY: yq
yq: sudo
ifneq ($(shell which yq >/dev/null && echo $$?), 0)
	@pip install yq
endif
