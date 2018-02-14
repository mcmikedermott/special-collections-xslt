#!/bin/bash


site_dir=_site
xml_dir=export
files=$xml_dir/${1:-*}.xml

mkdir $site_dir
cp finding-aid-mod.css $site_dir
echo "<html><body><ul>" > $site_dir/index.html
#for xml in $xml_dir/*.xml; do
for xml in $files; do
	echo "Converting $xml..."
	base=`basename $xml .xml`
	xsltproc ead2html-2017.xsl $xml > $site_dir/$base.html

	echo "<li><a href=\"$base.html\">$base</a></li>" >> $site_dir/index.html
done
echo "</ul></body></html>" >> $site_dir/index.html
