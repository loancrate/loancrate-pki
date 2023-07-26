ENVIRONMENTS := development staging production
CERTIFICATES := api-client webhook

RENEW_TARGETS := $(addprefix renew-,$(CERTIFICATES))

.PHONY: all $(ENVIRONMENTS) $(RENEW_TARGETS) expiration

all: $(ENVIRONMENTS)

$(ENVIRONMENTS):
	cd $@ && $(MAKE)

$(RENEW_TARGETS): renew-%:
	cd development && $(MAKE) $@
	cd staging && $(MAKE) $@
	cd production && $(MAKE) $@

expiration:
	find . -name '*-key.pem' -prune -o -name '*.pem' -exec echo -n '{}: ' \; -exec openssl x509 -in '{}' -enddate -noout \; | sort
