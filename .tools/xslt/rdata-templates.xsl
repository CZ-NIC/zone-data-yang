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

  <xsl:template match="yin:module">
    <xsl:element name="xsl:stylesheet">
      <xsl:copy-of select="namespace::*"/>
      <xsl:attribute name="version">1.0</xsl:attribute>
      <xsl:element name="xsl:output">
	<xsl:attribute name="method">xml</xsl:attribute>
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
      <xsl:element name="xsl:with-param">
	<xsl:variable name="qn" select="concat('dnsz:', @name)"/>
	<xsl:attribute name="name">data</xsl:attribute>
	<xsl:choose>
	  <xsl:when test="yin:type/@name = 'domain-name'">
	    <xsl:element name="xsl:call-template">
	      <xsl:attribute
		  name="name">process-dname</xsl:attribute>
	      <xsl:element name="xsl:with-param">
		<xsl:attribute name="name">dn</xsl:attribute>
		<xsl:attribute name="select">
		  <xsl:value-of select="$qn"/>
		</xsl:attribute>
	      </xsl:element>
	    </xsl:element>
	  </xsl:when>
	  <xsl:when test="yin:type/@name = 'ianadns:dnssec-algorithm'">
	    <xsl:element name="xsl:call-template">
	      <xsl:attribute
		  name="name">dnssec-algorithm</xsl:attribute>
	      <xsl:element name="xsl:with-param">
		<xsl:attribute name="name">enum</xsl:attribute>
		<xsl:attribute name="select">
		  <xsl:value-of select="$qn"/>
		</xsl:attribute>
	      </xsl:element>
	    </xsl:element>
	  </xsl:when>
	  <xsl:when test="yin:type[@name='identityref']
			  /yin:base/@name = 'ianadns:data-rrtype'">
	    <xsl:element name="xsl:call-template">
	      <xsl:attribute
		  name="name">data-rrtype</xsl:attribute>
	      <xsl:element name="xsl:with-param">
		<xsl:attribute name="name">identity</xsl:attribute>
		<xsl:attribute name="select">
		  <xsl:value-of select="$qn"/>
		</xsl:attribute>
	      </xsl:element>
	    </xsl:element>
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
