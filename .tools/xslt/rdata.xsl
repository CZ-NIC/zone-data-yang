<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:yin="urn:ietf:params:xml:ns:yang:yin:1"
		version="1.0">

  <xsl:output method="text"/>
  
  <xsl:template match="yin:module">
    <xsl:value-of select="concat('# ', @name, '&#xA;&#xA;')"/>
    <xsl:apply-templates select=".//yin:augment"/>
  </xsl:template>

  <xsl:template match="yin:augment">
    <xsl:apply-templates select="yin:when"/>
    <xsl:apply-templates select="yin:container/yin:leaf"/>
    <xsl:text>&#xA;</xsl:text>
  </xsl:template>

  <xsl:template match="yin:when">
    <xsl:value-of
	select='concat(substring-before(substring-after(@condition, ":"), "&apos;"), "&#x9;")'/>
  </xsl:template>

  <xsl:template match="yin:leaf">
    <xsl:value-of select="@name"/>
    <xsl:if test="position() != last()">
      <xsl:text> </xsl:text>
    </xsl:if>
  </xsl:template>
  
</xsl:stylesheet>
