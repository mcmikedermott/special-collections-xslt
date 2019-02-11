# Special Collections XSLT

XSLT stylesheets for transforming Archivists Toolkit exports to HTML for Bowdoin Special Collections website.

The `ead2html.xsl` is the key file in this project. It is used with the [xsltproc](http://xmlsoft.org/XSLT/xsltproc2.html), an [XSLT v1.0](https://www.w3.org/TR/xslt) transformation program, to convert `.xml` files exported from Archivists Toolkit (AT) into HTML pages for use on Bowdoin Special Collections website. Samples of AT exports are in the `samples` directory and used for testing.

Sample use:
```
xsltproc ead2html.xsl samples/multiple-dao.xml > multiple-dao.html
```

When developing use the development XSL like this to apply the absolute URLs for CSS and JS:
```
xsltproc ead2html-dev.xsl export/M091-ead.xml > M091-ead.html
```


## Summer 2017 / Winter 2018 Project

Update the XSLT to produce a new HTML that is more appealing.

* [Carr's Sample New Version](https://draft-library.bowdoin.edu/arch/test/macmillan2.shtml)
* `samples/M118-ead.xml`: export from Archivist's Toolkit.
* `samples/macmillian/macmillian2.shtml`: the hoped for HTML translation.
* `samples/macmillian/macmillian.shtml`: the current HTML translation.
* `ead2html.xsl`: the new translation XSLT
* `ead2html-dev.xsl`: translation XSLT that wraps `ead2html.xsl` with local hosted includes rather than server side includes that are used on the production site. Use this to test in development.

# Winter 2019 - ArchiveSpace Does not Render Multiple Container objects

> Hi Stephen –
> Would you have time to do a little more troubleshooting on the XSL that transforms the EAD finding aids? We are getting ready to switch from the Archivists Toolkit software to the newer product ArchivesSpace. 
> The EAD XML that AS exports is a little bit different From AT in the namespace it sets and the way it creates IDs in tags. Mostly the existing XSL works, and it doesn’t cause any errors on the new AS eads, but some of the container level information isn’t coming out right. I could show you the problem areas – or send you examples of the files… I’ve tried to step through it but when I get in to all those container level tests I get all turned around. Thanks…
> Mike

* `Sills-AT-EAD.xml` is an export from Archivist's Toolkit (old)
* `Sills-AS-EAD.xml` is an export from Archive Space (new)

The far right column should show something like 'Box 1, Folder 2' for `Series 2` but instead shows seemingly the title.

These problems only seem to appear when there are multiple `container` elements inside a `did`. Of other note, AS exports a `unitid` in the `did` where AT did not.

Examples are at
 
 * `Sills-AT-EAD.xml:386`
 * `Sills-AS-EAD.xml:393`

## Solution / Workaround

It's in the selection of `c-files` versus `c-multi-files` templates inside the `did`. The number of unique `id` in a `did:container` use to tell how many items were in a `did`. That is in AT an item was in a 'box', with an `id`, and then in a 'folder' which did not have it's own `id`, but instead a `parent` with the parent container's `id` (the box). In AS both the 'box' and the 'folder' have an `id`, thus the calculation of the number of children `containers` is now different. The parent `id` is still in the 'folder' container but it also has it's own unique `id`. All this means the `c-files` vs `c-multi-files` template selection does not work. In the old AT there's only three files that used `c-multi-files`: `M015`, `M089`, and `M254`. These are all broken when they call `c-multi-files`. An interim solution is to fix the `c-multi-files` template to be the same as `c-files`. This is until the linking of parent to children in the container `did` can get sorted out. I'm not sure which objects to test with at the moment. I don't know of any that truly have multiple objects in the `did`.

Also note that 'box' and 'folder' the `type` used in `container` objects are not capitalized in Archive Space like they were in Archivist's Toolkit.

