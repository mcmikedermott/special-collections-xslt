# Special Collections XSLT

XSLT stylesheets for transforming Archivists Toolkit exports to HTML for Bowdoin Special Collections website.

The `at_eadToHTML.xsl` is the key file in this project. It is used with the [xsltproc](at_eadToHTML.xsl), an [XSLT v1.0](https://www.w3.org/TR/xslt) transformation program, to convert `.xml` files exported
from Archivists Toolkit (AT) into HTML pages for use on Bowdoin Special Collections website. Samples of AT exports are in the `samples` directory and used for testing.

Sample use:
```
xsltproc at_eadToHTML.xsl samples/multiple-dao.xml > multiple-dao.html
```