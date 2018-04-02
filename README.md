# Special Collections XSLT

XSLT stylesheets for transforming Archivists Toolkit exports to HTML for Bowdoin Special Collections website.

The `ead2html.xsl` is the key file in this project. It is used with the [xsltproc](http://xmlsoft.org/XSLT/xsltproc2.html), an [XSLT v1.0](https://www.w3.org/TR/xslt) transformation program, to convert `.xml` files exported from Archivists Toolkit (AT) into HTML pages for use on Bowdoin Special Collections website. Samples of AT exports are in the `samples` directory and used for testing.

Sample use:
```
xsltproc ead2html.xsl samples/multiple-dao.xml > multiple-dao.html
```

## Summer 2017 / Winter 2018 Project

Update the XSLT to produce a new HTML that is more appelaing.

* [Carr's Sample New Version](https://draft-library.bowdoin.edu/arch/test/macmillan2.shtml)
* `samples/M118-ead.xml`: export from Archivist's Toolkit.
* `samples/macmillian/macmillian2.shtml`: the hoped for HTML translation.
* `samples/macmillian/macmillian.shtml`: the current HTML translation.
* `ead2html.xsl`: the new translation XSLT
* `ead2html-dev.xsl`: translation XSLT that wraps `ead2html.xsl` with local hosted includes rather than server side includes that are used on the production site. Use this to test in development.

