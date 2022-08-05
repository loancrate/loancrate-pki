.PHONY: all webhook

all: webhook tls-bundle.pem

webhook: tls.pem tls-key.pem
	cd webhook && make

tls-bundle.pem: tls.pem ../ca.pem
	mkbundle -f $@ $^

tls.pem tls-key.pem: csr.json ../ca.pem ../ca-key.pem ../../intermediate-ca-config.json
	cfssl gencert -ca ../ca.pem -ca-key ../ca-key.pem -config ../../intermediate-ca-config.json csr.json | cfssljson -bare tls
	touch ../.keys-changed
	openssl x509 -in tls.pem -text -noout
