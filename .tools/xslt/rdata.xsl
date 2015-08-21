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
    <xsl:apply-templates select="yin:container"/>
    <xsl:text>&#xA;</xsl:text>
  </xsl:template>

  <xsl:template match="yin:container">
    <xsl:value-of select="concat(@name, '&#x9;')"/>
    <xsl:apply-templates select="yin:leaf|yin:uses|yin:leaf-list"/>
  </xsl:template>
  
  <xsl:template match="yin:leaf|yin:leaf-list">
    <xsl:value-of select="@name"/>
    <xsl:if test="position() != last()">
      <xsl:text> </xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="yin:uses">
    <xsl:apply-templates select="//yin:grouping[@name=current()/@name]"/>
    <xsl:if test="position() != last()">
      <xsl:text> </xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="yin:grouping">
    <xsl:apply-templates select="yin:leaf|yin:uses|yin:leaf-list"/>
  </xsl:template>
  
</xsl:stylesheet>
