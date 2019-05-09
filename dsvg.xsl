
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="polygon">
    <polygon>
      <xsl:copy-of select="@*"/>
      <xsl:attribute name="points">
        <xsl:value-of select="@points"/>
        <xsl:for-each select="./*">
          <xsl:choose>
            <xsl:when test="name() = 'point'">
              <xsl:choose>
                <xsl:when test="@x and @y">
                  <xsl:value-of select="@x"/>
                  <xsl:value-of select="&quot;,&quot;"/>
                  <xsl:value-of select="@y"/>
                  <xsl:value-of select="&quot; &quot;"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="@d"/>
                  <xsl:value-of select="&quot; &quot;"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:when>
          </xsl:choose>
        </xsl:for-each>
      </xsl:attribute>
    </polygon>
  </xsl:template>
  <xsl:template match="polyline">
    <polyline>
      <xsl:copy-of select="@*"/>
      <xsl:attribute name="points">
        <xsl:value-of select="@points"/>
        <xsl:for-each select="./*">
          <xsl:choose>
            <xsl:when test="name() = 'point'">
              <xsl:choose>
                <xsl:when test="@x and @y">
                  <xsl:value-of select="@x"/>
                  <xsl:value-of select="&quot;,&quot;"/>
                  <xsl:value-of select="@y"/>
                  <xsl:value-of select="&quot; &quot;"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="@d"/>
                  <xsl:value-of select="&quot; &quot;"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:when>
          </xsl:choose>
        </xsl:for-each>
      </xsl:attribute>
    </polyline>
  </xsl:template>
  <xsl:template match="path">
    <path>
      <xsl:copy-of select="@*"/>
      <xsl:attribute name="d">
        <xsl:value-of select="@d"/>
        <xsl:for-each select="./*">
          <xsl:choose>
            <xsl:when test="name() = 'lineto'">
              <xsl:choose>
                <xsl:when test="@type='relative' or @type='rel'">
                  <xsl:choose>
                    <xsl:when test="@y and not(@x)">
                      <xsl:value-of select="&quot;v&quot;"/>
                      <xsl:value-of select="@y"/>
                    </xsl:when>
                    <xsl:when test="@x and not(@y)">
                      <xsl:value-of select="&quot;h&quot;"/>
                      <xsl:value-of select="@x"/>
                    </xsl:when>
                    <xsl:when test="@x and @y">
                      <xsl:value-of select="&quot;l&quot;"/>
                      <xsl:value-of select="@x"/>
                      <xsl:value-of select="&quot;,&quot;"/>
                      <xsl:value-of select="@y"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="&quot;l&quot;"/>
                      <xsl:value-of select="@d"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:when>
                <!-- default to absolute positioning if relative not specified-->
                <xsl:otherwise> 
                  <xsl:choose>
                    <xsl:when test="@y and not(@x)">
                      <xsl:value-of select="&quot;V&quot;"/>
                      <xsl:value-of select="@y"/>
                    </xsl:when>
                    <xsl:when test="@x and not(@y)">
                      <xsl:value-of select="&quot;H&quot;"/>
                      <xsl:value-of select="@x"/>
                    </xsl:when>
                    <xsl:when test="@x and @y">
                      <xsl:value-of select="&quot;L&quot;"/>
                      <xsl:value-of select="@x"/>
                      <xsl:value-of select="&quot;,&quot;"/>
                      <xsl:value-of select="@y"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="&quot;L&quot;"/>
                      <xsl:value-of select="@d"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:when>
            <xsl:when test="name() = 'moveto'">
              <xsl:choose>
                <xsl:when test="@type='relative' or @type='rel'">
                  <xsl:choose>
                    <xsl:when test="@x and @y">
                      <xsl:value-of select="&quot;m&quot;"/>
                      <xsl:value-of select="@x"/>
                      <xsl:value-of select="&quot;,&quot;"/>
                      <xsl:value-of select="@y"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="&quot;m&quot;"/>
                      <xsl:value-of select="@d"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:when>
                <!-- default to absolute positioning-->
                <xsl:otherwise>
                  <xsl:choose>
                    <xsl:when test="@x and @y">
                      <xsl:value-of select="&quot;M&quot;"/>
                      <xsl:value-of select="@x"/>
                      <xsl:value-of select="&quot;,&quot;"/>
                      <xsl:value-of select="@y"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="&quot;M&quot;"/>
                      <xsl:value-of select="@d"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:when>
            <xsl:when test="name() = 'curveto'">
              <xsl:choose>
                <xsl:when test="@type='relative' or @type='rel'">
                  <xsl:choose>
                    <xsl:when test="@x1 and @y1 and @x2 and @y2 and @x and @y">
                      <xsl:value-of select="&quot;c&quot;"/>
                      <xsl:value-of select="@x1"/>
                      <xsl:value-of select="&quot;,&quot;"/>
                      <xsl:value-of select="@y1"/>
                      <xsl:value-of select="&quot; &quot;"/>
                      <xsl:value-of select="@x2"/>
                      <xsl:value-of select="&quot;,&quot;"/>
                      <xsl:value-of select="@y2"/>
                      <xsl:value-of select="&quot; &quot;"/>
                      <xsl:value-of select="@x"/>
                      <xsl:value-of select="&quot;,&quot;"/>
                      <xsl:value-of select="@y"/>
                    </xsl:when>
                    <xsl:when test="@x2 and @y2 and @x and @y">
                      <xsl:value-of select="&quot;c&quot;"/>
                      <xsl:value-of select="@x2"/>
                      <xsl:value-of select="&quot;,&quot;"/>
                      <xsl:value-of select="@y2"/>
                      <xsl:value-of select="&quot; &quot;"/>
                      <xsl:value-of select="@x"/>
                      <xsl:value-of select="&quot;,&quot;"/>
                      <xsl:value-of select="@y"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="&quot;c&quot;"/>
                      <xsl:value-of select="@d"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:when>
                <!-- default to absolute positioning-->
                <xsl:otherwise>
                  <xsl:choose>
                    <xsl:when test="@x1 and @y1 and @x2 and @y2 and @x and @y">
                      <xsl:value-of select="&quot;C&quot;"/>
                      <xsl:value-of select="@x1"/>
                      <xsl:value-of select="&quot;,&quot;"/>
                      <xsl:value-of select="@y1"/>
                      <xsl:value-of select="&quot; &quot;"/>
                      <xsl:value-of select="@x2"/>
                      <xsl:value-of select="&quot;,&quot;"/>
                      <xsl:value-of select="@y2"/>
                      <xsl:value-of select="&quot; &quot;"/>
                      <xsl:value-of select="@x"/>
                      <xsl:value-of select="&quot;,&quot;"/>
                      <xsl:value-of select="@y"/>
                    </xsl:when>
                    <xsl:when test="@x2 and @y2 and @x and @y">
                      <xsl:value-of select="&quot;C&quot;"/>
                      <xsl:value-of select="@x2"/>
                      <xsl:value-of select="&quot;,&quot;"/>
                      <xsl:value-of select="@y2"/>
                      <xsl:value-of select="&quot; &quot;"/>
                      <xsl:value-of select="@x"/>
                      <xsl:value-of select="&quot;,&quot;"/>
                      <xsl:value-of select="@y"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="&quot;C&quot;"/>
                      <xsl:value-of select="@d"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:when>
            <xsl:when test="name() = 'quadto'">
              <xsl:choose>
                <xsl:when test="@type='relative' or @type='rel'">
                  <xsl:choose>
                    <xsl:when test="@x1 and @y1 and @x and @y">
                      <xsl:value-of select="&quot;q&quot;"/>
                      <xsl:value-of select="@x1"/>
                      <xsl:value-of select="&quot;,&quot;"/>
                      <xsl:value-of select="@y1"/>
                      <xsl:value-of select="&quot; &quot;"/>
                      <xsl:value-of select="@x"/>
                      <xsl:value-of select="&quot;,&quot;"/>
                      <xsl:value-of select="@y"/>
                    </xsl:when>
                    <xsl:when test="@x and @y">
                      <xsl:value-of select="&quot;q&quot;"/>
                      <xsl:value-of select="@x"/>
                      <xsl:value-of select="&quot;,&quot;"/>
                      <xsl:value-of select="@y"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="&quot;q&quot;"/>
                      <xsl:value-of select="@d"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:when>
                <!-- default to absolute positioning-->
                <xsl:otherwise>
                  <xsl:choose>
                    <xsl:when test="@x1 and @y1 and @x and @y">
                      <xsl:value-of select="&quot;Q&quot;"/>
                      <xsl:value-of select="@x1"/>
                      <xsl:value-of select="&quot;,&quot;"/>
                      <xsl:value-of select="@y1"/>
                      <xsl:value-of select="&quot; &quot;"/>
                      <xsl:value-of select="@x"/>
                      <xsl:value-of select="&quot;,&quot;"/>
                      <xsl:value-of select="@y"/>
                    </xsl:when>
                    <xsl:when test="@x and @y">
                      <xsl:value-of select="&quot;Q&quot;"/>
                      <xsl:value-of select="@x"/>
                      <xsl:value-of select="&quot;,&quot;"/>
                      <xsl:value-of select="@y"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="&quot;Q&quot;"/>
                      <xsl:value-of select="@d"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:when>
            <xsl:when test="name() = 'arcto'">
              <xsl:choose>
                <xsl:when test="@type='relative' or @type='rel'">
                  <xsl:choose>
                    <xsl:when test="@x1 and @y1 and @x and @y"></xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="&quot;a&quot;"/>
                      <xsl:value-of select="@d"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="&quot;A&quot;"/>
                  <xsl:choose>
                    <xsl:when test="@rx and @ry and @rotation and @x and @y">
                      <xsl:value-of select="@rx"/>
                      <xsl:value-of select="&quot;,&quot;"/>
                      <xsl:value-of select="@ry"/>
                      <xsl:value-of select="&quot; &quot;"/>
                      <xsl:value-of select="@rotation"/>
                      <xsl:value-of select="&quot; &quot;"/>
                      <xsl:choose>
                        <xsl:when test="@large-arc">
                          <xsl:value-of select="@large-arc"/>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:value-of select="&quot;0&quot;"/>
                        </xsl:otherwise>
                      </xsl:choose>
                      <xsl:value-of select="&quot;,&quot;"/>
                      <xsl:choose>
                        <xsl:when test="@sweep">
                          <xsl:value-of select="@sweep"/>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:value-of select="&quot;0&quot;"/>
                        </xsl:otherwise>
                      </xsl:choose>
                      <xsl:value-of select="&quot; &quot;"/>
                      <xsl:value-of select="@x"/>
                      <xsl:value-of select="&quot;,&quot;"/>
                      <xsl:value-of select="@y"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="@d"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:when>
            <xsl:when test="name() = 'pathseg'">
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
