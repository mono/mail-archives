<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:output method="text" indent="no" />

	<!--xsl:strip-space elements="*" / -->

	<xsl:template match="/">
		<xsl:for-each select="*">
			<xsl:choose>
				<xsl:when test="name()='Type'">
					<xsl:apply-templates select="." />
				</xsl:when>
				<xsl:when test="name()='Docs'">
					<xsl:apply-templates select="." />
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

	<xsl:template match="Type">
		<xsl:apply-templates select="Docs" />
		<xsl:apply-templates select="Members/Member" />
	</xsl:template>

	<xsl:template match="Docs">
		<xsl:apply-templates select="summary" />

		<xsl:if test="param">
			<xsl:text>=== Parameters ===&#xA;</xsl:text>
			<xsl:apply-templates select="param" />
			<xsl:text>&#xA;&#xA;</xsl:text>
		</xsl:if>

		<xsl:if test="exception">
			<xsl:text>=== Exceptions ===&#xA;</xsl:text>
			<xsl:apply-templates select="exception" />
			<xsl:text>&#xA;&#xA;</xsl:text>
		</xsl:if>

		<xsl:apply-templates select="remarks" />

	</xsl:template>

	<xsl:template match="Member">
		<xsl:text>== </xsl:text>
		<xsl:value-of select="@MemberName" />
		<xsl:if test="Parameters/*">
			<xsl:text>(</xsl:text>
			<xsl:for-each select="Parameters/Parameter">
				<!-- equivalent to position()=1 but more efficient -->
				<xsl:if test="@Name != ../Parameter[1]/@Name">
					<xsl:text>, </xsl:text>
				</xsl:if>
				<xsl:value-of select="@Type" />
			</xsl:for-each>
			<xsl:text>)</xsl:text>
		</xsl:if>
		<xsl:text> ==&#xA;</xsl:text>
		<xsl:apply-templates select="Docs" />
	</xsl:template>

	<xsl:template match="summary">
		<xsl:text>&#xA;=== Summary ===&#xA;</xsl:text>
		<xsl:call-template name="content" />
		<xsl:text>&#xA;&#xA;</xsl:text>
	</xsl:template>

	<xsl:template match="remarks">
		<xsl:text>&#xA;=== Remarks ===&#xA;</xsl:text>
		<xsl:call-template name="content" />
		<xsl:text>&#xA;&#xA;</xsl:text>
	</xsl:template>

	<!-- Template for editable content -->

	<xsl:template name="content">
		<xsl:for-each select="* | text()">
			<xsl:choose>
				<xsl:when test="@type='table' and name(.)='list'">
					<xsl:call-template name="table" />
				</xsl:when>
				<xsl:when test="name(.)='para' or name(.)='block'">
					<xsl:apply-templates />
				</xsl:when>
				<xsl:when test="*">
					<xsl:message>Unexpected element '<xsl:value-of select="name()" />'</xsl:message>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="normalize-space(.)" />
					<xsl:text>&#xA;</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<!-- inline content -->

	<xsl:template match="text()">
		<xsl:value-of select="normalize-space (translate(., '&#xA;', ''))" />
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

	<!-- block content -->

	<xsl:template match="para">
		<xsl:apply-templates />
		<xsl:text>&#xA;&#xA;</xsl:text><!-- make two line endings -->
	</xsl:template>

	<xsl:template match="exception">
		<xsl:text>;</xsl:text>
		<xsl:value-of select="substring (@cref, 3)" />
		<xsl:text>:</xsl:text>
		<xsl:apply-templates />
		<xsl:text>&#xA;&#xA;</xsl:text><!-- make two line endings -->
	</xsl:template>

	<xsl:template match="param">
		<xsl:text>;</xsl:text>
		<xsl:value-of select="@name" />
		<xsl:text>:</xsl:text>
		<xsl:apply-templates />
		<xsl:text>&#xA;&#xA;</xsl:text><!-- make two line endings -->
	</xsl:template>

	<xsl:template match="block">
		<xsl:choose>
			<xsl:when test="@subset='none' and @type='note'">
				<xsl:text>:</xsl:text>
				<xsl:apply-templates />
				<xsl:text>&#xA;&#xA;</xsl:text><!-- make two line endings -->
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
		<xsl:text>&#xA;{| border="1" cellspacing="2"&#xA;</xsl:text>
		<xsl:if test="listheader">
			<xsl:text>! </xsl:text>
			<xsl:value-of select="listheader/term" />
			<xsl:text> !! </xsl:text>
			<xsl:value-of select="listheader/description" />
			<xsl:text>&#xA;</xsl:text>
		</xsl:if>
		<xsl:for-each select="item">
			<xsl:text>|-&#xA;</xsl:text>
			<xsl:text>| </xsl:text>
			<xsl:value-of select="normalize-space(term)" />
			<xsl:text> || </xsl:text>
			<xsl:apply-templates select="description" />
			<xsl:text>&#xA;</xsl:text>
		</xsl:for-each>
		<xsl:text>|}&#xA;</xsl:text>
	</xsl:template>

</xsl:stylesheet>
