#!/usr/bin/env bash

for xmlfn in export/M*xml
do
	fn=$(basename $xmlfn .xml)
	xsltproc ead2html-2017.xsl $xmlfn > html/$fn.html
done