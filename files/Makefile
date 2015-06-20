# Makefile for /etc/postfix
PATH=/usr/sbin:/usr/bin:/bin

TARGETS := \
	aliases.db \
	.build.mark

all: $(TARGETS)
	postfix reload

.build.mark: main.cf master.cf
	touch .build.mark

aliases.db: aliases
	postalias aliases

%.db: %
	postmap $<

