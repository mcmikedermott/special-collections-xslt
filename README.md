# Special Collections XSLT

XSLT stylesheets for transforming Archivists Toolkit exports to HTML for Bowdoin Special Collections website.

The `ead-2-HTML.xsl` is the key file in this project. It is used with the [xsltproc](at_eadToHTML.xsl), an [XSLT v1.0](https://www.w3.org/TR/xslt) transformation program, to convert `.xml` files exported
from Archivists Toolkit (AT) into HTML pages for use on Bowdoin Special Collections website. Samples of AT exports are in the `samples` directory and used for testing.

Sample use:
```
xsltproc ead-2-HTML.xsl samples/multiple-dao.xml > multiple-dao.html
```

## 2017-03-24 Handle multiple objects better

This update relates to M091-ead.xml which contains multiple objects (DAOs).

The first DAO object, `ns2:title="1850 Jul"`, has a title that matches the containing title. In this case, we should show just 'view online'.

The second DAO object, `ns2:title="Select transcripts"`, has a title that *does not* match the containing title, we should show 'view Select transscripts online'.

Excerpted lines 301-317 of `M091-ead.xml`:

```
<c id="ref26" level="file">
	<did>
		<unittitle>1850 Jul</unittitle>
		<container id="cid892947" type="Box" label="Mixed materials">1</container>
		<container parent="cid892947" type="Folder">17</container>
	</did>
	<dao ns2:actuate="onRequest" ns2:show="embed" ns2:title="1850 Jul" ns2:role="Text-Service" ns2:href="https://library.bowdoin.edu/arch/mss/ooh-pdf/M91b01f017">
		<daodesc>
			<p>1850 Jul</p>
		</daodesc>
	</dao>
	<dao ns2:actuate="onRequest" ns2:show="embed" ns2:title="Select transcripts" ns2:role="Text-Service" ns2:href="https://library.bowdoin.edu/arch/mss/ooh-pdf/M91b01f017_transcripts">
		<daodesc>
			<p>Select transcripts</p>
		</daodesc>
	</dao>
</c>
```

The resulting HTML:

```
<tr class="even">
	<td class="container">1</td>
	<td class="container">17</td>
	<td class="c02" colspan="3">
		<p>1850 Jul </p>
		<a class="Text-Service" href="https://library.bowdoin.edu/arch/mss/ooh-pdf/M91b01f017">View online</a>
		<a class="Text-Service" href="https://library.bowdoin.edu/arch/mss/ooh-pdf/M91b01f017_transcripts">View Select transcripts online</a> 
	</td>
</tr>
```
