<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:output method="text" />

	<xsl:strip-space elements="*" />

	<xsl:template match="/">
		<xsl:for-each select="*">
			<xsl:choose>
				<xsl:when test="name()='Type'">
					<xsl:apply-templates select="Members/Member" />
				</xsl:when>
				<xsl:when test="name()='Docs'">
					<xsl:apply-templates/>
				</xsl:when>
				<xsl:when test="name()='summary'">
					<xsl:call-template name="content" />
				</xsl:when>
				<xsl:when test="name()='remarks'">
					<xsl:call-template name="content" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:message>Unexpected top level element: <xsl:value-of select="name()" /></xsl:message>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="Docs">
		<xsl:apply-templates select="summary" />
		<xsl:apply-templates select="remarks" />
	</xsl:template>

	<xsl:template match="Member">
== <xsl:value-of select="@MemberName" /> ==
<xsl:apply-templates select="Docs" />
	</xsl:template>

	<xsl:template match="summary">
=== Summary ===
<xsl:text>&#xD;</xsl:text>
<xsl:call-template name="content" />
<xsl:text>&#xD;</xsl:text>
	</xsl:template>

	<xsl:template match="remarks">
=== Remarks ===
<xsl:text>&#xD;</xsl:text>
<xsl:call-template name="content" />
<xsl:text>&#xD;</xsl:text>
	</xsl:template>

	<!-- Template for editable content -->

	<xsl:template name="content">
		<xsl:for-each select="* | text()">
			<xsl:choose>
				<xsl:when test="name()='para' or name()='list' or name() = 'block'">
					<xsl:apply-templates />
				</xsl:when>
				<xsl:when test="*">
					<xsl:message>Unexpected element '<xsl:value-of select="name()" />'</xsl:message>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="." />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="text()">
		<xsl:value-of select="normalize-space (translate(., '&#xD;', ''))" />
	</xsl:template>

	<xsl:template match="para">
		<xsl:apply-templates />
		<xsl:text>&#xD;&#xD;</xsl:text><!-- make two line endings -->
	</xsl:template>

	<xsl:template match="paramref">
		<xsl:text> </xsl:text><xsl:value-of select="concat('[[', @name, ']]')" /><xsl:text> </xsl:text>
	</xsl:template>

	<xsl:template match="see">
		<xsl:text> </xsl:text>
		<xsl:choose>
			<xsl:when test="@cref">
				<xsl:value-of select="concat('[[', @cref, ' | ', substring (@cref, 3), ']]')" />
			</xsl:when>
			<xsl:when test="@langword">
				<code class='langword'><xsl:value-of select="@langword" /></code>
			</xsl:when>
		</xsl:choose>
		<xsl:text> </xsl:text>
	</xsl:template>

	<xsl:template match="block">
		<xsl:choose>
			<xsl:when test="@subset='none' and @type='note'">
:<xsl:apply-templates />
			</xsl:when>
			<xsl:otherwise>
				<xsl:message>Unexpected block element: subset is '<xsl:value-of select="@subset" />' and type is '<xsl:value-of select="@type" />'</xsl:message>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="list">
		<xsl:choose>
			<xsl:when test="@type='table'">
				<xsl:call-template name="table" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:message>Unexpected list type: <xsl:value-of select="@type" /></xsl:message>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="table">
		<xsl:text>{| border="1" cellspacing="2"&#xD;</xsl:text>
		<xsl:if test="listheader">
			<xsl:text>! </xsl:text>
			<xsl:value-of select="term" />
			<xsl:text> !! </xsl:text>
			<xsl:value-of select="description" />
			<xsl:text>&#xD;</xsl:text>
		</xsl:if>
		<xsl:for-each select="item">
			<xsl:text>|-&#xD;</xsl:text>
			<xsl:text>| </xsl:text>
			<xsl:value-of select="term" />
			<xsl:text> || </xsl:text>
			<xsl:apply-templates select="description" />
			<xsl:text>&#xD;</xsl:text>
		</xsl:for-each>
		<xsl:text>|}</xsl:text>
	</xsl:template>

</xsl:stylesheet>
