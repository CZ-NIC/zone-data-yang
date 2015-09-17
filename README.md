# Zone-data-yang

The aim of this project is to create a YANG data model for DNS zone data
so as to be able to treat them as normal configuration.

[Current data tree](https://gitlab.labs.nic.cz/llhotka/zone-data-yang/raw/master/model.tree)

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
- [x] [RFC 7208](https://tools.ietf.org/html/rfc7208): SPF
- [ ] [RFC 4431](https://tools.ietf.org/html/rfc4431): DLV
- [ ] [RFC 4701](https://tools.ietf.org/html/rfc4701): DHCID
- [x] [RFC 5155](https://tools.ietf.org/html/rfc5155): NSEC3, NSEC3PARAM
- [x] [RFC 6698](https://tools.ietf.org/html/rfc6698): TLSA

