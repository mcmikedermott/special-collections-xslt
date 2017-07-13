<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:ead="urn:isbn:1-931666-22-9"
    xmlns:ns2="http://www.w3.org/1999/xlink">

<xsl:template name="site-masthead-include">
<!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-TFZ63KZ"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->

<header class="clearfix">
    <div id="skip2main">
        <a href="#main-content">Skip to main content</a>
    </div>
    <div class="wrapper wrapper-branding">
        <div class="container">
            <a href="http://www.bowdoin.edu">
                <img alt="Bowdoin College" height="45" longdesc="www.bowdoin.edu" src="https://draft-library.bowdoin.edu/images/bowdoin-college.gif" width="137" />
            </a>
        </div>
    </div>
    <div class="wrapper wrapper-name">
        <div class="container">
            <div id="site-name">
                <a href="/arch/"><span>George J. Mitchell Department of</span>Special Collections &amp; Archives</a>
                <span id="da"><a href="/">Hawthorne-Longfellow Library</a></span>
            </div>
            <div class="wrapper-search wrapper-sticky">
                <div id="site-search">
                    <div class="tab-content">
    <div role="tabpanel" class="tab-pane active" id="archives-manuscripts">
        <form action="https://search.bowdoin.edu/search" method="get" name="s">
            <div class="form-item">
                <input class="search" maxlength="255" name="q" placeholder="Search Archives &amp; Manuscripts" size="60" type="text" id="arch-man-search-field" />
                <button type="submit" class="search-button">
                    <span class="fa-search fa">
                        <span class="hidden">Search</span>
                    </span>
                </button>
                <input name="site" type="hidden" value="lib-arch-collections" />
                <input name="client" type="hidden" value="bowdoin-www-root" />
                <input name="proxystylesheet" type="hidden" value="bowdoin-www-root" />
                <input name="output" type="hidden" value="xml_no_dtd" />
                <input name="filter" type="hidden" value="0" />
            </div>
        </form>
    </div>
    <div role="tabpanel" class="tab-pane" id="rare-books">
        <form action="https://cbbcat.net/search/" class="search" method="get" name="search">
            <div class="form-item">
                <input id="iiiFormHandle_1" type="hidden" />
                <input name="searchtype" type="hidden" value="X" />
                <input name="searchscope" type="hidden" value="5" />
                <input id="SORT" name="SORT" type="hidden" value="D" />
                <input  class="search" maxlength="255" name="searcharg" placeholder="Search Rare Books" size="60" type="text" id="rare-search-field" />
                <button type="submit" class="search-button">
                    <span class="fa-search fa">
                        <span class="hidden">Search</span>
                    </span>
                </button>
            </div>
        </form>
    </div>
    <div role="tabpanel" class="tab-pane" id="images">
        <form action="/cgi-bin/arch-images" id="search-form" method="get" name="search-form">
            <div class="form-item">
                <input  class="search" maxlength="255" name="search" placeholder="Search Images" size="60" type="text" id="images-search-field" />
                <input name="collection" type="hidden" value="1" />
                <button type="submit" class="search-button">
                    <span class="fa-search fa">
                        <span class="hidden">Search</span>
                    </span>
                </button>
            </div>
        </form>
    </div>
    <div role="tabpanel" class="tab-pane" id="website">
        <form action="https://search.bowdoin.edu/search" method="get" name="s">
            <div class="form-item">
                <input  class="search" maxlength="255" name="q" placeholder="Search Our Website" size="60" type="text" id="website-search-field" />
                <button type="submit" class="search-button">
                    <span class="fa-search fa">
                        <span class="hidden">Search</span>
                    </span>
                </button>
                <input name="site" type="hidden" value="library-archives" />
                <input name="client" type="hidden" value="bowdoin-www-root" />
                <input name="proxystylesheet" type="hidden" value="bowdoin-www-root" />
                <input name="output" type="hidden" value="xml_no_dtd" />
            </div>
        </form>
    </div>
</div>
<ul class="nav nav-tabs clearfix" role="tablist" id="site-search-tabs">
    <li role="presentation" class="active">
        <a href="#archives-manuscripts" aria-controls="archives-manuscripts" role="tab" data-toggle="tab">Archives &amp; Manuscripts
            <span class="fa fa-caret-down"></span>
        </a>
    </li>
    <li role="presentation">
        <a href="#rare-books" aria-controls="rare-books" role="tab" data-toggle="tab">Rare Books
            <span class="fa fa-caret-down"></span>
        </a>
    </li>
    <li role="presentation">
        <a href="#images" aria-controls="images" role="tab" data-toggle="tab">Images
            <span class="fa fa-caret-down"></span>
        </a>
    </li>
    <li role="presentation">
        <a href="#website" aria-controls="website" role="tab" data-toggle="tab">Our Website
            <span class="fa fa-caret-down"></span>
        </a>
    </li>
