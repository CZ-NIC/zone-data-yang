<?xml version="1.0"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:h="http://www.w3.org/1999/xhtml"
    xmlns:dnsz="http://www.nic.cz/ns/yang/dns-zones"
    xmlns="urn:ietf:params:xml:ns:yang:yin:1"
    version="1.0">
  <xsl:output method="xml" encoding="utf-8"/>
  <xsl:strip-space elements="*"/>

  <!-- Named templates -->

  <xsl:template name="dnssec-algorithm">
    <xsl:param name="enum"/>
    <xsl:choose>
      <xsl:when test="$enum = 'RSAMD5'">1</xsl:when>
      <xsl:when test="$enum = 'DH'">2</xsl:when>
      <xsl:when test="$enum = 'DSA'">3</xsl:when>
      <xsl:when test="$enum = 'RSASHA1'">5</xsl:when>
      <xsl:when test="$enum = 'DSA-NSEC3-SHA1'">6</xsl:when>
      <xsl:when test="$enum = 'RSASHA1-NSEC3-SHA1'">7</xsl:when>
      <xsl:when test="$enum = 'RSASHA256'">8</xsl:when>
      <xsl:when test="$enum = 'RSASHA512'">10</xsl:when>
      <xsl:when test="$enum = 'ECC-GOST'">12</xsl:when>
      <xsl:when test="$enum = 'ECDSAP256SHA256'">13</xsl:when>
      <xsl:when test="$enum = 'ECDSAP384SHA384'">14</xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="digest-algorithm">
    <xsl:param name="enum"/>
    <xsl:choose>
      <xsl:when test="$enum = 'SHA-1'">1</xsl:when>
      <xsl:when test="$enum = 'SHA-256'">2</xsl:when>
      <xsl:when test="$enum = 'GOST-R-34.11-94'">3</xsl:when>
      <xsl:when test="$enum = 'SHA-384'">4</xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="data-rrtype">
    <xsl:param name="identity"/>
    <xsl:value-of select="substring-after($identity, 'ianadns:')"/>
  </xsl:template>

  <xsl:template name="utc-date-time">
    <xsl:param name="iso"/>
    <xsl:variable name="time" select="substring($iso, 12)"/>
    <xsl:variable name="len" select="string-length($iso)"/>
    <xsl:variable name="zero" select="substring($iso, $len , 1) = 'Z'"/>
    <xsl:value-of select="substring($iso,1,4)"/>
    <xsl:value-of select="substring($iso,6,2)"/>
    <xsl:value-of select="substring($iso,9,2)"/>
    <xsl:value-of select="substring($iso,12,2)"/>
    <xsl:value-of select="substring($iso,15,2)"/>
    <xsl:value-of select="format-number(substring-before(
			  substring($iso,18), 'Z'), '00')"/>
  </xsl:template>

  <!-- Matching templates -->

  <xsl:template match="dnsz:A">
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data" select="dnsz:address"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:CNAME">
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data">
        <xsl:call-template name="process-dname">
          <xsl:with-param name="dn" select="dnsz:cname"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:HINFO">
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="quoted" select="true()"/>
      <xsl:with-param name="data" select="dnsz:cpu"/>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="quoted" select="true()"/>
      <xsl:with-param name="data" select="dnsz:os"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:MB">
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data">
        <xsl:call-template name="process-dname">
          <xsl:with-param name="dn" select="dnsz:madname"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:MD">
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data">
        <xsl:call-template name="process-dname">
          <xsl:with-param name="dn" select="dnsz:madname"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:MF">
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data">
        <xsl:call-template name="process-dname">
          <xsl:with-param name="dn" select="dnsz:madname"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:MG">
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data">
        <xsl:call-template name="process-dname">
          <xsl:with-param name="dn" select="dnsz:mgmname"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:MINFO">
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data">
        <xsl:call-template name="process-dname">
          <xsl:with-param name="dn" select="dnsz:rmailbx"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data">
        <xsl:call-template name="process-dname">
          <xsl:with-param name="dn" select="dnsz:emailbx"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:MR">
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data">
        <xsl:call-template name="process-dname">
          <xsl:with-param name="dn" select="dnsz:newname"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:MX">
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data" select="dnsz:preference"/>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data">
        <xsl:call-template name="process-dname">
          <xsl:with-param name="dn" select="dnsz:exchange"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:NS">
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data">
        <xsl:call-template name="process-dname">
          <xsl:with-param name="dn" select="dnsz:nsdname"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:NULL">
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data" select="dnsz:data"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:PTR">
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data">
        <xsl:call-template name="process-dname">
          <xsl:with-param name="dn" select="dnsz:ptrdname"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:TXT">
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data" select="dnsz:txt-data"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:WKS">
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data" select="dnsz:address"/>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data" select="dnsz:protocol"/>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data" select="dnsz:bitmap"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:AAAA">
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data" select="dnsz:address"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:DNSKEY">
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data" select="dnsz:flags"/>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data" select="dnsz:protocol"/>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data">
        <xsl:call-template name="dnssec-algorithm">
          <xsl:with-param name="enum" select="dnsz:algorithm"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data" select="dnsz:public-key"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:RRSIG">
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data">
        <xsl:call-template name="data-rrtype">
          <xsl:with-param name="identity" select="dnsz:type-covered"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data">
        <xsl:call-template name="dnssec-algorithm">
          <xsl:with-param name="enum" select="dnsz:algorithm"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data" select="dnsz:labels"/>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data" select="dnsz:original-ttl"/>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data">
        <xsl:call-template name="utc-date-time">
          <xsl:with-param name="iso" select="dnsz:signature-expiration"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data">
        <xsl:call-template name="utc-date-time">
          <xsl:with-param name="iso" select="dnsz:signature-inception"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data">
        <xsl:call-template name="process-dname">
          <xsl:with-param name="dn" select="dnsz:signer-name"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data" select="dnsz:signature"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:NSEC">
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data">
        <xsl:call-template name="process-dname">
          <xsl:with-param name="dn" select="dnsz:next-domain-name"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:DS">
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data">
        <xsl:call-template name="dnssec-algorithm">
          <xsl:with-param name="enum" select="dnsz:algorithm"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data" select="dnsz:digest-type"/>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data" select="dnsz:digest"/>
    </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>
