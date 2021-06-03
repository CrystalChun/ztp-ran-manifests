#!/bin/sh

START_INDEX=$1
END_INDEX=$2

PREFIX="sno"

rm -rf manifests/moc-sites
for i in $(seq -f "%05g" $START_INDEX $END_INDEX); do
  mkdir -p manifests/moc-sites/$PREFIX$i
  for template_file in `ls moc-site-template`; do
    vlan=$(( $RANDOM % 4096 ))
    file_name=`echo $template_file | sed s/SITE/$PREFIX$i/`
    cat moc-site-template/$template_file | \
        sed s/SITE/$PREFIX$i/g | \
        sed s/VLAN/$vlan/g \
        > manifests/moc-sites/$PREFIX$i/$file_name
  done
done