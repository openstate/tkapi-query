#!/bin/bash

start_url=$1
page_nr=1
while [ "$start_url" != "null" ];
do
  echo "$start_url"
  curl -s "$start_url" >"$page_nr.json"
  start_url=`jq -r '.["@odata.nextLink"]' "$page_nr.json"`
  page_nr=`expr $page_nr + 1`
done
