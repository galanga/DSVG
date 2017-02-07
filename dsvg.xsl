
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="path">
    <path>
      <xsl:copy-of select="@*"/>
      <xsl:attribute name="d">
        <xsl:value-of select="@d"/>
        <xsl:for-each select="./*">
          <xsl:choose>
            <xsl:when test="name() = 'moveto'">
              <xsl:choose>
                <xsl:when test="@type='relative'">
                  <xsl:value-of select="'m'"/>
                </xsl:when>
                <xsl:when test="@type='rel'">
                  <xsl:value-of select="'m'"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="'M'"/>
                </xsl:otherwise>
              </xsl:choose>
              <xsl:value-of select="@d"/>
            </xsl:when>
            <xsl:when test="name() = 'lineto'">
              <xsl:choose>
                <xsl:when test="@type='relative'">
                  <xsl:value-of select="'l'"/>
                </xsl:when>
                <xsl:when test="@type='rel'">
                  <xsl:value-of select="'l'"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="'L'"/>
                </xsl:otherwise>
              </xsl:choose>
              <xsl:value-of select="@d"/>
            </xsl:when>
            <xsl:when test="name() = 'moveto-rel'">
              <xsl:value-of select="'m'"/>
              <xsl:value-of select="@d"/>
            </xsl:when>
            <xsl:when test="name() = 'lineto-rel'">
              <xsl:value-of select="'l'"/>
              <xsl:value-of select="@d"/>
            </xsl:when>
            <xsl:when test="name() = 'closepath'">
              <xsl:value-of select="'z'"/>
            </xsl:when>
          </xsl:choose>
        </xsl:for-each>
      </xsl:attribute>
    </path>
  </xsl:template>
</xsl:stylesheet>
