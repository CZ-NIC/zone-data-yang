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

  <!-- Parameters & variables -->

  <!-- Select zone by name (if empty, first zone is used) -->
  <param name="select-zone"/>

  <!-- Use only absolute domain names. -->
  <param name="absolute-only" select="0"/>

  <!-- Width of the owner field -->
  <param name="owner-width" select="21"/>

  <!-- 50 spaces (used in alignment) -->
  <variable name="spaces"
	    select="'                                                  '"/>

  <!-- New line -->
  <variable name="NL" select="'&#xA;'"/>

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
    <apply-templates select="dnsz:description"/>
    <value-of select="concat('$ORIGIN ', dnsz:name, '.', $NL)"/>
    <value-of select="concat('$TTL ', dnsz:default-ttl, $NL)"/>
    <apply-templates select="dnsz:soa"/>
    <value-of select="concat('; End of zone data.', $NL)"/>
  </template>

  <template match="dnsz:description">
    <value-of select="concat('; ', normalize-space(.), $NL)"/>
  </template>

  <template match="dnsz:soa">
    <call-template name="left-aligned">
      <with-param name="width" select="$owner-width"/>
      <with-param name="text">@</with-param>
    </call-template>
    <call-template name="right-aligned">
      <with-param name="width" select="7"/>
      <with-param name="text" select="dnsz:ttl"/>
    </call-template>
    <text> </text>
    <call-template name="value-or-default">
      <with-param name="node" select="../dnsz:class"/>
      <with-param name="dflt">IN</with-param>
    </call-template>
    <text> SOA </text>
    <value-of select="$NL"/>
  </template>

</stylesheet>
