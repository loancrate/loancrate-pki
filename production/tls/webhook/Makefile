.PHONY: all dump renew

all: webhook.pem webhook-key.pem

webhook.pem webhook-key.pem: csr.json ../tls.pem ../tls-key.pem
	cfssl gencert -ca ../tls.pem -ca-key ../tls-key.pem csr.json | cfssljson -bare webhook
	touch ../../.keys-changed
	openssl x509 -in webhook.pem -text -noout

dump: webhook.pem
	openssl x509 -in $< -text -noout

renew: webhook.csr ../tls.pem ../tls-key.pem
	cfssl sign -ca ../tls.pem -ca-key ../tls-key.pem webhook.csr | cfssljson -bare webhook
	openssl x509 -in webhook.pem -text -noout
