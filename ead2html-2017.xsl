<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:ead="urn:isbn:1-931666-22-9"
    xmlns:ns2="http://www.w3.org/1999/xlink">

    <xsl:import href="include/site-head-include.xsl"/>
    <xsl:import href="include/site-masthead-include.xsl"/>
    <xsl:import href="include/site-footer-include.xsl"/>

    <!--
        *******************************************************************
        *                                                                 *
        * VERSION:          1.02                                          *
        *                                                                 *
        * AUTHOR:           Winona Salesky                                *
        *                   wsalesky@gmail.com                            *
        *                                                                 *
        *                                                                 *
        * ABOUT:           This file has been created for use with        *
        *                  the Archivists' Toolkit  July 30 2008.         *
        *                  this file calls lookupLists.xsl, which         *
        *                  should be located in the same folder.          *
        *                                                                 *
        * UPDATED          May 31, 2012                                   *
        *                  Fixed bug with multiple instance display       *
        * UPDATED          June 3, 2009                                   *
        *                  Added additional table cell to component       *
        *                  display to address bug ART-1833, also addressed* 
        *                  problematic container heading displays         *          
        *                                                                 *
        * UPDATED          September 24, 2009                             *
        *                  Added address to publication statement         *
        *                  March 23, 2009                                 *
        *                  Added revision description and date,           * 
        *                  and publication information                    *
        *                  March 12, 2009                                 *
        *                  Fixed character encoding issues                *
        *                  March 11, 2009                                 *
        *                  Added repository branding device to header     *
        *                  March 1, 2009                                  *
        *                  Changed bulk date display for unitdates        *
        *                  Feb. 6, 2009                                   *
        *                  Added roles to creator display in summary      * 
        *******************************************************************
    -->
    
    <xsl:output method="html" encoding="utf-8" indent="yes" />
    <xsl:strip-space elements="*"/>

    <xsl:variable name="full-title" select="concat(/ead:ead/ead:eadheader/ead:filedesc/ead:titlestmt/ead:titleproper,' ', /ead:ead/ead:eadheader/ead:filedesc/ead:titlestmt/ead:subtitle)"/>

    <!-- Creates the body of the finding aid.-->
    <xsl:template match="/">
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <html class="no-js" lang="en">
        <head>
            <meta charset="UTF-8" />
            <title><xsl:value-of select="$full-title"/></title>
            
            <xsl:call-template name="site-head-include"/>
            <xsl:call-template name="metadata"/>
            <xsl:call-template name="css"/>
        </head>

        <body>
            <xsl:call-template name="header"/>

            <div class="wrapper">
                <section class="container" id="main-content">
                    <!-- Main Title -->
                    <a name="top"/>
                    <h1 id="{generate-id(ead:filedesc/ead:titlestmt/ead:titleproper)}">
                        <xsl:copy-of select="$full-title"/>
                    </h1>

                    <!-- Digitiazation Status -->
                    <xsl:call-template name="digitized"/>

                    <!-- Contents -->
                    <div class="row"><div class="col-md12">
                        <!-- these two panels are open by default. 
                            TODO: Is there a reason these are in a "group"? Works w/o the group.
                         -->
                        <div class="panel-group" role="tablist" aria-multiselectable="true">
                            <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:did"/>

                            <!-- explicitly call material use template as it's not one XML element. -->
                            <xsl:call-template name="material-use"/>
                        </div>

                        <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:bioghist"/>
                        <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:scopecontent"/>
                        <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:arrangement"/>
                        <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:fileplan"/>                        
                        <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:relatedmaterial"/>
                        <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:separatedmaterial"/>
                        <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:daogrp"/>
                        <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:dao"/>
                        <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:controlaccess"/>
                        <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:otherfindaid"/>
                        <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:phystech"/>
                        <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:odd"/>
                        <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:bibliography"/>
                        <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:index"/>
                        <xsl:if test="/ead:ead/ead:archdesc/ead:dsc/child::*">
                            <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:dsc"/>    
                        </xsl:if>

                        <!--xsl:apply-templates select="/ead:ead/ead:eadheader/ead:filedesc/ead:publicationstmt"/ -->
                    </div></div>
                </section>
            </div>

            <xsl:call-template name="footer"/>
            </body>
        </html>
    </xsl:template>

    <!-- Dublin Core meta tags (also for use by web search engines for indexing). -->
    <xsl:template name="metadata">
        <meta name="dc.title" content="{$full-title}"/>
        <meta name="dc.author" content="{/ead:ead/ead:archdesc/ead:did/ead:origination}"/>
        <xsl:for-each select="/ead:ead/ead:archdesc/ead:controlaccess/descendant::*">
            <meta http-equiv="Content-Type" name="dc.subject" content="{.}"/>
        </xsl:for-each>
        <meta name="dc.type" content="text"/>
        <meta name="dc.format" content="manuscripts"/>
        <meta name="dc.format" content="finding aids"/>
    </xsl:template>

    <!-- CSS for styling HTML output. Place all CSS styles in this template.-->
    <xsl:template name="css">
        <link rel="stylesheet" type="text/css" href="https://draft-library.bowdoin.edu/arch/test/finding-aid.css" />
    </xsl:template>

    <!-- This template creates a customizable header  -->
    <xsl:template name="header">
        <xsl:call-template name="site-masthead-include"/>
    </xsl:template>

    <xsl:template name="digitized">
        <div class="row show-grid digitized">
            <div class="col-md-5">
                <div class="arrow_box">Digitized</div>
            </div>
            <div class="col-md-7">Some materials from this collection are available online.
                <a href="#" onclick="daoStart();">Start viewing now &#187;</a>
            </div>
        </div>
    </xsl:template>

    <!-- Template for a top-level "panel" of content -->
    <xsl:template name="panel">
        <xsl:param name="default-title" />
        <xsl:param name="title" />
        <xsl:param name="class" />
        <xsl:param name="expanded" select="'false'"/>
        <xsl:param name="content"/>

        <xsl:variable name="collapseId" select="generate-id(.)"/>
        <xsl:variable name="headingId" select="generate-id(title)"/>

        <div class="panel panel-default {$class}">
            <div id="{$headingId}" class="panel-heading" role="tab" >
                <h2 class="panel-title">
                    <a role="button" data-toggle="collapse" href="#{$collapseId}" aria-expanded="{$expanded}" aria-controls="{$collapseId}">
                        <xsl:choose>
                            <xsl:when test="$title"><xsl:apply-templates select="$title"/></xsl:when>
                            <xsl:otherwise><xsl:value-of select="$default-title" /></xsl:otherwise>
                        </xsl:choose>
                    </a>
                </h2>
            </div>

            <xsl:variable name="collapse-in">
                <xsl:if test="$expanded='true'">in</xsl:if>
            </xsl:variable>
            <div id="{$collapseId}" class="panel-collapse collapse {$collapse-in}" role="tabpanel" aria-labelledby="{$headingId}">
                <div class="panel-body">
                    <xsl:copy-of select="$content" />
                </div>
            </div>
        </div>
    </xsl:template> 

    <!-- Template for a table-like data element in a panel -->
    <xsl:template name="panel-data-row">
        <xsl:param name="title" />
        <xsl:param name="default-title" />
        <xsl:param name="class" />
        <xsl:param name="content"/>

        <!-- Choose title or default title -->
        <xsl:variable name="final_title">
            <xsl:choose>
                <xsl:when test="$title"><xsl:apply-templates select="$title"/></xsl:when>
                <xsl:otherwise><xsl:value-of select="$default-title"/></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <div class="row {$class}">
            <div class="col-md-3">
                <xsl:value-of select="$final_title" />
                <!-- Insert colon if title does not end with colon -->
                <xsl:if test="substring(., string-length($final_title), 1) != ':'">:</xsl:if>
            </div>
            <div class="col-md-9"><xsl:copy-of select="$content"/></div>
        </div>
    </xsl:template>

   <!-- Template for a sub-level "panel" of content -->
   <!-- TODO: Working... -->
    <xsl:template name="series">
        <xsl:param name="title" />
        <xsl:param name="default-title" />
        <xsl:param name="class" />
        <xsl:param name="expanded" select="'false'"/>
        <xsl:param name="content"/>

        <xsl:variable name="collapseId" select="generate-id(.)"/>
        <xsl:variable name="headingId" select="generate-id(title)"/>

        <div class="series">
            <!-- heading -->
            <h3 class="did-core" id="{$headingId}">
                <a href="#" aria-hidden="true" aria-expanded="false" data-toggle="collapse" data-target="#{$collapseId}" class="collapsed">
                    <xsl:choose>
                        <xsl:when test="$title"><xsl:copy-of select="$title"/></xsl:when>
                        <xsl:otherwise><xsl:value-of select="$default-title" /></xsl:otherwise>
                    </xsl:choose>
                </a>
            </h3>
            <!-- header description -->
            <div colspan="5" class="{$class} series-desc">
                <xsl:call-template name="anchor"/>
                <xsl:apply-templates select="child::*[not(ead:did) and not(self::ead:did)]"/>
            </div>
            <!-- items collapsable -->
            <xsl:variable name="collapse-in">
                <xsl:if test="$expanded='true'">in</xsl:if>
            </xsl:variable>
            <div id="{$collapseId}" class="panel-collapse collapse {$collapse-in}" aria-labelledby="{$headingId}">
                <!-- rows -->
                <xsl:copy-of select="$content" />
            </div>
        </div>
    </xsl:template>

    <!-- Template for a table-like data element in a series -->
    <xsl:template name="series-data-row">
        <xsl:param name="title" />
        <xsl:param name="default-title" />
        <xsl:param name="class" />
        <xsl:param name="content"/>

        <div class="row {$class}">
            <div class="col-md-10">
                <xsl:choose>
                    <xsl:when test="$title"><xsl:copy-of select="$title"/></xsl:when>
                    <xsl:otherwise><xsl:value-of select="$default-title"/></xsl:otherwise>
                </xsl:choose>
            </div>
            <div class="col-md-2">
                <xsl:copy-of select="$content"/>
            </div>
        </div>
    </xsl:template>

    <!-- This template creates a customizable footer  -->
    <xsl:template name="footer">
        <a href="#main-content" class="back-to-top">Top</a>

        <xsl:call-template name="site-footer-include"/>

        <script type="text/javascript" src="https://draft-library.bowdoin.edu/arch/libr/js/vendors/affix.js"></script>
        <script type="text/javascript" src="https://draft-library.bowdoin.edu/arch/libr/js/vendors/collapse.js"></script>
        <script type="text/javascript" src="https://draft-library.bowdoin.edu/arch/libr/js/vendors/transition.js"></script>
        <script type="text/javascript" src="https://draft-library.bowdoin.edu/arch/libr/js/vendors/stickyfill.min.js"></script>
        <script type="text/javascript" src="https://draft-library.bowdoin.edu/arch/test/finding-aid.js"></script>
    </xsl:template>

    <!-- Template for Summary Information. Broken out so we can specify the order of children -->
    <xsl:template match="ead:archdesc/ead:did">
        <xsl:call-template name="panel">
            <xsl:with-param name="title" select="ead:head"/>
            <xsl:with-param name="default-title">Summary Information</xsl:with-param>
            <xsl:with-param name="expanded">true</xsl:with-param>            
            <xsl:with-param name="class">summary</xsl:with-param>            
            <xsl:with-param name="content">
            <!-- Determines the order in wich elements from the archdesc did appear, 
                to change the order of appearance for the children of did
                by changing the order of the following statements. -->
                <xsl:apply-templates select="ead:unittitle"/>   
                <xsl:apply-templates select="ead:origination"/>
                <xsl:apply-templates select="ead:unitid"/>
                <xsl:apply-templates select="ead:unitdate"/>
                <xsl:apply-templates select="ead:physdesc"/>        
                <xsl:apply-templates select="ead:physloc"/>        
                <xsl:apply-templates select="ead:langmaterial"/>
                <xsl:apply-templates select="ead:repository"/>
                <xsl:apply-templates select="ead:materialspec"/>
                <xsl:apply-templates select="ead:container"/>
                <xsl:apply-templates select="ead:abstract"/> 
                <xsl:apply-templates select="ead:note"/>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <!-- Template calls and formats the children of archdesc/did 
            <langmaterial>
                <language langcode="eng"/>
            </langmaterial>
    -->
    <xsl:template match="ead:archdesc/ead:did/ead:repository | 
        ead:archdesc/ead:did/ead:unittitle | 
        ead:archdesc/ead:did/ead:unitid | 
        ead:archdesc/ead:did/ead:origination |
        ead:archdesc/ead:did/ead:unitdate | 
        ead:archdesc/ead:did/ead:physdesc | 
        ead:archdesc/ead:did/ead:physloc |
        ead:archdesc/ead:did/ead:abstract | 
        ead:archdesc/ead:did/ead:langmaterial | 
        ead:archdesc/ead:did/ead:materialspec | 
        ead:archdesc/ead:did/ead:container">
        <xsl:call-template name="panel-data-row">
            <xsl:with-param name="title" select="ead:head"/>
            <xsl:with-param name="default-title">
                <xsl:choose>
                    <xsl:when test="@label">
                        <xsl:value-of select="concat(translate( substring(@label, 1, 1 ),
                            'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' ), 
                            substring(@label, 2, string-length(@label )))" />
                        <xsl:if test="@type"> [<xsl:value-of select="@type"/>]</xsl:if>
                        <xsl:if test="self::ead:origination">
                            <xsl:choose>
                                <xsl:when test="ead:persname[@role != ''] and contains(ead:persname/@role,' (')">
                                    - <xsl:value-of select="substring-before(ead:persname/@role,' (')"/>
                                </xsl:when>
                                <xsl:when test="ead:persname[@role != '']">
                                    - <xsl:value-of select="ead:persname/@role"/>  
                                </xsl:when>
                                <xsl:otherwise/>
                            </xsl:choose>
                        </xsl:if>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:choose>
                            <xsl:when test="self::ead:repository">Repository</xsl:when>
                            <xsl:when test="self::ead:unittitle">Title</xsl:when>
                            <xsl:when test="self::ead:unitid">ID</xsl:when>
                            <xsl:when test="self::ead:unitdate">Date<xsl:if test="@type"> [<xsl:value-of select="@type"/>]</xsl:if></xsl:when>
                            <xsl:when test="self::ead:origination">
                                <xsl:choose>
                                    <xsl:when test="ead:persname[@role != ''] and contains(ead:persname/@role,' (')">
                                        Creator - <xsl:value-of select="substring-before(ead:persname/@role,' (')"/>
                                    </xsl:when>
                                    <xsl:when test="ead:persname[@role != '']">
                                        Creator - <xsl:value-of select="ead:persname/@role"/>  
                                    </xsl:when>
                                    <xsl:otherwise>
                                        Creator        
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:when test="self::ead:physdesc">Extent</xsl:when>
                            <xsl:when test="self::ead:abstract">Abstract</xsl:when>
                            <xsl:when test="self::ead:physloc">Location</xsl:when>
                            <xsl:when test="self::ead:langmaterial">Language</xsl:when>
                            <xsl:when test="self::ead:materialspec">Technical</xsl:when>
                            <xsl:when test="self::ead:container">Container</xsl:when>
                            <xsl:when test="self::ead:note">Note</xsl:when>
                        </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:with-param>
            <xsl:with-param name="content">
                <xsl:apply-templates />
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <!-- Template for Using These Materials
            This is a completely made up top-level panel 
            so it's coded explicitly to pull items from the whole XML.
     -->
    <xsl:template name="material-use">
        <xsl:call-template name="panel">
            <xsl:with-param name="default-title">Using These Materials</xsl:with-param>
            <xsl:with-param name="expanded">true</xsl:with-param>            
            <xsl:with-param name="class">matuse</xsl:with-param>            
            <xsl:with-param name="content">
                <!-- xsl:apply-templates select="/ead:ead/ead:eadheader/ead:filedesc/ead:publicationstmt"/ -->
                <xsl:apply-templates select="/ead:ead/ead:eadheader/ead:revisiondesc"/>
                <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:accessrestrict"/>
                <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:userestrict"/>
                <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:custodhist"/>
                <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:accruals"/>
                <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:acqinfo"/>
                <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:processinfo"/>
                <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:appraisal"/>
                <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:altformavail"/>
                <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:originalsloc"/>
                <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:prefercite"/>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <!-- Preferred citation needs <cite></cite> -->
    <xsl:template match="ead:prefercite">
        <xsl:call-template name="panel-data-row">
            <xsl:with-param name="title" select="ead:head"/>
            <xsl:with-param name="default-title">Preferred Citation</xsl:with-param>
            <xsl:with-param name="content">
                <cite><xsl:apply-templates select="child::*[not(name()='head')]"/></cite>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <!-- Template calls and formats all other children of archdesc many of 
        these elements are repeatable within the ead:dsc section as well.-->
    <xsl:template match="ead:revisiondesc |
        ead:accessrestrict | 
        ead:userestrict  | 
        ead:custodhist | 
        ead:accruals | 
        ead:acqinfo | 
        ead:processinfo |
        ead:appraisal | 
        ead:altformavail | 
        ead:originalsloc">
        <xsl:call-template name="panel-data-row">
            <xsl:with-param name="title" select="ead:head"/>
            <xsl:with-param name="default-title">
                <xsl:choose>
                    <xsl:when test="self::ead:accessrestrict">Restrictions on Access</xsl:when>
                    <xsl:when test="self::ead:userestrict">Restrictions on Use</xsl:when>
                    <xsl:when test="self::ead:custodhist">Custodial History</xsl:when>
                    <xsl:when test="self::ead:accruals">Accruals</xsl:when>
                    <xsl:when test="self::ead:acqinfo">Acquisition Information</xsl:when>
                    <xsl:when test="self::ead:processinfo">Processing Information</xsl:when>
                    <xsl:when test="self::ead:appraisal">Appraisal</xsl:when>                     
                    <xsl:when test="self::ead:altformavail">Alternative Form Available</xsl:when>
                    <xsl:when test="self::ead:originalsloc">Original Location</xsl:when>
                    <xsl:when test="self::ead:separatedmaterial">Separated Material</xsl:when>
                </xsl:choose>
            </xsl:with-param>
            <xsl:with-param name="content">
                <xsl:apply-templates select="ead:*[not(name()='head')]"/>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <!-- Template calls and formats all other children of archdesc many of 
        these elements are repeatable within the ead:dsc section as well.-->
    <xsl:template match="ead:bibliography | 
        ead:scopecontent |
        ead:bioghist |
        ead:odd | 
        ead:arrangement  | 
        ead:fileplan | 
        ead:otherfindaid | 
        ead:phystech | 
        ead:relatedmaterial |
        ead:separatedmaterial">
        
        <xsl:variable name="panel-title">
            <xsl:choose>
                <xsl:when test="self::ead:bibliography">Bibliography</xsl:when>
                <xsl:when test="self::ead:odd">Other Descriptive Data</xsl:when>
                <xsl:when test="self::ead:accruals">Accruals</xsl:when>
                <xsl:when test="self::ead:arrangement">Arrangement</xsl:when>
                <xsl:when test="self::ead:bioghist">Biography/History</xsl:when>
                <xsl:when test="self::ead:accessrestrict">Restrictions on Access</xsl:when>
                <xsl:when test="self::ead:userestrict">Restrictions on Use</xsl:when>
                <xsl:when test="self::ead:custodhist">Custodial History</xsl:when>
                <xsl:when test="self::ead:altformavail">Alternative Form Available</xsl:when>
                <xsl:when test="self::ead:originalsloc">Original Location</xsl:when>
                <xsl:when test="self::ead:fileplan">File Plan</xsl:when>
                <xsl:when test="self::ead:acqinfo">Acquisition Information</xsl:when>
                <xsl:when test="self::ead:otherfindaid">Other Finding Aids</xsl:when>
                <xsl:when test="self::ead:phystech">Physical Characteristics and Technical Requirements</xsl:when>
                <xsl:when test="self::ead:processinfo">Processing Information</xsl:when>
                <xsl:when test="self::ead:relatedmaterial">Related Material</xsl:when>
                <xsl:when test="self::ead:scopecontent">Scope and Content</xsl:when>
                <xsl:when test="self::ead:separatedmaterial">Separated Material</xsl:when>
                <xsl:when test="self::ead:appraisal">Appraisal</xsl:when>                        
            </xsl:choose>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="parent::ead:archdesc">
                <xsl:call-template name="panel">
                    <xsl:with-param name="title" select="ead:head"/>
                    <xsl:with-param name="default-title" select="$panel-title"/>
                    <xsl:with-param name="content">
                        <xsl:apply-templates select="ead:*[not(name()='head')]"/>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="panel-data-row">
                    <xsl:with-param name="title" select="ead:head"/>
                    <xsl:with-param name="default-title" select="$panel-title"/>
                    <xsl:with-param name="content">
                        <xsl:apply-templates select="ead:*[not(name()='head')]"/>
                </xsl:with-param>
            </xsl:call-template>

            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

   <!-- Formats controlled access terms -->
    <xsl:template match="ead:controlaccess">
        <xsl:call-template name="panel">
            <xsl:with-param name="title" select="ead:head"/>
            <xsl:with-param name="default-title">Controlled Access Headings</xsl:with-param>
            <xsl:with-param name="content">
                <xsl:if test="ead:corpname">
                    <xsl:call-template name="panel-data-row">
                        <xsl:with-param name="default-title">Corporate Name(s)</xsl:with-param>
                        <xsl:with-param name="content">
                            <ul>
                                <xsl:for-each select="ead:corpname">
                                    <li><xsl:apply-templates/></li>
                                </xsl:for-each>                        
                            </ul>
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:if>
                <xsl:if test="ead:famname">
                    <xsl:call-template name="panel-data-row">
                        <xsl:with-param name="default-title">Family Name(s)</xsl:with-param>
                        <xsl:with-param name="content">
                            <ul>
                                <xsl:for-each select="ead:famname">
                                    <li><xsl:apply-templates/></li>
                                </xsl:for-each>                        
                            </ul>
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:if>
                <xsl:if test="ead:function">
                      <xsl:call-template name="panel-data-row">
                        <xsl:with-param name="default-title">Function(s)</xsl:with-param>
                        <xsl:with-param name="content">
                            <ul>
                                <xsl:for-each select="ead:function">
                                    <li><xsl:apply-templates/></li>
                                </xsl:for-each>                        
                            </ul>
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:if>
                <xsl:if test="ead:genreform">
                     <xsl:call-template name="panel-data-row">
                        <xsl:with-param name="default-title">Genre(s)</xsl:with-param>
                        <xsl:with-param name="content">
                            <ul>
                                <xsl:for-each select="ead:genreform">
                                    <li><xsl:apply-templates/></li>
                                </xsl:for-each>                        
                            </ul>
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:if>
                <xsl:if test="ead:geogname">
                     <xsl:call-template name="panel-data-row">
                        <xsl:with-param name="default-title">Geographic Name(s)</xsl:with-param>
                        <xsl:with-param name="content">
                            <ul>
                                <xsl:for-each select="ead:geogname">
                                    <li><xsl:apply-templates/></li>
                                </xsl:for-each>                        
                            </ul>
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:if>
                <xsl:if test="ead:occupation">
                    <xsl:call-template name="panel-data-row">
                        <xsl:with-param name="default-title">Occupation(s)</xsl:with-param>
                        <xsl:with-param name="content">
                            <ul>
                                <xsl:for-each select="ead:occupation">
                                    <li><xsl:apply-templates/></li>
                                </xsl:for-each>                        
                            </ul>
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:if>
                <xsl:if test="ead:persname">
                    <xsl:call-template name="panel-data-row">
                        <xsl:with-param name="default-title">Personal Name(s)</xsl:with-param>
                        <xsl:with-param name="content">
                            <ul>
                                <xsl:for-each select="ead:persname">
                                    <li><xsl:apply-templates/></li>
                                </xsl:for-each>                        
                            </ul>
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:if>
                <xsl:if test="ead:subject">
                    <xsl:call-template name="panel-data-row">
                        <xsl:with-param name="default-title">Subject(s)</xsl:with-param>
                        <xsl:with-param name="content">
                            <ul>
                                <xsl:for-each select="ead:subject">
                                    <li><xsl:apply-templates/></li>
                                </xsl:for-each>                        
                            </ul>
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:if>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="ead:language">
        <xsl:choose>
            <xsl:when test="@langcode = 'eng'">English</xsl:when>
            <xsl:when test="@langcode = 'mul'">Multiple</xsl:when>
            <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- *** Begin templates for Container List *** -->
    <xsl:template match="ead:archdesc/ead:dsc">
        <xsl:call-template name="panel">
            <xsl:with-param name="title" select="ead:head"/>
            <xsl:with-param name="default-title">Collection Inventory</xsl:with-param>
            <xsl:with-param name="content">
                <span id="all-series"/>
                <div class="containerList" id="accordian">
                    <!-- Call children of dsc -->
                    <xsl:apply-templates select="*[not(self::ead:head)]"/>            
                </div>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="ead:c01">
        <xsl:call-template name="series">
            <xsl:with-param name="title">
                <xsl:apply-templates select="ead:did" mode="dsc"/>
            </xsl:with-param>
            <xsl:with-param name="default-title">Series</xsl:with-param>
            <xsl:with-param name="class">c01</xsl:with-param>
            <xsl:with-param name="content">
                <!-- apply all c02's as the content -->
                <xsl:apply-templates select="child::*[ead:did]" />
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="ead:c02">
        <xsl:apply-templates mode="series-row"/>
    </xsl:template>

    <xsl:template match="ead:did" mode="series-row">
        <!--
        <xsl:call-template name="series-data-row">
            <xsl:with-param name="title">
                <xsl:apply-templates select="." mode="dsc"/>
            </xsl:with-param>
            <xsl:with-param name="default-title">Series</xsl:with-param>
            <xsl:with-param name="class">c02 bucket</xsl:with-param>
            <xsl:with-param name="content">
                <xsl:for-each select="ead:container">                    
                    <span>
                        <xsl:value-of select="@type" />&#160;<xsl:value-of select="node()" />
                    </span>
                </xsl:for-each>
            </xsl:with-param>
        </xsl:call-template>
        -->
        <div class="row c02">
            <div class="col-md-10">
                <xsl:apply-templates select="." mode="dsc"/>
            </div>
            <div class="bucket col-md-2">
                <xsl:for-each select="ead:container">                    
                    <span>
                        <xsl:value-of select="@type" />&#160;<xsl:value-of select="node()" />
                        <!-- xsl:value-of disable-output-escaping="yes" select="'&lt;br /&gt;'"/-->
                    </span>
                </xsl:for-each>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="br"><br /></xsl:template>  
