<?xml version="1.0"?>

<!-- Program name: master.xsl

Copyright © 2015 by Ladislav Lhotka, CZ.NIC <lhotka@nic.cz>

This stylesheet creates a master file from zone config data.

==
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
-->

<stylesheet
    xmlns="http://www.w3.org/1999/XSL/Transform"
    xmlns:nc="urn:ietf:params:xml:ns:netconf:base:1.0"
    xmlns:dnsz="http://www.nic.cz/ns/yang/dns-zones"
    version="1.0">
  <output method="text"/>
  <strip-space elements="*"/>

  <include href="rdata.xsl"/>

  <!-- Parameters & variables -->

  <!-- Select zone by name (if empty, first zone is used) -->
  <param name="select-zone"/>

  <!-- Use only absolute domain names. -->
  <param name="absolute-only" select="0"/>

  <!-- Width of the owner field -->
  <param name="owner-width" select="21"/>

  <!-- 41 spaces (used in alignment) -->
  <variable name="spaces"
	    select="'                                         '"/>

  <!-- New line -->
  <variable name="NL" select="'&#xA;'"/>
  <variable name="SP" select="' '"/>

  <!-- Named templates -->

  <template name="left-aligned">
    <param name="width"/>
    <param name="text"/>
    <value-of
	select="concat($text,
		substring($spaces, 1, $width - string-length($text)))"/>
  </template>

  <template name="right-aligned">
    <param name="width"/>
    <param name="text"/>
    <value-of
	select="concat(substring(
		$spaces, 1, $width - string-length($text)), $text)"/>
  </template>

  <template name="value-or-default">
    <param name="node"/>
    <param name="dflt"/>
    <choose>
      <when test="$node">
	<value-of select="$node"/>
      </when>
      <otherwise>
	<value-of select="$dflt"/>
      </otherwise>
    </choose>
  </template>

  <template name="escape-quotes">
    <param name="data"/>
    <choose>
      <when test="contains($data, '&quot;')">
	<value-of select="concat(substring-before($data,'&quot;'), '\&quot;')"/>
	<call-template name="escape-quotes">
	  <with-param name="data" select="substring-after($data, '&quot;')"/>
	</call-template>
      </when>
      <otherwise>
	<value-of select="$data"/>
      </otherwise>
    </choose>
  </template>

  <template name="chop-text">
    <param name="length" select="30"/>
    <param name="data"/>
    <choose>
      <when test="string-length($text) &lt;= $length">
	<call-template name="sep-line-entry">
	  <with-param name="data" select="$text"/>
	</call-template>
      </when>
      <otherwise>
	<call-template name="sep-line-entry">
	  <with-param name="data" select="substring($text, 1, $length)"/>
	</call-template>
	<call-template name="chop-text">
	  <with-param name="length" select="$length"/>
	  <with-param name="data"
		      select="substring($text, $length+1, $length)"/>
	</call-template>
      </otherwise>
    </choose>
  </template>

  <template name="rdata-field">
    <param name="data" select="."/>
    <param name="quoted" select="false()"/>
    <choose>
      <when test="$quoted">
	<text>"</text>
	<call-template name="escape-quotes">
	  <with-param name="data" select="$data"/>
	</call-template>
	<text>"</text>
      </when>
      <otherwise>
	<value-of select="$data"/>
      </otherwise>
    </choose>
  </template>

  <template name="inline-entry">
    <param name="data" select="."/>
    <param name="quoted" select="false()"/>
    <text> </text>
    <call-template name="rdata-field">
      <with-param name="data" select="$data"/>
      <with-param name="quoted" select="$quoted"/>
    </call-template>
  </template>

  <template name="sep-line-entry">
    <param name="data" select="."/>
    <param name="quoted" select="false()"/>
    <value-of select="concat($NL, $spaces, '  ')"/>
    <call-template name="rdata-field">
      <with-param name="data" select="$data"/>
      <with-param name="quoted" select="$quoted"/>
    </call-template>
  </template>

  <template name="open-block">
    <text> (</text>
  </template>

  <template name="close-block">
    <value-of select="concat(' )', $NL)"/>
  </template>

  <template name="process-dname">
    <param name="dn"/>
    <choose>
      <when test="$absolute-only = 1">
	<value-of select="concat($dn, '.')"/>
      </when>
      <otherwise>
	<variable name="origin" select="ancestor::dnsz:zone/dnsz:name"/>
	<variable name="tail"
		  select="substring($dn, string-length($dn) -
			  string-length($origin))"/>
	<choose>
	  <when test="$dn = $origin">@</when> <!-- apex -->
	  <when test="starts-with($tail, '.') and
		      substring($tail, 2) = $origin">
	    <value-of
		select="substring($dn, 1,
			string-length($dn) - string-length($tail))"/>
	  </when>
	  <otherwise>
	    <value-of select="concat($dn, '.')"/>
	  </otherwise>
	</choose>
      </otherwise>
    </choose>
  </template>

  <template name="dnssec-algorithm">
    <param name="enum"/>
    <choose>
      <when test="$enum = 'RSAMD5'">1</when>
      <when test="$enum = 'DH'">2</when>
      <when test="$enum = 'DSA'">3</when>
      <when test="$enum = 'RSASHA1'">5</when>
      <when test="$enum = 'DSA-NSEC3-SHA1'">6</when>
      <when test="$enum = 'RSASHA1-NSEC3-SHA1'">7</when>
      <when test="$enum = 'RSASHA256'">8</when>
      <when test="$enum = 'RSASHA512'">10</when>
      <when test="$enum = 'ECC-GOST'">12</when>
      <when test="$enum = 'ECDSAP256SHA256'">13</when>
      <when test="$enum = 'ECDSAP384SHA384'">14</when>
    </choose>
  </template>

  <template name="digest-algorithm">
    <param name="enum"/>
    <choose>
      <when test="$enum = 'SHA-1'">1</when>
      <when test="$enum = 'SHA-256'">2</when>
      <when test="$enum = 'GOST-R-34.11-94'">3</when>
      <when test="$enum = 'SHA-384'">4</when>
    </choose>
  </template>

  <template name="data-rrtype">
    <param name="identity"/>
    <value-of select="substring-after($identity, 'ianadns:')"/>
  </template>

  <template name="utc-date-time">
    <param name="iso"/>
    <variable name="time" select="substring($iso, 12)"/>
    <variable name="len" select="string-length($iso)"/>
    <variable name="zero" select="substring($iso, $len , 1) = 'Z'"/>
    <value-of select="substring($iso,1,4)"/>
    <value-of select="substring($iso,6,2)"/>
    <value-of select="substring($iso,9,2)"/>
    <value-of select="substring($iso,12,2)"/>
    <value-of select="substring($iso,15,2)"/>
    <value-of select="format-number(substring-before(
			  substring($iso,18), 'Z'), '00')"/>
  </template>

  <!-- Root template -->

  <template match="/">
    <apply-templates select="//dnsz:zones"/>
  </template>

  <template match="dnsz:zones">
   <choose>
     <when test="$select-zone">
       <if test="not(dnsz:zone[dnsz:name=$select-zone])">
	 <message terminate="yes">
	   <value-of select="concat('Zone ', $select-zone, ' not found.')"/>
	 </message>
       </if>
       <apply-templates select="dnsz:zone[dnsz:name=$select-zone]"/>
     </when>
     <otherwise>
       <apply-templates select="dnsz:zone[1]"/>
     </otherwise>
   </choose>
  </template>

  <template match="dnsz:zone">
    <text>; Generated automatically form XML configuration.</text>
    <value-of select="$NL"/>
    <apply-templates select="dnsz:description">
      <with-param name="nl" select="$NL"/>
    </apply-templates>
    <value-of select="concat('$ORIGIN ', dnsz:name, '.', $NL)"/>
    <value-of select="concat('$TTL ', dnsz:default-ttl, $NL)"/>
    <apply-templates select="dnsz:SOA"/>
    <apply-templates select="dnsz:rrset"/>
    <value-of select="concat('; End of zone data.', $NL)"/>
  </template>

  <template match="dnsz:description">
    <param name="offset"/>
    <param name="nl"/>
    <value-of select="concat($offset, '; ', normalize-space(.), $nl)"/>
  </template>

  <template match="dnsz:SOA">
    <call-template name="left-aligned">
      <with-param name="width" select="$owner-width"/>
      <with-param name="text">@</with-param>
    </call-template>
    <text> </text>
    <call-template name="right-aligned">
      <with-param name="width" select="7"/>
      <with-param name="text" select="dnsz:ttl"/>
    </call-template>
    <text> </text>
    <call-template name="value-or-default">
      <with-param name="node" select="../dnsz:class"/>
      <with-param name="dflt">IN</with-param>
    </call-template>
    <text> SOA    </text>
    <call-template name="open-block"/>
    <call-template name="inline-entry">
      <with-param name="data" select="concat(dnsz:mname, '.')"/>
    </call-template>
    <call-template name="sep-line-entry">
      <with-param name="data" select="concat(dnsz:rname, '.')"/>
    </call-template>
    <call-template name="sep-line-entry">
      <with-param name="data" select="dnsz:serial"/>
    </call-template>
    <call-template name="sep-line-entry">
      <with-param name="data" select="dnsz:refresh"/>
    </call-template>
    <call-template name="sep-line-entry">
      <with-param name="data" select="dnsz:retry"/>
    </call-template>
    <call-template name="sep-line-entry">
      <with-param name="data" select="dnsz:expire"/>
    </call-template>
    <call-template name="sep-line-entry">
      <with-param name="data" select="dnsz:minimum"/>
    </call-template>
    <call-template name="close-block"/>
  </template>

  <template match="dnsz:rrset">
    <apply-templates select="dnsz:description"/>
    <apply-templates select="dnsz:rdata"/>
  </template>
  
  <template match="dnsz:rdata">
    <choose>
      <when test="position() = 1">
	<apply-templates select="ancestor::dnsz:rrset" mode="rr"/>
      </when>
      <otherwise>
	<value-of select="substring($spaces, 1, 30)"/>
      </otherwise>
    </choose>
    <call-template name="left-aligned">
      <with-param name="width" select="10"/>
      <with-param
	  name="text" select="substring-after(../dnsz:type, ':')"/>
    </call-template>
    <apply-templates select="*[local-name() =
			     substring-after(../../dnsz:type, ':')]"/>
    <apply-templates select="dnsz:description">
      <with-param name="offset" select="$SP"/>
    </apply-templates>
    <value-of select="$NL"/>
  </template>

  <template match="dnsz:rrset" mode="rr">
    <call-template name="left-aligned">
      <with-param name="width" select="$owner-width"/>
      <with-param name="text">
	<choose>
	  <when test="position()=1 and dnsz:owner=../dnsz:name or
		      dnsz:owner = preceding-sibling::dnsz:rrset[1]/dnsz:owner"/>
	  <otherwise>
	    <call-template name="process-dname">
	      <with-param name="dn" select="dnsz:owner"/>
	    </call-template>
	  </otherwise>
	</choose>
      </with-param>
    </call-template>
    <text> </text>
    <call-template name="right-aligned">
      <with-param name="width" select="7"/>
      <with-param name="text" select="dnsz:ttl"/>
    </call-template>
    <text> </text>
  </template>

  <template match="dnsz:DNSKEY/dnsz:flags">
    <value-of select="contains(., 'zone-key') * 256
		      + contains(., 'secure-entry-point')"/>
  </template>

  <template match="dnsz:*">
    <text> NOT IMPLEMENTED</text>
  </template>

</stylesheet>
