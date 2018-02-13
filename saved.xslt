
    <xsl:template match="ead:did" mode="dsc">
        <xsl:choose>
            <xsl:when test="../@level='subcollection' or ../@level='subgrp' or ../@level='series' 
                or ../@level='subseries'or ../@level='collection'or ../@level='fonds' or 
                ../@level='recordgrp' or ../@level='subfonds'">    
                <h3 class="did-core">
                    <a href="#" aria-hidden="true" aria-expanded="false" data-toggle="collapse" data-target="#collapse1" class="collapsed">
                        <xsl:call-template name="component-did-core"/>
                    </a>
                </h3>
            </xsl:when>
            <!--Otherwise render the text in its normal font.-->
            <xsl:otherwise>
                <p><xsl:call-template name="component-did-core"/></p>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
