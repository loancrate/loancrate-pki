.PHONY: all dump renew

all: api-client.pem api-client-key.pem

api-client.pem api-client-key.pem: csr.json ../tls.pem ../tls-key.pem
	cfssl gencert -ca ../tls.pem -ca-key ../tls-key.pem csr.json | cfssljson -bare api-client
	touch ../../.keys-changed
	openssl x509 -in api-client.pem -text -noout

dump: api-client.pem
	openssl x509 -in $< -text -noout

renew: api-client.csr ../tls.pem ../tls-key.pem
	cfssl sign -ca ../tls.pem -ca-key ../tls-key.pem api-client.csr | cfssljson -bare api-client
	openssl x509 -in api-client.pem -text -noout