</ul>

                </div>
                <a aria-label="Toggle Menu" href="#" id="menu-icon"><span id="text">Menu</span>
                        <i class="fa fa-bars" aria-hidden="true"></i>
                </a>
                <div id="site-nav">
                    <nav aria-label="primary">
    <div id="one">
        <h4><a href="/arch/collections/">Collections</a></h4>
        <ul class="menu">
            <li>
                <a href="/arch/collections/rare-books.shtml">Rare Books</a>
            </li>
            <li>
                <a href="/arch/collections/manuscripts-by-creator.shtml">Manuscripts</a>
            </li>
            <li>
                <a href="/arch/collections/digital-collections-and-projects.shtml">Digital Collections &amp; Projects</a>
            </li>
            <li>
                <a href="/arch/college-history-and-archives/index.shtml">College Archives</a>
            </li>
            <li>
                <a href="/arch/collections/susan-dwight-bliss-room.shtml">Susan Dwight Bliss Room</a>
            </li>
            <li>
                <a href="http://www.bowdoin.edu/stowe-house/">Harriet's Writing Room<i class="fa fa-external-link" aria-hidden="true" title="external site"></i><span class="visuallyhidden">This link goes to an external site</span></a>
            </li>
        </ul>
    </div>
    <div id="two">
        <h4><a href="/arch/research-and-instructional-services/index.shtml">Research &amp; Instructional Services</a></h4>
        <ul class="menu">
            <li>
                <a href="/arch/research-and-instructional-services/starting-your-research.shtml">Starting Your Research</a>
            </li>
            <li>
                <a href="/arch/research-and-instructional-services/citing-our-materials.shtml">Citing Our Materials</a>
            </li>
            <li>
                <a href="/arch/about-us/policies.shtml#reproductions">Rights &amp; Reproductions</a>
            </li>
            <li>
                <a href="/arch/research-and-instructional-services/class-instruction.shtml">Class Instruction</a>
            </li>
        </ul>
    </div>
    <div id="three">
        <h4><a href="/arch/college-history-and-archives/">College History &amp; Archives</a></h4>
        <ul class="menu">
            <li>
                <a href="/arch/college-history-and-archives/college-records.shtml">College Records</a>
            </li>
            <li>
                <a href="http://images.bowdoin.edu/">Historical Photographs<i class="fa fa-external-link" aria-hidden="true" title="external site"></i><span class="visuallyhidden">This link goes to an external site</span></a>
            </li>
            <li>
                <a href="/arch/college-history-and-archives/college-history-resources.shtml">College History Resources</a>
            </li>
            <li>
                <a href="/arch/college-history-and-archives/records-management.shtml">Records Management</a>
            </li>
            <li>
                <a href="/arch/college-history-and-archives/electronic-records.shtml">Electronic Records</a>
            </li>
        </ul>
    </div>
    <div id="four">
        <h4><a href="/arch/george-j-mitchell/">George J. Mitchell</a></h4>
        <ul class="menu">
            <li><a href="/arch/mss/m202.shtml">Collection Guide</a></li>
            <li><a href="http://digitalcommons.bowdoin.edu/mitchelloralhistory/">Oral Histories<i class="fa fa-external-link" aria-hidden="true" title="external site"></i><span class="visuallyhidden">This link goes to an external site</span></a></li>
            <li><a href="/arch/george-j-mitchell/photographs/index.shtml">Photographs</a></li>
            <li><a href="/arch/george-j-mitchell/speeches/index.shtml">Speeches</a></li>
            <li><a href="/arch/george-j-mitchell/memorabilia/index.shtml">Memorabilia</a></li>
            <li><a href="/arch/george-j-mitchell/other-resources.shtml">Other Resources</a></li>
        </ul>
    </div>
    <div id="five">
        <h4><a href="/arch/about-us/">About Us</a></h4>
        <ul class="menu">
            <li>
                <a href="/arch/about-us/staff.shtml">Staff</a>
            </li>
            <li>
                <a href="/about-the-library/hours-sca.shtml">Hours</a>
            </li>
            <li>
                <a href="/arch/about-us/locations.shtml">Locations</a>
            </li>
            <li>
                <a href="/arch/about-us/policies.shtml">Policies</a>
            </li>
            <li>
                <a href="/arch/about-us/contribute.shtml">Contribute</a>
            </li>
            <li>
                <a href="/arch/about-us/news-and-events.shtml">News and Events</a>
            </li>
        </ul>
    </div>
</nav>

                </div>
            </div>
        </div>
        <div class="container" id="sn-anchor"></div>
    </div>
</header>

</xsl:template>
</xsl:stylesheet>