<!-- *** TODO: Not Modified (yet) *** -->
    <xsl:template match="ead:filedesc/ead:titlestmt/ead:titleproper">
        <xsl:choose>
            <xsl:when test="@type = 'filing'">
                <xsl:choose>
                    <xsl:when test="count(parent::*/ead:titleproper) &gt; 1"/>
                    <xsl:otherwise>
                        <xsl:value-of select="/ead:ead/ead:archdesc/ead:did/ead:unittitle"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="ead:filedesc/ead:titlestmt"><br/><xsl:apply-templates/></xsl:template>

    <!-- Templates for publication information  -->
    <xsl:template match="/ead:ead/ead:eadheader/ead:filedesc/ead:publicationstmt">
        <h4>Publication Information</h4>
        <p><xsl:apply-templates select="ead:publisher"/>
            <xsl:if test="ead:date">&#160;<xsl:apply-templates select="ead:date"/></xsl:if>
        </p>
        <xsl:if test="ead:address">
            <xsl:apply-templates select="ead:address"/>
        </xsl:if>
    </xsl:template>
    <xsl:template match="ead:address">
        <p>
            <xsl:for-each select="ead:addressline"><xsl:apply-templates select="."/><br/></xsl:for-each>
        </p>
    </xsl:template>
    <!-- Templates for revision description  -->
    <xsl:template match="/ead:ead/ead:eadheader/ead:revisiondesc">
        <h4>Revision Description</h4>
        <p><xsl:if test="ead:change/ead:item"><xsl:apply-templates select="ead:change/ead:item"/></xsl:if><xsl:if test="ead:change/ead:date">&#160;<xsl:apply-templates select="ead:change/ead:date"/></xsl:if></p>        
    </xsl:template>
    
 
    <!-- Formats index and child elements, groups indexentry elements by type (i.e. corpname, subject...)-->
    <xsl:template match="ead:index">
       <xsl:choose>
           <xsl:when test="ead:head"/>
           <xsl:otherwise>
               <xsl:choose>
                   <xsl:when test="parent::ead:archdesc">
                       <h3><xsl:call-template name="anchor"/>Index</h3>
                   </xsl:when>
                   <xsl:otherwise>
                       <h4><xsl:call-template name="anchor"/>Index</h4>
                   </xsl:otherwise>
               </xsl:choose>    
           </xsl:otherwise>
       </xsl:choose>
       <xsl:apply-templates select="child::*[not(self::ead:indexentry)]"/>
                <xsl:if test="ead:indexentry/ead:corpname">
                    <h4>Corporate Name(s)</h4>
                    <ul>
                        <xsl:for-each select="ead:indexentry/ead:corpname">
                            <xsl:sort/>
                            <li><xsl:apply-templates select="."/>: &#160;<xsl:apply-templates select="following-sibling::*"/></li>
                        </xsl:for-each>
                     </ul>   
                </xsl:if>
                <xsl:if test="ead:indexentry/ead:famname">
                    <h4>Family Name(s)</h4>
                    <ul>
                        <xsl:for-each select="ead:indexentry/ead:famname">
                            <xsl:sort/>
                            <li><xsl:apply-templates select="."/>: &#160;<xsl:apply-templates select="following-sibling::*"/></li>
                        </xsl:for-each>
                    </ul>    
                </xsl:if>      
                <xsl:if test="ead:indexentry/ead:function">
                    <h4>Function(s)</h4>
                    <ul>
                        <xsl:for-each select="ead:indexentry/ead:function">
                            <xsl:sort/>
                            <li><xsl:apply-templates select="."/>: &#160;<xsl:apply-templates select="following-sibling::*"/></li>
                        </xsl:for-each>
                    </ul>
                </xsl:if>
                <xsl:if test="ead:indexentry/ead:genreform">
                    <h4>Genre(s)</h4> 
                    <ul>
                        <xsl:for-each select="ead:indexentry/ead:genreform">
                            <xsl:sort/>
                            <li><xsl:apply-templates select="."/>: &#160;<xsl:apply-templates select="following-sibling::*"/></li>
                        </xsl:for-each>           
                    </ul>
                </xsl:if>
                <xsl:if test="ead:indexentry/ead:geogname">
                    <h4>Geographic Name(s)</h4>
                    <ul>
                        <xsl:for-each select="ead:indexentry/ead:geogname">
                            <xsl:sort/>
                            <li><xsl:apply-templates select="."/>: &#160;<xsl:apply-templates select="following-sibling::*"/></li>
                        </xsl:for-each>
                    </ul>                    
                </xsl:if>
                <xsl:if test="ead:indexentry/ead:name">
                    <h4>Name(s)</h4>
                    <ul>
                        <xsl:for-each select="ead:indexentry/ead:name">
                            <xsl:sort/>
                            <li><xsl:apply-templates select="."/>: &#160;<xsl:apply-templates select="following-sibling::*"/></li>
                        </xsl:for-each>
                    </ul>    
                </xsl:if>
                <xsl:if test="ead:indexentry/ead:occupation">
                    <h4>Occupation(s)</h4> 
                    <ul>
                        <xsl:for-each select="ead:indexentry/ead:occupation">
                            <xsl:sort/>
                            <li><xsl:apply-templates select="."/>: &#160;<xsl:apply-templates select="following-sibling::*"/></li>
                        </xsl:for-each>
                    </ul>
                </xsl:if>
                <xsl:if test="ead:indexentry/ead:persname">
                    <h4>Personal Name(s)</h4>
                    <ul>
                        <xsl:for-each select="ead:indexentry/ead:persname">
                            <xsl:sort/>
                            <li><xsl:apply-templates select="."/>: &#160;<xsl:apply-templates select="following-sibling::*"/></li>
                        </xsl:for-each>
                    </ul>
                </xsl:if>
                <xsl:if test="ead:indexentry/ead:subject">
                    <h4>Subject(s)</h4> 
                    <ul>
                        <xsl:for-each select="ead:indexentry/ead:subject">
                            <xsl:sort/>
                            <li><xsl:apply-templates select="."/>: &#160;<xsl:apply-templates select="following-sibling::*"/></li>
                        </xsl:for-each>
                    </ul>
                </xsl:if>
                <xsl:if test="ead:indexentry/ead:title">
                    <h4>Title(s)</h4>
                    <ul>
                        <xsl:for-each select="ead:indexentry/ead:title">
                            <xsl:sort/>
                            <li><xsl:apply-templates select="."/>: &#160;<xsl:apply-templates select="following-sibling::*"/></li>
                        </xsl:for-each>
                    </ul>
                </xsl:if>         
       <xsl:if test="parent::ead:archdesc">                        
        <!-- xsl:call-template name="returnTOC"/ -->
        </xsl:if>
   </xsl:template>
    <xsl:template match="ead:indexentry">
        <dl class="indexEntry">
            <dt><xsl:apply-templates select="child::*[1]"/></dt>
            <dd><xsl:apply-templates select="child::*[2]"/></dd>    
        </dl>
    </xsl:template>
    <xsl:template match="ead:ptrgrp">
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- Linking elements. -->
    <xsl:template match="ead:ptr">
        <xsl:choose>
            <xsl:when test="@target">
                <a href="#{@target}"><xsl:value-of select="@target"/></a>
                <xsl:if test="following-sibling::ead:ptr">, </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="ead:ref">
        <xsl:choose>
            <xsl:when test="@target">
                <a href="#{@target}">
                    <xsl:apply-templates/>
                </a>
                <xsl:if test="following-sibling::ead:ref">, </xsl:if>
            </xsl:when>
            <xsl:when test="@ns2:href">
                <a href="#{@ns2:href}">
                    <xsl:apply-templates/>
                </a>
                <xsl:if test="following-sibling::ead:ref">, </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>    
    <xsl:template match="ead:extptr">
        <xsl:choose>
            <xsl:when test="@href">
                <a href="{@href}"><xsl:value-of select="@title"/></a>
            </xsl:when>
            <xsl:when test="@ns2:href"><a href="{@ns2:href}"><xsl:value-of select="@title"/></a></xsl:when>
            <xsl:otherwise><xsl:value-of select="@title"/></xsl:otherwise>
        </xsl:choose> 
    </xsl:template>
    <xsl:template match="ead:extref">
        <xsl:choose>
            <xsl:when test="@href">
                <a href="{@href}"><xsl:value-of select="."/></a>
            </xsl:when>
            <xsl:when test="@ns2:href"><a href="{@ns2:href}"><xsl:value-of select="."/></a></xsl:when>
            <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
        </xsl:choose> 
    </xsl:template>
    
    <!--Creates a hidden anchor tag that allows navigation within the finding aid. 
    In this stylesheet only children of the archdesc and c0* itmes call this template. 
    It can be applied anywhere in the stylesheet as the id attribute is universal. -->
    <xsl:template match="@id">
        <xsl:attribute name="id"><xsl:value-of select="."/></xsl:attribute>
    </xsl:template>
    <xsl:template name="anchor">
        <xsl:choose>
            <xsl:when test="@id">
                <xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="id"><xsl:value-of select="generate-id(.)"/></xsl:attribute>
            </xsl:otherwise>
            </xsl:choose>
    </xsl:template>
    <xsl:template name="tocLinks">
        <xsl:choose>
            <xsl:when test="self::*/@id">
                <xsl:attribute name="href">#<xsl:value-of select="@id"/></xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="href">#<xsl:value-of select="generate-id(.)"/></xsl:attribute>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
 
    <!--Bibref, choose statement decides if the citation is inline, if there is a parent element
    or if it is its own line, typically when it is a child of the bibliography element.-->
    <xsl:template match="ead:bibref">
        <xsl:choose>
            <xsl:when test="parent::ead:p">
                <xsl:choose>
                    <xsl:when test="@ns2:href">
                        <a href="{@ns2:href}"><xsl:apply-templates/></a>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <p>
                    <xsl:choose>
                        <xsl:when test="@ns2:href">
                            <a href="{@ns2:href}"><xsl:apply-templates/></a>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates/>
                        </xsl:otherwise>
                    </xsl:choose>
                </p>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
   
    <!-- Applies a span style to address elements, currently addresses are displayed 
        as a block item, display can be changed to inline, by changing the CSS -->
    <xsl:template match="ead:address">
        <span class="address">
            <xsl:for-each select="child::*">
                <xsl:apply-templates/>
                <xsl:choose>
                    <xsl:when test="ead:lb"/>
                    <xsl:otherwise><br/></xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>            
        </span>    
    </xsl:template>
    
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

    <!-- Digital Archival Object -->
    <xsl:template match="ead:daogrp">
        <xsl:choose>
            <xsl:when test="parent::ead:archdesc">
                <h3><xsl:call-template name="anchor"/>
                    <xsl:choose>
                    <xsl:when test="@ns2:title">
                       <xsl:value-of select="@ns2:title"/>
                    </xsl:when>
                    <xsl:otherwise>
                        Digital Archival Object
                    </xsl:otherwise>
                    </xsl:choose>
                </h3>
            </xsl:when>
            <xsl:otherwise>
                <h4><xsl:call-template name="anchor"/>
                    <xsl:choose>
                    <xsl:when test="@ns2:title">
                       <xsl:value-of select="@ns2:title"/>
                    </xsl:when>
                    <xsl:otherwise>
                        Digital Archival Object
                    </xsl:otherwise>
                </xsl:choose>
                </h4>
            </xsl:otherwise>
        </xsl:choose>   
        <xsl:apply-templates/>
    </xsl:template>
    <!-- Custom DAO roles to display with "listen/watch/view ..." title -->
    <xsl:template match="ead:dao">
        <xsl:if test="child::*">
            <xsl:apply-templates/>
        </xsl:if>
        <!-- start the link 
             output verb appropriate to the media; view/watch/listen
             output the object (DAO) title if not the same as the container (DID)
             output the link postfix and closing 
          -->
        <li class="dao">
            <a class="{@ns2:role}" href="{@ns2:href}" target="_blank">
                <xsl:choose>
                    <xsl:when test="starts-with(@ns2:role, 'Audio-')">Listen </xsl:when>
                    <xsl:when test="starts-with(@ns2:role, 'Video-')">Watch </xsl:when>
                    <xsl:otherwise>View </xsl:otherwise>
                </xsl:choose>
                <xsl:if test="../ead:did/ead:unittitle != @ns2:title">
                    <xsl:value-of select="@ns2:title"/>
                </xsl:if> online</a>
        </li>
    </xsl:template>
    <xsl:template match="ead:daodesc">
        <!-- Don't show daodesc -->
    </xsl:template>
    <xsl:template match="ead:daoloc">
        <a href="{@ns2:href}">
            <xsl:value-of select="@ns2:title"/>
        </a>
    </xsl:template>
    
    <!--Formats a simple table. The width of each column is defined by the colwidth attribute in a colspec element.-->
    <xsl:template match="ead:table">
        <xsl:for-each select="tgroup">
            <table>
                <tr>
                    <xsl:for-each select="ead:colspec">
                        <td width="{@colwidth}"/>
                    </xsl:for-each>
                </tr>
                <xsl:for-each select="ead:thead">
                    <xsl:for-each select="ead:row">
                        <tr>
                            <xsl:for-each select="ead:entry">
                                <td valign="top">
                                    <strong>
                                        <xsl:value-of select="."/>
                                    </strong>
                                </td>
                            </xsl:for-each>
                        </tr>
                    </xsl:for-each>
                </xsl:for-each>
                <xsl:for-each select="ead:tbody">
                    <xsl:for-each select="ead:row">
                        <tr>
                            <xsl:for-each select="ead:entry">
                                <td valign="top">
                                    <xsl:value-of select="."/>
                                </td>
                            </xsl:for-each>
                        </tr>
                    </xsl:for-each>
                </xsl:for-each>
            </table>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="ead:unitdate">
        <xsl:if test="preceding-sibling::*">&#160;</xsl:if>
        <xsl:choose>
            <xsl:when test="@type = 'bulk'">
                (<xsl:apply-templates/>)                            
            </xsl:when>
            <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="ead:date">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="ead:unittitle">
        <xsl:choose>
            <xsl:when test="child::ead:unitdate[@type='bulk']">
                <xsl:apply-templates select="node()[not(self::ead:unitdate[@type='bulk'])]"/>
                <xsl:apply-templates select="ead:date[@type='bulk']"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- Following five templates output chronlist and children in a table -->
    <xsl:template match="ead:chronlist">
        <table class="chronlist">
            <xsl:apply-templates/>
        </table>
    </xsl:template>
    <xsl:template match="ead:chronlist/ead:listhead">
        <tr>
            <th>
                <xsl:apply-templates select="ead:head01"/>
            </th>
            <th>
                <xsl:apply-templates select="ead:head02"/>
            </th>
        </tr>
    </xsl:template>
    <xsl:template match="ead:chronlist/ead:head">
        <tr>
            <th colspan="2">
                <xsl:apply-templates/>
            </th>
        </tr>
    </xsl:template>
    <xsl:template match="ead:chronitem">
        <tr>
            <xsl:attribute name="class">
                <xsl:choose>
                    <xsl:when test="(position() mod 2 = 0)">odd</xsl:when>
                    <xsl:otherwise>even</xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <td><xsl:apply-templates select="ead:date"/></td>
            <td><xsl:apply-templates select="descendant::ead:event"/></td>
        </tr>
    </xsl:template>
    <xsl:template match="ead:event">
        <xsl:choose>
            <xsl:when test="following-sibling::*">
                <xsl:apply-templates/><br/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>

    <!-- Output for a variety of list types -->
    <xsl:template match="ead:list">
        <xsl:if test="ead:head"><h4><xsl:value-of select="ead:head"/></h4></xsl:if>
        <xsl:choose>
            <xsl:when test="descendant::ead:defitem">
                <dl>
                    <xsl:apply-templates select="ead:defitem"/>
                </dl>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="@type = 'ordered'">
                        <ol>
                            <xsl:attribute name="class">
                                <xsl:value-of select="@numeration"/>
                            </xsl:attribute>
                            <xsl:apply-templates/>
                        </ol>
                    </xsl:when>
                    <xsl:when test="@numeration">
                        <ol>
                            <xsl:attribute name="class">
                                <xsl:value-of select="@numeration"/>
                            </xsl:attribute>
                            <xsl:apply-templates/>
                        </ol>
                    </xsl:when>
                    <xsl:when test="@type='simple'">
                        <ul>
                            <xsl:attribute name="class">simple</xsl:attribute>
                            <xsl:apply-templates select="child::*[not(ead:head)]"/>
                        </ul>
                    </xsl:when>
                    <xsl:otherwise>
                        <ul>
                            <xsl:apply-templates/>
                        </ul>        
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="ead:list/ead:head"/>
    <xsl:template match="ead:list/ead:item">
        <li><xsl:apply-templates/></li>
    </xsl:template>
    <xsl:template match="ead:defitem">
        <dt><xsl:apply-templates select="ead:label"/></dt>
        <dd><xsl:apply-templates select="ead:item"/></dd>
    </xsl:template>
 
    <!-- Formats list as tabel if list has listhead element  -->         
    <xsl:template match="ead:list[child::ead:listhead]">
        <table>
            <tr>
                <th><xsl:value-of select="ead:listhead/ead:head01"/></th>
                <th><xsl:value-of select="ead:listhead/ead:head02"/></th>
            </tr>
            <xsl:for-each select="ead:defitem">
                <tr>
                    <td><xsl:apply-templates select="ead:label"/></td>
                    <td><xsl:apply-templates select="ead:item"/></td>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>

    <!-- Formats notestmt and notes -->
    <xsl:template match="ead:notestmt">
        <h4>Note</h4>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="ead:note">
         <xsl:choose>
             <xsl:when test="parent::ead:notestmt">
                 <xsl:apply-templates/>
             </xsl:when>
             <xsl:otherwise>
                 <xsl:choose>
                     <xsl:when test="@label"><h4><xsl:value-of select="@label"/></h4><xsl:apply-templates/></xsl:when>
                     <xsl:otherwise><h4>Note</h4><xsl:apply-templates/></xsl:otherwise>
                 </xsl:choose>
             </xsl:otherwise>
         </xsl:choose>
     </xsl:template>
    
    <!-- Child elements that should display as paragraphs-->
    <xsl:template match="ead:legalstatus">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    <!-- Puts a space between sibling elements -->
    <xsl:template match="child::*">
        <!-- xsl:if test="preceding-sibling::*">&#160;</xsl:if -->
        <xsl:apply-templates/>
    </xsl:template>
    <!-- Generic text display elements -->
    <xsl:template match="ead:p">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    <xsl:template match="ead:lb"><br/></xsl:template>
    <xsl:template match="ead:blockquote">
        <blockquote><xsl:apply-templates/></blockquote>
    </xsl:template>
    <xsl:template match="ead:emph"><em><xsl:apply-templates/></em></xsl:template>
    
    <!--Render elements -->
    <xsl:template match="*[@render = 'bold'] | *[@altrender = 'bold'] ">
        <xsl:if test="preceding-sibling::*"> &#160;</xsl:if><strong><xsl:apply-templates/></strong>
    </xsl:template>
    <xsl:template match="*[@render = 'bolddoublequote'] | *[@altrender = 'bolddoublequote']">
        <xsl:if test="preceding-sibling::*"> &#160;</xsl:if><strong>"<xsl:apply-templates/>"</strong>
    </xsl:template>
    <xsl:template match="*[@render = 'boldsinglequote'] | *[@altrender = 'boldsinglequote']">
        <xsl:if test="preceding-sibling::*"> &#160;</xsl:if><strong>'<xsl:apply-templates/>'</strong>
    </xsl:template>
    <xsl:template match="*[@render = 'bolditalic'] | *[@altrender = 'bolditalic']">
        <xsl:if test="preceding-sibling::*"> &#160;</xsl:if><strong><em><xsl:apply-templates/></em></strong>
    </xsl:template>
    <xsl:template match="*[@render = 'boldsmcaps'] | *[@altrender = 'boldsmcaps']">
        <xsl:if test="preceding-sibling::*"> &#160;</xsl:if><strong><span class="smcaps"><xsl:apply-templates/></span></strong>
    </xsl:template>
    <xsl:template match="*[@render = 'boldunderline'] | *[@altrender = 'boldunderline']">
        <xsl:if test="preceding-sibling::*"> &#160;</xsl:if><strong><span class="underline"><xsl:apply-templates/></span></strong>
    </xsl:template>
    <xsl:template match="*[@render = 'doublequote'] | *[@altrender = 'doublequote']">
        <xsl:if test="preceding-sibling::*"> &#160;</xsl:if>"<xsl:apply-templates/>"
    </xsl:template>
    <xsl:template match="*[@render = 'italic'] | *[@altrender = 'italic']">
        <xsl:if test="preceding-sibling::*"> &#160;</xsl:if><em><xsl:apply-templates/></em>
    </xsl:template>
    <xsl:template match="*[@render = 'singlequote'] | *[@altrender = 'singlequote']">
        <xsl:if test="preceding-sibling::*"> &#160;</xsl:if>'<xsl:apply-templates/>'
    </xsl:template>
    <xsl:template match="*[@render = 'smcaps'] | *[@altrender = 'smcaps']">
        <xsl:if test="preceding-sibling::*"> &#160;</xsl:if><span class="smcaps"><xsl:apply-templates/></span>
    </xsl:template>
    <xsl:template match="*[@render = 'sub'] | *[@altrender = 'sub']">
        <xsl:if test="preceding-sibling::*"> &#160;</xsl:if><sub><xsl:apply-templates/></sub>
    </xsl:template>
    <xsl:template match="*[@render = 'super'] | *[@altrender = 'super']">
        <xsl:if test="preceding-sibling::*"> &#160;</xsl:if><sup><xsl:apply-templates/></sup>
    </xsl:template>
    <xsl:template match="*[@render = 'underline'] | *[@altrender = 'underline']">
        <xsl:if test="preceding-sibling::*"> &#160;</xsl:if><span class="underline"><xsl:apply-templates/></span>
    </xsl:template>
    <!-- 
        <value>nonproport</value>        
    -->

    <!--This section of the stylesheet creates a div for each c01 or c 
        It then recursively processes each child component of the c01 by 
        calling the clevel template.
        Edited 5/31/12: Added parameter to indicate clevel margin, parameter is called by clevelMargin variable
    -->
    <xsl:template match="ead:c">
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
    <xsl:template match="ead:c01x">
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
 
    <xsl:template match="ead:did" mode="dsc">
        <xsl:choose>
            <xsl:when test="../@level='subcollection' or ../@level='subgrp' or ../@level='series' 
                or ../@level='subseries'or ../@level='collection'or ../@level='fonds' or 
                ../@level='recordgrp' or ../@level='subfonds'">    
                <xsl:call-template name="component-did-core"/>
            </xsl:when>
            <!--Otherwise render the text in its normal font.-->
            <xsl:otherwise>
                <p><xsl:call-template name="component-did-core"/></p>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="component-did-core">
        <!--Inserts unitid and a space if it exists in the markup.-->
        <xsl:if test="ead:unitid">
            <xsl:apply-templates select="ead:unitid"/>:
            <xsl:text>&#160;</xsl:text>
        </xsl:if> 
        <!--Inserts origination and a space if it exists in the markup.-->
        <xsl:if test="ead:origination">
            <xsl:apply-templates select="ead:origination"/>
            <!--xsl:text>&#160;</xsl:text-->
        </xsl:if>
        <!--This choose statement selects between cases where unitdate is a child of unittitle and where it is a separate child of did.-->
        <xsl:choose>
            <!--This code processes the elements when unitdate is a child of unittitle.-->
            <xsl:when test="ead:unittitle/ead:unitdate">
                <xsl:apply-templates select="ead:unittitle"/>
            </xsl:when>
            <!--This code process the elements when unitdate is not a child of untititle-->
            <xsl:otherwise>
                <xsl:apply-templates select="ead:unittitle"/>
                <!--xsl:text>&#160;</xsl:text-->
                <xsl:for-each select="ead:unitdate[not(self::ead:unitdate[@type='bulk'])]">
                    <xsl:apply-templates/>
                    <!--xsl:text>&#160;</xsl:text-->
                </xsl:for-each>
                <xsl:for-each select="ead:unitdate[@type = 'bulk']">
                    (<xsl:apply-templates/>)
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="ead:physdesc">
            <!--xsl:text>&#160;</xsl:text -->
            <xsl:apply-templates select="ead:physdesc"/>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>
