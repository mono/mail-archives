<?xml version='1.0' ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output indent="yes"/>
	<xsl:template match="/">
		<tests>
			<xsl:for-each select="test-suite/test-catalog/test-case[scenario/@operation='standard']">
				<xsl:element name="test">
					<xsl:attribute name="id">
						<xsl:value-of select="@id"/>
					</xsl:attribute>
					<path>
						<xsl:value-of select="file-path"/>
					</path>
					<data>
						<xsl:value-of select="scenario/input-file[@role='principal-data']"/>
					</data>
					<stylesheet>
						<xsl:value-of select="scenario/input-file[@role='principal-stylesheet']"/>
					</stylesheet>
					<output>
						<xsl:value-of select="scenario/output-file"/>
					</output>
				</xsl:element>
			</xsl:for-each>
		</tests>
	</xsl:template>
</xsl:stylesheet>
