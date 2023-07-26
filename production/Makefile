CERTIFICATES := api-client webhook

RENEW_TARGETS := $(addprefix renew-,$(CERTIFICATES))

.PHONY: all tls $(RENEW_TARGETS)

ENVIRONMENT := $(notdir $(shell pwd))
KEY_ARCHIVE := ../$(ENVIRONMENT)-keys.tgz

all: tls $(KEY_ARCHIVE)

tls: ca.pem ca-key.pem
	cd tls && $(MAKE)

$(RENEW_TARGETS): renew-%:
	cd tls && $(MAKE) $@

ca.pem ca-key.pem: csr.json
	cfssl genkey -initca csr.json | cfssljson -bare ca
	touch .keys-changed
	openssl x509 -in ca.pem -text -noout

.keys-changed:
	touch $@

$(KEY_ARCHIVE): .keys-changed
	cd .. && tar -zcvf $(notdir $@) $$(find $(ENVIRONMENT) -name '*-key.pem')
