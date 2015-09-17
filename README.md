# zone-data-yang

The aim of this project is to create a YANG data model for DNS zone data
so as to be able to treat them as normal configuration.

[Current data tree](https://gitlab.labs.nic.cz/llhotka/zone-data-yang/raw/master/model.tree)

## Prerequisites

- [pyang](https://github.com/mbj4668/pyang)
- [xsltproc](http://xmlsoft.org/XSLT/xsltproc2.html)
- [jing, trang](https://github.com/relaxng/jing-trang)

## Makefile Targets

Below is a description of interesting Makefile targets. GNU make is
needed.

- **all** (default): generate YANG files from
  [YINX](https://gitlab.labs.nic.cz/labs/yang-tools/wikis/editing_yang#yin-schema-extensions)
  sources;

- **json**: generate example configuration in JSON format;

- **master**: generate master file from example configuration;

- **rnc**: generate RELAX NG schema in compact syntax (in fact, all
  [DSDL](http://dsdl.org) schemas are generated);

- **validate**: validate example configuration against DSDL schemas;

- **model.tree**: generate ascii art depicting the data model schema
  as a tree (run `pyang --tree-help` for an explanation of symbols);

- **clean**: remove all generated files.

## RR Implementation Status

- [x] [RFC 1035](https://tools.ietf.org/html/rfc1035): A, CNAME, HINFO
  MB, MG, MINFO, MR MX, NS, NULL, PTR, SOA, TXT, WKS
- [ ] [RFC 1183](https://tools.ietf.org/html/rfc1183): AFSDB, ISDN, RP, RT, X25
- [ ] [RFC 1706](https://tools.ietf.org/html/rfc1706): NSAP
- [ ] [RFC 1712](https://tools.ietf.org/html/rfc1712): GPOS
- [ ] [RFC 1876](https://tools.ietf.org/html/rfc1876): LOC
- [ ] [RFC 2163](https://tools.ietf.org/html/rfc2163): PX
- [ ] [RFC 2230](https://tools.ietf.org/html/rfc2230): KX
- [ ] [RFC 2538](https://tools.ietf.org/html/rfc2538): CERT
- [x] [RFC 2672](https://tools.ietf.org/html/rfc2672): DNAME
- [ ] [RFC 2782](https://tools.ietf.org/html/rfc2782): SRV
- [ ] [RFC 2845](https://tools.ietf.org/html/rfc2845): TSIG
- [ ] [RFC 2874](https://tools.ietf.org/html/rfc2874): A6
- [ ] [RFC 2930](https://tools.ietf.org/html/rfc2930): TKEY
- [ ] [RFC 2931](https://tools.ietf.org/html/rfc2931): SIG
- [ ] [RFC 3123](https://tools.ietf.org/html/rfc3123): APL
- [ ] [RFC 3445](https://tools.ietf.org/html/rfc3445): KEY
- [ ] [RFC 3403](https://tools.ietf.org/html/rfc3403): NAPTR
- [x] [RFC 3596](https://tools.ietf.org/html/rfc3596): AAAA
- [x] [RFC 4025](https://tools.ietf.org/html/rfc4025): IPSECKEY
- [x] [RFC 4034](https://tools.ietf.org/html/rfc4034): DNSKEY, DS, NSEC, RRSIG
- [x] [RFC 4255](https://tools.ietf.org/html/rfc4255): SSHFP
- [ ] [RFC 4408](https://tools.ietf.org/html/rfc4408): SPF
- [ ] [RFC 4431](https://tools.ietf.org/html/rfc4431): DLV
- [ ] [RFC 4701](https://tools.ietf.org/html/rfc4701): DHCID
- [x] [RFC 5155](https://tools.ietf.org/html/rfc5155): NSEC3, NSEC3PARAM
- [x] [RFC 6698](https://tools.ietf.org/html/rfc6698): TLSA

## Additional Information

[Project wiki](https://gitlab.labs.nic.cz/llhotka/zone-data-yang/wikis/home)

