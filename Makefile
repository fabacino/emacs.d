.PHONY: update

update:
	git pull && git submodule update --init --recursive
