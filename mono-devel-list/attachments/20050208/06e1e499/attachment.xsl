<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html"/>
	
	<xsl:template match="/weather/temperatures">

		<xsl:variable name="small">
			<xsl:copy-of select=".//temperature[1]"/>
		</xsl:variable>

		<xsl:variable name="big" select=".//temperature[3]"/>
		
		<xsl:choose>
			<xsl:when test="$big &gt; $small">good</xsl:when>
			<xsl:otherwise>BAD!!!</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
