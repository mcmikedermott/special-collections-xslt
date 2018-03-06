<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:ead="urn:isbn:1-931666-22-9"
    xmlns:ns2="http://www.w3.org/1999/xlink">

	<!-- This style sheet is ONLY FOR DEVELOPMENT. Not for production -->

	<xsl:import href="ead2html-2018.xsl"/>

	<!-- 
		That which is named last wins.
		These being included here overrides the ones defined in the
		base XSL and includes local copies rather than server-side include
		versions. This way, I can see what they should look like in a 
		development enviromnet.
	-->
	<xsl:import href="include/site-head-include.xsl"/>
	<xsl:import href="include/site-masthead-include.xsl"/>
	<xsl:import href="include/site-footer-include.xsl"/>

</xsl:stylesheet>