<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:iana="http://www.iana.org/assignments"
		xmlns:h="http://www.w3.org/1999/xhtml"
		version="1.0">

  <xsl:output method="xml"/>
  <xsl:template match="/">
    <xsl:element name="registry">
      <xsl:apply-templates select="//iana:registry[@id='dns-parameters-4']"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="iana:registry">
    <xsl:apply-templates select="iana:record"/>
  </xsl:template>

  <xsl:template match="iana:record">
    <xsl:element name="identity">
      <xsl:attribute name="name">
	<xsl:value-of select="iana:type"/>
      </xsl:attribute>
      <xsl:element name="base">
	<xsl:attribute name="name">
	  <xsl:choose>
	    <xsl:when test="iana:value &gt; 127 and iana:value &lt; 256">
	      <xsl:text>ianadns:q-meta-rrtype</xsl:text>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:text>ianadns:data-rrtype</xsl:text>
	    </xsl:otherwise>
	  </xsl:choose>
	</xsl:attribute>
      </xsl:element>
      <xsl:element name="description">
	<xsl:element name="text">
	  <xsl:element name="h:p">
	    <xsl:value-of select="iana:description"/>
	  </xsl:element>
	  <xsl:element name="h:p">
	    <xsl:value-of select="concat('Value of this RR is ', iana:value, '.')"/>
	  </xsl:element>
	</xsl:element>
      </xsl:element>
      <xsl:if test="iana:xref[@type='rfc']">
	<xsl:element name="reference">
	  <xsl:element name="text">
	    <xsl:for-each select="iana:xref[@type='rfc']">
	      <xsl:value-of select="concat('RFC ', substring(@data,4))"/>
	      <xsl:if test="position() != last()">, </xsl:if>
	    </xsl:for-each>
	  </xsl:element>
	</xsl:element>
      </xsl:if>
    </xsl:element>
  </xsl:template>

  <xsl:template match="iana:description">
  </xsl:template>
  
</xsl:stylesheet>
