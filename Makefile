MODULES = iana-dns-parameters dns-zones-state dns-zone-common dns-zone-rpcs
DATE ?= $(shell date +%F)
EXAMPLE_BASE = example
EXAMPLE_TYPE = config
baty = $(EXAMPLE_BASE)-$(EXAMPLE_TYPE)
EXAMPLE_INST = $(baty).xml
PYANG_OPTS =

yams = $(addsuffix .yang, $(MODULES))
xsldir = .tools/xslt
yypars = --stringparam date $(DATE)
expars = --stringparam zone-name "example" --stringparam class IN
dsrl2xslt = $(PYANG_XSLT_DIR)/dsrl2xslt.xsl
schemas = $(baty).rng $(baty).sch $(baty).dsrl
y2dopts = -t $(EXAMPLE_TYPE) -b $(EXAMPLE_BASE)

.PHONY: all clean commit json master rnc validate yang

all: $(yams)

json: $(baty).json

master: example.zone

hello.xml: $(yams) hello-external.ent
	@echo '<hello xmlns="urn:ietf:params:xml:ns:netconf:base:1.0">' > $@
	@echo '<capabilities>' >> $@
	@echo '<capability>urn:ietf:params:netconf:base:1.1</capability>' >> $@
	@for m in $(yams); do \
	  capa=$$(pyang $(PYANG_OPTS) -f capability --capability-entity $$m); \
	  if [ "$$capa" != "" ]; then \
	    echo "<capability>$$capa</capability>" >> $@; \
	  fi \
	done
	@cat hello-external.ent >> $@
	@echo '</capabilities>' >> $@
	@echo '</hello>' >> $@

%.yang: %.yinx
	@xsltproc --xinclude $(xsldir)/canonicalize.xsl $< | \
	  xsltproc --output $@ $(yypars) $(xsldir)/yin2yang.xsl -

$(schemas): hello.xml
	@yang2dsdl $(y2dopts) -L $<

%.rnc: %.rng
	@trang -I rng -O rnc $< $@

rnc: $(baty).rnc

validate: $(EXAMPLE_INST) $(schemas)
	@yang2dsdl -j -s $(y2dopts) -v $<

$(baty).json: model.xsl $(EXAMPLE_INST)
	@xsltproc --output $@ $^

model.xsl: hello.xml
	@pyang -o $@ -f jsonxsl -L $<

model.tree: hello.xml
	@pyang $(PYANG_OPTS) -f tree -o $@ -L $<

defaults.xsl: $(baty).dsrl
	@xsltproc --output $@ $(dsrl2xslt) $<

example.zone: $(EXAMPLE_INST) defaults.xsl xslt/rdata.xsl
	@xsltproc defaults.xsl $< | \
	  xsltproc $(expars) --output $@ xslt/master.xsl -

commit:	model.tree
	@git add model.tree $(yams)
	@git commit

clean:
	@rm -rf *.rng *.rnc *.sch *.dsrl hello.xml model.xsl \
	$(baty).json example.zone defaults.xsl
