
[ ] M091 - DAO objects
[ ] M286 - has subseries of series -- what should UI look like?

[*] M290, M305 - all files are top-level
[*] M305, M306 - content inventory all titles
[*] M335 no content inventory, all under scove and contents note (just how it is)
[*] M275 no content (just how it is)

[ ] In Collection Inventory where does the "Series n" title come from? The series' are not numbered from what I can tell.

---

Some exports have the unitid encoded in the title and some do not. They should not.

M091-ead.xml (bad):
```
        <dsc>
            <c01 id="ref8" level="series">
                <did>
                    <unittitle>M91.1: Correspondence, early life, 1833-May 1861</unittitle>
                    <unitid>M91.1</unitid>
                    <langmaterial>
                        <language langcode="eng"/>
```

M118-ead.xml (good):
```
        <dsc>
            <c01 id="ref5" level="series">
                <did>
                    <unittitle>Correspondence, 1884-1970, n.d.</unittitle>
                    <unitid>M118.1</unitid>
                    <physdesc>
                        <extent>0.65 linear feet</extent>
```
---

* Some containers have extra spaces in their names, e.g. '   4a  '

M118-ead.xml:130:
```
               <c02 id="ref11" level="file">
                    <did>
                        <unittitle>1909 Note placed in bottle by DBM and dropped, from S.S. Roosevelt, Sept. 2, 1909, with reply Mar. 8, 1919. ms and ts.</unittitle>
                        <container id="cid555494" type="Box" label="Mixed Materials">1</container>
                        <container parent="cid555494" type="Folder">	4a	</container>
                    </did>
                </c02>						
```