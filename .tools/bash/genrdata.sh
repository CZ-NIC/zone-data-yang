#! /bin/bash
cd $HOME/Projects/YANG/zone-data
git checkout rawxslt
git cherry-pick master
xsltproc .tools/xslt/rdata-templates.xsl dns-zones.yinx | \
    xmllint --output xslt/rdata.xsl --format -
git add xslt/rdata.xsl
git commit -m 'Generate new RDATA stylesheet.'
git checkout master
git cherry-pick rawxslt

