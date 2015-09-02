<?xml version="1.0"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:h="http://www.w3.org/1999/xhtml"
    xmlns:dnsz="http://www.nic.cz/ns/yang/dns-zones"
    xmlns="urn:ietf:params:xml:ns:yang:yin:1"
    version="1.0">
  <xsl:output method="text" encoding="utf-8"/>
  <xsl:strip-space elements="*"/>
  <xsl:template match="dnsz:A">
    <xsl:call-template name="inline-entry">
      <xsl:with-param name="data" select="dnsz:address"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:CNAME">
    <xsl:call-template name="inline-entry">
      <xsl:with-param name="data">
        <xsl:call-template name="process-dname">
          <xsl:with-param name="dn" select="dnsz:cname"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:HINFO">
    <xsl:call-template name="inline-entry">
      <xsl:with-param name="quoted" select="true()"/>
      <xsl:with-param name="data" select="dnsz:cpu"/>
    </xsl:call-template>
    <xsl:call-template name="inline-entry">
      <xsl:with-param name="quoted" select="true()"/>
      <xsl:with-param name="data" select="dnsz:os"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:MB">
    <xsl:call-template name="inline-entry">
      <xsl:with-param name="data">
        <xsl:call-template name="process-dname">
          <xsl:with-param name="dn" select="dnsz:madname"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:MD">
    <xsl:call-template name="inline-entry">
      <xsl:with-param name="data">
        <xsl:call-template name="process-dname">
          <xsl:with-param name="dn" select="dnsz:madname"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:MF">
    <xsl:call-template name="inline-entry">
      <xsl:with-param name="data">
        <xsl:call-template name="process-dname">
          <xsl:with-param name="dn" select="dnsz:madname"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:MG">
    <xsl:call-template name="inline-entry">
      <xsl:with-param name="data">
        <xsl:call-template name="process-dname">
          <xsl:with-param name="dn" select="dnsz:mgmname"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:MINFO">
    <xsl:call-template name="inline-entry">
      <xsl:with-param name="data">
        <xsl:call-template name="process-dname">
          <xsl:with-param name="dn" select="dnsz:rmailbx"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="inline-entry">
      <xsl:with-param name="data">
        <xsl:call-template name="process-dname">
          <xsl:with-param name="dn" select="dnsz:emailbx"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:MR">
    <xsl:call-template name="inline-entry">
      <xsl:with-param name="data">
        <xsl:call-template name="process-dname">
          <xsl:with-param name="dn" select="dnsz:newname"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:MX">
    <xsl:call-template name="inline-entry">
      <xsl:with-param name="data" select="dnsz:preference"/>
    </xsl:call-template>
    <xsl:call-template name="inline-entry">
      <xsl:with-param name="data">
        <xsl:call-template name="process-dname">
          <xsl:with-param name="dn" select="dnsz:exchange"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:NS">
    <xsl:call-template name="inline-entry">
      <xsl:with-param name="data">
        <xsl:call-template name="process-dname">
          <xsl:with-param name="dn" select="dnsz:nsdname"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:NULL">
    <xsl:call-template name="inline-entry">
      <xsl:with-param name="data" select="dnsz:data"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:PTR">
    <xsl:call-template name="inline-entry">
      <xsl:with-param name="data">
        <xsl:call-template name="process-dname">
          <xsl:with-param name="dn" select="dnsz:ptrdname"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:TXT">
    <xsl:call-template name="inline-entry">
      <xsl:with-param name="quoted" select="true()"/>
      <xsl:with-param name="data" select="dnsz:txt-data"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:WKS">
    <xsl:call-template name="inline-entry">
      <xsl:with-param name="data" select="dnsz:address"/>
    </xsl:call-template>
    <xsl:call-template name="inline-entry">
      <xsl:with-param name="data" select="dnsz:protocol"/>
    </xsl:call-template>
    <xsl:call-template name="inline-entry">
      <xsl:with-param name="data" select="dnsz:bitmap"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:AAAA">
    <xsl:call-template name="inline-entry">
      <xsl:with-param name="data" select="dnsz:address"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:DNSKEY">
    <xsl:call-template name="open-block"/>
    <xsl:call-template name="inline-entry">
      <xsl:with-param name="data" select="dnsz:flags"/>
    </xsl:call-template>
    <xsl:call-template name="inline-entry">
      <xsl:with-param name="data" select="dnsz:protocol"/>
    </xsl:call-template>
    <xsl:call-template name="inline-entry">
      <xsl:with-param name="data">
        <xsl:call-template name="dnssec-algorithm">
          <xsl:with-param name="enum" select="dnsz:algorithm"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="chop-text">
      <xsl:with-param name="data" select="dnsz:public-key"/>
    </xsl:call-template>
    <xsl:call-template name="close-block"/>
  </xsl:template>
  <xsl:template match="dnsz:RRSIG">
    <xsl:call-template name="inline-entry">
      <xsl:with-param name="data">
        <xsl:call-template name="data-rrtype">
          <xsl:with-param name="identity" select="dnsz:type-covered"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="inline-entry">
      <xsl:with-param name="data">
        <xsl:call-template name="dnssec-algorithm">
          <xsl:with-param name="enum" select="dnsz:algorithm"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="inline-entry">
      <xsl:with-param name="data" select="dnsz:labels"/>
    </xsl:call-template>
    <xsl:call-template name="inline-entry">
      <xsl:with-param name="data" select="dnsz:original-ttl"/>
    </xsl:call-template>
    <xsl:call-template name="inline-entry">
      <xsl:with-param name="data">
        <xsl:call-template name="utc-date-time">
          <xsl:with-param name="iso" select="dnsz:signature-expiration"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="sep-line-entry">
      <xsl:with-param name="data">
        <xsl:call-template name="utc-date-time">
          <xsl:with-param name="iso" select="dnsz:signature-inception"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="inline-entry">
      <xsl:with-param name="data">
        <xsl:call-template name="process-dname">
          <xsl:with-param name="dn" select="dnsz:signer-name"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="inline-entry">
      <xsl:with-param name="data" select="dnsz:signature"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:NSEC">
    <xsl:call-template name="inline-entry">
      <xsl:with-param name="data">
        <xsl:call-template name="process-dname">
          <xsl:with-param name="dn" select="dnsz:next-domain-name"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:DS">
    <xsl:call-template name="inline-entry">
      <xsl:with-param name="data">
        <xsl:call-template name="dnssec-algorithm">
          <xsl:with-param name="enum" select="dnsz:algorithm"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="inline-entry">
      <xsl:with-param name="data">
        <xsl:call-template name="digest-algorithm">
          <xsl:with-param name="enum" select="dnsz:digest-type"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="inline-entry">
      <xsl:with-param name="data" select="dnsz:digest"/>
    </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>
