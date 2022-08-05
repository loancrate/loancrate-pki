.PHONY: all development staging production

all: development staging production

development staging production:
	cd $@ && make
