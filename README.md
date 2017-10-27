# Special Collections XSLT

XSLT stylesheets for transforming Archivists Toolkit exports to HTML for Bowdoin Special Collections website.

The `ead-2-HTML.xsl` is the key file in this project. It is used with the [xsltproc](at_eadToHTML.xsl), an [XSLT v1.0](https://www.w3.org/TR/xslt) transformation program, to convert `.xml` files exported
from Archivists Toolkit (AT) into HTML pages for use on Bowdoin Special Collections website. Samples of AT exports are in the `samples` directory and used for testing.

Sample use:
```
xsltproc ead-2-HTML.xsl samples/multiple-dao.xml > multiple-dao.html
```

## Summer 2017 Project

Update the XSLT to produce a new HTML that is more appelaing.


* [Carr's Sample New Version](https://draft-library.bowdoin.edu/arch/test/macmillan2.shtml)
* `samples/M118-ead.xml`: export from Archivist's Toolkit.
* `samples/macmillian/macmillian2.shtml`: the hoped for HTML translation.
* `samples/macmillian/macmillian.shtml`: the current HTML translation.
* `ead2html-2017.xsl`: the new translation XSLT

