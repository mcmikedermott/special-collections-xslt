
    <!-- Formats headings throughout the finding aid -->
    <!-->
    <xsl:template match="ead:head[parent::*/parent::ead:archdesc]">
        <xsl:choose>
            <xsl:when test="parent::ead:accessrestrict or parent::ead:userestrict or
                parent::ead:custodhist or parent::ead:accruals or
                parent::ead:altformavail or parent::ead:acqinfo or
                parent::ead:processinfo or parent::ead:appraisal or
                parent::ead:originalsloc or  
                parent::ead:relatedmaterial or parent::ead:separatedmaterial or parent::ead:prefercite">
                <h4 class="clist">
                    <xsl:choose>
                        <xsl:when test="parent::*/@id">
                            <xsl:attribute name="id"><xsl:value-of select="parent::*/@id"/></xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="id"><xsl:value-of select="generate-id(parent::*)"/></xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:apply-templates/>
                </h4>
            </xsl:when>
            <xsl:otherwise>
                <h3>
                    <xsl:choose>
                        <xsl:when test="parent::*/@id">
                            <xsl:attribute name="id"><xsl:value-of select="parent::*/@id"/></xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="id"><xsl:value-of select="generate-id(parent::*)"/></xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:apply-templates/>
                </h3>                
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="ead:head">
        <h4 class="clist2"><xsl:apply-templates/></h4>
    </xsl:template>
    -->

    <!-- 
        <value>nonproport</value>        
    -->

    <!--This section of the stylesheet creates a div for each c01 or c 
        It then recursively processes each child component of the c01 by 
        calling the clevel template.
        Edited 5/31/12: Added parameter to indicate clevel margin, parameter is called by clevelMargin variable
    -->
    <xsl:template match="ead:cX">
        <xsl:call-template name="clevel">
            <xsl:with-param name="level">01</xsl:with-param>
        </xsl:call-template>
        <xsl:for-each select="ead:c">
            <xsl:call-template name="clevel">
                <xsl:with-param name="level">02</xsl:with-param>
            </xsl:call-template>
            <xsl:for-each select="ead:c">
                <xsl:call-template name="clevel">
                    <xsl:with-param name="level">03</xsl:with-param>
                </xsl:call-template>    
                <xsl:for-each select="ead:c">
                    <xsl:call-template name="clevel">
                        <xsl:with-param name="level">04</xsl:with-param>
                    </xsl:call-template>
                    <xsl:for-each select="ead:c">
                        <xsl:call-template name="clevel">
                            <xsl:with-param name="level">05</xsl:with-param>
                        </xsl:call-template>
                        <xsl:for-each select="ead:c">
                            <xsl:call-template name="clevel">
                                <xsl:with-param name="level">06</xsl:with-param>
                            </xsl:call-template> 
                            <xsl:for-each select="ead:c">
                                <xsl:call-template name="clevel">
                                    <xsl:with-param name="level">07</xsl:with-param>
                                </xsl:call-template>
                                <xsl:for-each select="ead:c">
                                    <xsl:call-template name="clevel">
                                        <xsl:with-param name="level">08</xsl:with-param>
                                    </xsl:call-template>
                                    <xsl:for-each select="ead:c">
                                        <xsl:call-template name="clevel">
                                            <xsl:with-param name="level">09</xsl:with-param>
                                        </xsl:call-template>    
                                    </xsl:for-each>
                                </xsl:for-each>
                            </xsl:for-each>
                        </xsl:for-each>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:for-each>
        <!-- ADDED 5/31/12: Return to top only after series -->
        <xsl:if test="self::*[@level='series']">
            <div>
                <div colspan="5">
                    <!-- xsl:call-template name="returnTOC"/ -->
                </div>
            </div>    
        </xsl:if>
    </xsl:template>

    <xsl:template match="ead:c01X">
        <xsl:call-template name="clevel"/>
        <xsl:for-each select="ead:c02">
            <xsl:call-template name="clevel"/>
            <xsl:for-each select="ead:c03">
                <xsl:call-template name="clevel"/>
                <xsl:for-each select="ead:c04">
                    <xsl:call-template name="clevel"/>
                    <xsl:for-each select="ead:c05">
                        <xsl:call-template name="clevel"/>
                        <xsl:for-each select="ead:c06">
                            <xsl:call-template name="clevel"/>
                            <xsl:for-each select="ead:c07">
                                <xsl:call-template name="clevel"/>
                                <xsl:for-each select="ead:c08">
                                    <xsl:call-template name="clevel"/>
                                    <xsl:for-each select="ead:c09">
                                        <xsl:call-template name="clevel"/>
                                        <xsl:for-each select="ead:c10">
                                            <xsl:call-template name="clevel"/>
                                            <xsl:for-each select="ead:c11">
                                                <xsl:call-template name="clevel"/>
                                                <xsl:for-each select="ead:c12">
                                                    <xsl:call-template name="clevel"/>
                                                </xsl:for-each>
                                            </xsl:for-each>
                                        </xsl:for-each>
                                    </xsl:for-each>
                                </xsl:for-each>
                            </xsl:for-each>
                        </xsl:for-each>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:for-each>
        
        <!-- ADDED 5/31/12: Return to top only after series -->
        <xsl:if test="self::*[@level='series']">
            <div>
                <div colspan="5">
                        <!-- xsl:call-template name="returnTOC"/ -->
                </div>
            </div>    
        </xsl:if>
        
    </xsl:template>
    
    <!--This is a named template that processes all c0* elements  -->
    <xsl:template name="clevel">
    <!-- Establishes which level is being processed in order to provided indented displays. 
        Indents handled by CSS margins-->
        <xsl:param name="level" />
        <xsl:variable name="clevelMargin">
            <xsl:choose>
                <xsl:when test="$level = 01">c01</xsl:when>
                <xsl:when test="$level = 02">c02</xsl:when>
                <xsl:when test="$level = 03">c03</xsl:when>
                <xsl:when test="$level = 04">c04</xsl:when>
                <xsl:when test="$level = 05">c05</xsl:when>
                <xsl:when test="$level = 06">c06</xsl:when>
                <xsl:when test="$level = 07">c07</xsl:when>
                <xsl:when test="$level = 08">c08</xsl:when>
                <xsl:when test="$level = 09">c09</xsl:when>
                <xsl:when test="$level = 10">c10</xsl:when>
                <xsl:when test="$level = 11">c11</xsl:when>
                <xsl:when test="$level = 12">c12</xsl:when>
                <xsl:when test="../ead:c">c</xsl:when>
                <xsl:when test="../ead:c01">c01</xsl:when>
                <xsl:when test="../ead:c02">c02</xsl:when>
                <xsl:when test="../ead:c03">c03</xsl:when>
                <xsl:when test="../ead:c04">c04</xsl:when>
                <xsl:when test="../ead:c05">c05</xsl:when>
                <xsl:when test="../ead:c06">c06</xsl:when>
                <xsl:when test="../ead:c07">c07</xsl:when>
                <xsl:when test="../ead:c08">c08</xsl:when>
                <xsl:when test="../ead:c08">c09</xsl:when>
                <xsl:when test="../ead:c08">c10</xsl:when>
                <xsl:when test="../ead:c08">c11</xsl:when>
                <xsl:when test="../ead:c08">c12</xsl:when>
            </xsl:choose>
        </xsl:variable>
    <!-- Establishes a class for even and odd rows in the table for color coding. 
        Colors are Declared in the CSS. -->
        <xsl:variable name="colorClass">
            <xsl:choose>
                <xsl:when test="ancestor-or-self::*[@level='file' or @level='item']">
                    <xsl:choose>
                        <xsl:when test="(position() mod 2 = 0)">odd</xsl:when>
                        <xsl:otherwise>even</xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
            </xsl:choose>
        </xsl:variable>
        <!-- Processes the all child elements of the c or c0* level -->
        <xsl:for-each select=".">
            <xsl:choose>
                <!--Formats Series and Groups  -->
                <xsl:when test="@level='subcollection' or @level='subgrp' or @level='series' 
                    or @level='subseries' or @level='collection'or @level='fonds' or 
                    @level='recordgrp' or @level='subfonds' or @level='class' or (@level='otherlevel' and not(child::ead:did/ead:container))">
                    <p>START HEADER</p>
                    <div> 
                        <xsl:attribute name="class">
                            <xsl:choose>
                                <xsl:when test="@level='subcollection' or @level='subgrp' or @level='subseries' or @level='subfonds'">subseries</xsl:when>
                                <xsl:otherwise>series</xsl:otherwise>
                            </xsl:choose>    
                        </xsl:attribute>
                        <xsl:choose>
                            <xsl:when test="ead:did/ead:container">
                                <div class="{$clevelMargin}">
                                <xsl:choose>                                
                                    <xsl:when test="count(ead:did/ead:container) &lt; 1">
                                        <xsl:attribute name="colspan">
                                            <xsl:text>5</xsl:text>
                                        </xsl:attribute>
                                    </xsl:when>
                                    <xsl:when test="count(ead:did/ead:container) =1">
                                        <xsl:attribute name="colspan">
                                            <xsl:text>4</xsl:text>
                                        </xsl:attribute>
                                    </xsl:when>
                                    <xsl:when test="count(ead:did/ead:container) = 2">
                                        <xsl:attribute name="colspan">
                                            <xsl:text>3</xsl:text>
                                        </xsl:attribute>
                                    </xsl:when>
                                    <xsl:when test="count(ead:did/ead:container) = 3">
                                        <xsl:attribute name="colspan">
                                            <xsl:text>2</xsl:text>
                                        </xsl:attribute>
                                    </xsl:when>
                                    <xsl:otherwise/>
                                </xsl:choose>    
                                <xsl:call-template name="anchor"/>
                                <xsl:apply-templates select="ead:did" mode="dsc"/>
                                <xsl:apply-templates select="child::*[not(ead:did) and not(self::ead:did)]"/>
                                </div>
                                <xsl:for-each select="descendant::ead:did[ead:container][1]/ead:container">    
                                    <div class="containerHeader">    
                                        <xsl:value-of select="@type"/><br/><xsl:value-of select="."/>       
                                    </div>    
                                </xsl:for-each>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:apply-templates select="ead:did" mode="dsc"/>
                                <div colspan="5" class="{$clevelMargin} series-desc">
                                    <xsl:call-template name="anchor"/>
                                    <xsl:apply-templates select="child::*[not(ead:did) and not(self::ead:did)]"/>
                                </div>
                                <div id="collapse1" class="panel-collapse collapse in">
                                    <xsl:apply-templates select="child::*[ead:did and not(self::ead:did)]"/>
                                </div>
                            </xsl:otherwise>
                        </xsl:choose>
                    </div>
                    <p>END HEADER</p>
                </xsl:when>
                <!--Items/Files with multiple formats linked using parent and id attributes -->
                <xsl:when test="count(child::*/ead:container/@id) &gt; 1">
                    <p>START ITEMS/FILES WITH FORMATS</p>
                    <tr class="{$colorClass}">
                        <td colspan="5">
                            <xsl:apply-templates select="ead:did" mode="dsc"/> 
                            <br class="clear"/>
                            <table class="parentContainers">
                                <xsl:for-each select="child::*/ead:container[@label]">
                                    <xsl:variable name="id" select="@id"/>
                                    <xsl:variable name="container" select="count(../ead:container[@parent = $id] | ../ead:container[@id = $id])"/>
                                    <tr class="containerTypes">
                                        <td>&#160;</td>
                                        <td>
                                            <xsl:choose>
                                                <xsl:when test="$container = ''"><xsl:attribute name="colspan">4</xsl:attribute></xsl:when>
                                                <xsl:when test="$container = 1"><xsl:attribute name="colspan">4</xsl:attribute></xsl:when>
                                                <xsl:when test="$container = 2"><xsl:attribute name="colspan">3</xsl:attribute></xsl:when>
                                                <xsl:when test="$container = 3"><xsl:attribute name="colspan">2</xsl:attribute></xsl:when>
                                                <xsl:when test="$container = 4"/>
                                                <xsl:otherwise/>
                                            </xsl:choose>
                                            &#160;
                                        </td>
                                        <xsl:for-each select="../ead:container[@parent = $id] | ../ead:container[@id = $id]">
                                            <td><xsl:value-of select="@type"/></td>
                                        </xsl:for-each>
                                    </tr>
                                    <tr>
                                        <td>
                                            <xsl:value-of select="@label"/>
                                        </td>
                                        <td>
                                            <xsl:choose>
                                                <xsl:when test="$container = ''"><xsl:attribute name="colspan">4</xsl:attribute></xsl:when>
                                                <xsl:when test="$container = 1"><xsl:attribute name="colspan">4</xsl:attribute></xsl:when>
                                                <xsl:when test="$container = 2"><xsl:attribute name="colspan">3</xsl:attribute></xsl:when>
                                                <xsl:when test="$container = 3"><xsl:attribute name="colspan">2</xsl:attribute></xsl:when>
                                                <xsl:when test="$container = 4"/>
                                                <xsl:otherwise/>
                                            </xsl:choose>
                                            &#160;
                                        </td>
                                        <xsl:for-each select="../ead:container[@parent = $id] | ../ead:container[@id = $id]">
                                            <td>
                                               <xsl:apply-templates/>
                                            </td>
                                        </xsl:for-each>
                                    </tr>
                                </xsl:for-each>
                                <xsl:if test="descendant-or-self::ead:dao">
                                    <xsl:for-each select="descendant-or-self::ead:dao">
                                        <tr>
                                            <td>Digital Object</td>
                                            <td></td>
                                            <td colspan="4"><xsl:apply-templates select="."/></td>
                                        </tr>
                                    </xsl:for-each>
                                </xsl:if>
                            </table>
                            <br class="clear"/>
                            <xsl:apply-templates select="*[not(self::ead:did) and not(descendant-or-self::ead:dao) and
                                not(self::ead:c) and not(self::ead:c02) and not(self::ead:c03) and
                                not(self::ead:c04) and not(self::ead:c05) and not(self::ead:c06) and not(self::ead:c07)
                                and not(self::ead:c08) and not(self::ead:c09) and not(self::ead:c10) and not(self::ead:c11) and not(self::ead:c12)]"/>
                        </td>
                    </tr>
                    <p>END ITEMS/FILES WITH FORMATS</p>
                </xsl:when>
                    
                <!-- Items/Files--> 
                <xsl:when test="@level='file' or @level='item' or (@level='otherlevel'and child::ead:did/ead:container)">
                    <p>START ITEMS/FILES</p>
                      <!-- Variables to  for Conainer headings, used only if headings are different from preceding heading -->
                    <xsl:variable name="container" select="string(ead:did/ead:container[1]/@type)"/>
                    <xsl:variable name="container2" select="string(ead:did/ead:container[2]/@type)"/>
                    <xsl:variable name="container3" select="string(ead:did/ead:container[3]/@type)"/>
                    <xsl:variable name="container4" select="string(ead:did/ead:container[4]/@type)"/>
                    <!-- Counts contianers for current and preceding instances and if different inserts a heading -->
                    <xsl:variable name="containerCount" select="count(ead:did/ead:container)"/>
                    <xsl:variable name="sibContainerCount" select="count(preceding-sibling::*[1]/ead:did/ead:container)"/>
                    <!-- Variable estabilishes previouse container types for comparisson to current container. -->
                    <xsl:variable name="sibContainer" select="string(preceding-sibling::*[1]/ead:did/ead:container[1]/@type)"/>
                    <xsl:variable name="sibContainer2" select="string(preceding-sibling::*[1]/ead:did/ead:container[2]/@type)"/>
                    <xsl:variable name="sibContainer3" select="string(preceding-sibling::*[1]/ead:did/ead:container[3]/@type)"/>
                    <xsl:variable name="sibContainer4" select="string(preceding-sibling::*[1]/ead:did/ead:container[4]/@type)"/>
                    
         <!-- Tests to see if current container type is different from previous container type, 
             if it is a new row with container type headings is outout -->
                    <xsl:if test="$container != $sibContainer or $container2 != $sibContainer2 or $container3 != $sibContainer3 or $container4 != $sibContainer4 or$containerCount != $sibContainerCount">
                        <xsl:if test="ead:did/ead:container">
                            <tr>
                                <xsl:for-each select="ead:did/ead:container">    
                                    <td class="containerHeader">    
                                        <xsl:value-of select="@type"/>
                                    </td>    
                                </xsl:for-each>
                                <td class="title">
                                    <xsl:choose>                                
                                        <xsl:when test="count(ead:did[ead:container][1]/ead:container) &lt; 1">
                                            <xsl:attribute name="colspan">
                                                <xsl:text>5</xsl:text>
                                            </xsl:attribute>
                                        </xsl:when>
                                        <xsl:when test="count(ead:did[ead:container][1]/ead:container) = 1">
                                            <xsl:attribute name="colspan">
                                                <xsl:text>4</xsl:text>
                                            </xsl:attribute>
                                        </xsl:when>
                                        <xsl:when test="count(ead:did[ead:container][1]/ead:container) = 2">
                                            <xsl:attribute name="colspan">
                                                <xsl:text>3</xsl:text>
                                            </xsl:attribute>
                                        </xsl:when>
                                        <xsl:when test="count(ead:did[ead:container][1]/ead:container) = 3">
                                            <xsl:attribute name="colspan">
                                                <xsl:text>2</xsl:text>
                                            </xsl:attribute>
                                        </xsl:when>
                                        <xsl:otherwise/>
                                    </xsl:choose>    
                                    <xsl:text/>
                                </td>
                               
                            </tr>
                        </xsl:if> 
                  </xsl:if>
                    <tr class="{$colorClass}"> 
                        <!-- Containers -->    
                        <xsl:for-each select="ead:did/ead:container">    
                            <td class="container">    
                                <xsl:value-of select="."/>        
                            </td>    
                        </xsl:for-each>
                        <td class="{$clevelMargin}">
                            <xsl:choose>
                                <xsl:when test="count(ead:did/ead:container) &lt; 1">
                                    <xsl:attribute name="colspan">
                                        <xsl:text>5</xsl:text>
                                    </xsl:attribute>
                                </xsl:when>
                                <xsl:when test="count(ead:did/ead:container) = 1">
                                    <xsl:attribute name="colspan">
                                        <xsl:text>4</xsl:text>
                                    </xsl:attribute>
                                </xsl:when>
                                <xsl:when test="count(ead:did/ead:container) = 2">
                                    <xsl:attribute name="colspan">
                                        <xsl:text>3</xsl:text>
                                    </xsl:attribute>
                                </xsl:when>
                                <xsl:when test="count(ead:did/ead:container) = 3">
                                    <xsl:attribute name="colspan">
                                        <xsl:text>2</xsl:text>
                                    </xsl:attribute>
                                </xsl:when>
                                <xsl:otherwise/>
                            </xsl:choose>                            
                            <xsl:apply-templates select="ead:did" mode="dsc"/>  
                            <ul class="daolist">
                                <xsl:apply-templates select="*[not(self::ead:did) and 
                                    not(self::ead:c) and not(self::ead:c02) and not(self::ead:c03) and
                                    not(self::ead:c04) and not(self::ead:c05) and not(self::ead:c06) and not(self::ead:c07)
                                    and not(self::ead:c08) and not(self::ead:c09) and not(self::ead:c10) and not(self::ead:c11) and not(self::ead:c12)]">
                                    <xsl:sort select="@ns2:title"/>
                                </xsl:apply-templates>
                            </ul>
                        </td>
                    </tr>  
                <p>END ITEMS/FILES</p>
                </xsl:when>
                <xsl:otherwise>
                    <p>START OTHER</p>
                    <tr class="{$colorClass}"> 
                        <td class="{$clevelMargin}" colspan="5">
                            <xsl:apply-templates select="ead:did" mode="dsc"/>
                            <xsl:apply-templates select="*[not(self::ead:did) and 
                                not(self::ead:c) and not(self::ead:c02) and not(self::ead:c03) and
                                not(self::ead:c04) and not(self::ead:c05) and not(self::ead:c06) and not(self::ead:c07)
                                and not(self::ead:c08) and not(self::ead:c09) and not(self::ead:c10) and not(self::ead:c11) and not(self::ead:c12)]"/>  
                        </td>
                    </tr>
                <p>END OTHER</p>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>
 