<?xml version="1.0"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:h="http://www.w3.org/1999/xhtml"
    xmlns:dnsz="http://www.nic.cz/ns/yang/dns-zones"
    xmlns="urn:ietf:params:xml:ns:yang:yin:1"
    version="1.0">
  <xsl:output method="xml" encoding="utf-8"/>
  <xsl:strip-space elements="*"/>
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
      <xsl:with-param name="data" select="dnsz:madname"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:MD">
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data" select="dnsz:madname"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:MF">
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data" select="dnsz:madname"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:MG">
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data" select="dnsz:mgmname"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:MINFO">
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data" select="dnsz:rmailbx"/>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data" select="dnsz:emailbx"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:MR">
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data" select="dnsz:newname"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:MX">
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data" select="dnsz:preference"/>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data" select="dnsz:exchange"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:NS">
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data" select="dnsz:nsdname"/>
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
      <xsl:with-param name="data" select="dnsz:ptrdname"/>
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
      <xsl:with-param name="data" select="dnsz:algorithm"/>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data" select="dnsz:public-key"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:RRSIG">
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data" select="dnsz:type-covered"/>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data" select="dnsz:algorithm"/>
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
      <xsl:with-param name="data" select="dnsz:signature-expiration"/>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data" select="dnsz:signature-inception"/>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data" select="dnsz:signer-name"/>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data" select="dnsz:signature"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:NSEC">
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data" select="dnsz:next-domain-name"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template match="dnsz:DS">
    <xsl:text> </xsl:text>
    <xsl:call-template name="rdata-field">
      <xsl:with-param name="data" select="dnsz:algorithm"/>
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
