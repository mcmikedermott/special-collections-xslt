<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:ead="urn:isbn:1-931666-22-9"
    xmlns:ns2="http://www.w3.org/1999/xlink">

<xsl:template name="site-head-include">

<!-- Google Tag Manager -->
<script><![CDATA[(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-TFZ63KZ');]]></script>
<!-- End Google Tag Manager -->

<meta charset="UTF-8" />
<meta content="IE=edge" http-equiv="X-UA-Compatible" />
<meta content="width=device-width,user-scalable=YES,initial-scale=1" name="viewport" />
<script><![CDATA[ //load Caslon typeface
  (function(d) {
    var config = {
      kitId: 'ser3qmw',
      scriptTimeout: 3000,
      async: true
    },
    h=d.documentElement,t=setTimeout(function(){h.className=h.className.replace(/\bwf-loading\b/g,"")+" wf-inactive";},config.scriptTimeout),tk=d.createElement("script"),f=false,s=d.getElementsByTagName("script")[0],a;h.className+=" wf-loading";tk.src='https://use.typekit.net/'+config.kitId+'.js';tk.async=true;tk.onload=tk.onreadystatechange=function(){a=this.readyState;if(f||a&&a!="complete"&&a!="loaded")return;f=true;clearTimeout(t);try{Typekit.load(config)}catch(e){}};s.parentNode.insertBefore(tk,s)
  })(document);
]]></script>
<link rel="icon" type="image/png" href="https:/draft-library.bowdoin.edu/images/favicon.png" sizes="32x32"/>
<link rel="apple-touch-icon-precomposed" href="https://draft-library.bowdoin.edu/images/apple-touch-icon-precomposed-120x120.png" sizes="120x120"/>
<link rel="apple-touch-icon-precomposed" href="https://draft-library.bowdoin.edu/images/apple-touch-icon-precomposed-144x144.png" sizes="144x144"/>
<link rel="apple-touch-icon-precomposed" href="https://draft-library.bowdoin.edu/images/apple-touch-icon-precomposed.png"/>
<link rel="apple-touch-icon-precomposed" href="https://draft-library.bowdoin.edu/images/apple-touch-icon-precomposed-114x114.png" sizes="114x114"/>
<link rel="apple-touch-icon-precomposed" href="https://draft-library.bowdoin.edu/images/apple-touch-icon-precomposed-72x72.png" sizes="72x72"/>
<script src="https://draft-library.bowdoin.edu/libr/sdks/jquery/1.11/jquery.min.js" type="text/javascript"></script>
<link rel="stylesheet" href="https://draft-library.bowdoin.edu/arch/libr/css/normalize.css"/>
<link rel="stylesheet" href="https://draft-library.bowdoin.edu/arch/libr/css/main.css"/>
<link rel="stylesheet" href="https://draft-library.bowdoin.edu/arch/libr/css/oth.css"/>
<!--<link rel="stylesheet" href="fonts/font-awesome.css"/>-->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"/>
<!--browser feature detection -->
<script src="https://draft-library.bowdoin.edu/arch/libr/js/vendors/modernizr-custom.js"></script>
<!--Bootstrap tabs -->
<script src="https://draft-library.bowdoin.edu/arch/libr/js/vendors/tab.js" type="text/javascript"></script>

<!--polyfills for min/max-width and emulating CSS3 pseudo-classes and attribute selectors -->
<!--[if lte IE 8]>
<script src="/arch/libr/js/vendors/respond.min.js"></script>
<script src="/arch/libr/js/vendors/selectivizr-min.js"></script>
<![endif]-->
</xsl:template>
</xsl:stylesheet>
