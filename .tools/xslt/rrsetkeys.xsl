<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:dnsz="http://www.nic.cz/ns/yang/dns-zones"
		version="1.0">

  <xsl:output method="text"/>
  
  <xsl:template match="/">
    <xsl:apply-templates select="//dnsz:rrset"/>
  </xsl:template>

  <xsl:template match="dnsz:rrset">
    <xsl:value-of select="concat(dnsz:owner, ' ',
			  substring-after(dnsz:type, 'ianadns:'), '&#xA;')"/>
  </xsl:template>
</xsl:stylesheet>
