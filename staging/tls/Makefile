CERTIFICATES := api-client webhook

RENEW_TARGETS := $(addprefix renew-,$(CERTIFICATES))

.PHONY: all $(CERTIFICATES) $(RENEW_TARGETS)

all: $(CERTIFICATES) tls-bundle.pem

$(CERTIFICATES): tls.pem tls-key.pem
	cd $@ && $(MAKE)

$(RENEW_TARGETS): renew-%: tls.pem tls-key.pem
	cd $* && $(MAKE) renew

tls-bundle.pem: tls.pem ../ca.pem
	mkbundle -f $@ $^

tls.pem tls-key.pem: csr.json ../ca.pem ../ca-key.pem ../../intermediate-ca-config.json
	cfssl gencert -ca ../ca.pem -ca-key ../ca-key.pem -config ../../intermediate-ca-config.json csr.json | cfssljson -bare tls
	touch ../.keys-changed
	openssl x509 -in tls.pem -text -noout
