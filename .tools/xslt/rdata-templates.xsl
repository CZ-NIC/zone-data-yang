<?xml version="1.0" encoding="utf-8"?>

<!-- Program name: rdata-templates.xsl

Copyright © 2015 by Ladislav Lhotka, CZ.NIC <lhotka@nic.cz>

Generates XSLT templates from a YIN module (to be included in master.xsl).

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
-->

<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:yin="urn:ietf:params:xml:ns:yang:yin:1"
    version="1.0">

  <xsl:output method="xml"/>

  <!-- Named templates -->

  <xsl:template name="call-templ">
    <xsl:param name="tname"/>
    <xsl:param name="pname"/>
    <xsl:param name="qname"/>
    <xsl:element name="xsl:call-template">
      <xsl:attribute name="name">
	<xsl:value-of select="$tname"/>
      </xsl:attribute>
      <xsl:element name="xsl:with-param">
	<xsl:attribute name="name">
	  <xsl:value-of select="$pname"/>
	</xsl:attribute>
	<xsl:attribute name="select">
	  <xsl:value-of select="$qname"/>
	</xsl:attribute>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <!-- Matching templates -->

  <xsl:template match="yin:module">
    <xsl:element name="xsl:stylesheet">
      <xsl:copy-of select="namespace::*"/>
      <xsl:attribute name="version">1.0</xsl:attribute>
      <xsl:element name="xsl:output">
	<xsl:attribute name="method">text</xsl:attribute>
	<xsl:attribute name="encoding">utf-8</xsl:attribute>
      </xsl:element>
      <xsl:element name="xsl:strip-space">
	<xsl:attribute name="elements">*</xsl:attribute>
      </xsl:element>
      <xsl:apply-templates
	  select="descendant::yin:choice[@name='rdata-content']"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="yin:choice">
    <xsl:apply-templates select="yin:container"/>
  </xsl:template>

  <xsl:template match="yin:container">
    <xsl:element name="xsl:template">
      <xsl:attribute name="match">
	<xsl:value-of select="concat('dnsz:', @name)"/>
      </xsl:attribute>
      <xsl:apply-templates select="yin:leaf"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="yin:leaf">
    <xsl:element name="xsl:text">
      <xsl:text> </xsl:text>
    </xsl:element>
    <xsl:element name="xsl:call-template">
      <xsl:attribute name="name">rdata-field</xsl:attribute>
      <xsl:if test="yin:type/@name = 'ascii-string'">
	<xsl:element name="xsl:with-param">
	  <xsl:attribute name="name">quoted</xsl:attribute>
	  <xsl:attribute name="select">true()</xsl:attribute>
	</xsl:element>
      </xsl:if>
      <xsl:element name="xsl:with-param">
	<xsl:variable name="qn" select="concat('dnsz:', @name)"/>
	<xsl:attribute name="name">data</xsl:attribute>
	<xsl:choose>
	  <xsl:when test="yin:type/@name = 'domain-name'">
	    <xsl:call-template name="call-templ">
	      <xsl:with-param name="tname">process-dname</xsl:with-param>
	      <xsl:with-param name="pname">dn</xsl:with-param>
	      <xsl:with-param name="qname" select="$qn"/>
	    </xsl:call-template>
	  </xsl:when>
	  <xsl:when test="yin:type/@name = 'utc-date-time'">
	    <xsl:call-template name="call-templ">
	      <xsl:with-param name="tname">utc-date-time</xsl:with-param>
	      <xsl:with-param name="pname">iso</xsl:with-param>
	      <xsl:with-param name="qname" select="$qn"/>
	    </xsl:call-template>
	  </xsl:when>
	  <xsl:when test="yin:type/@name = 'ianadns:dnssec-algorithm'">
	    <xsl:call-template name="call-templ">
	      <xsl:with-param name="tname">dnssec-algorithm</xsl:with-param>
	      <xsl:with-param name="pname">enum</xsl:with-param>
	      <xsl:with-param name="qname" select="$qn"/>
	    </xsl:call-template>
	  </xsl:when>
	  <xsl:when test="yin:type/@name = 'ianadns:digest-algorithm'">
	    <xsl:call-template name="call-templ">
	      <xsl:with-param name="tname">digest-algorithm</xsl:with-param>
	      <xsl:with-param name="pname">enum</xsl:with-param>
	      <xsl:with-param name="qname" select="$qn"/>
	    </xsl:call-template>
	  </xsl:when>
	  <xsl:when test="yin:type[@name='identityref']
			  /yin:base/@name = 'ianadns:data-rrtype'">
	    <xsl:call-template name="call-templ">
	      <xsl:with-param name="tname">data-rrtype</xsl:with-param>
	      <xsl:with-param name="pname">identity</xsl:with-param>
	      <xsl:with-param name="qname" select="$qn"/>
	    </xsl:call-template>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:attribute name="select">
	      <xsl:value-of select="$qn"/>
	    </xsl:attribute>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:element>
    </xsl:element>
  </xsl:template>
  
</xsl:stylesheet>
