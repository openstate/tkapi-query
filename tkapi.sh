#!/bin/bash

start_url=$1
page_nr=1

while [ "$start_url" != "null" ];
do
  fn="data/$page_nr.json"
  echo "$start_url"
  curl -s "$start_url" -o "$fn" -w "%{http_code} %{url_effective}\n" >>pages.txt

  main_documents=`jq -r 'select(.value[] |.DocumentNummer) |.value[] |.DocumentNummer' "$fn"`
  sub_documents=`jq -r 'select(.value[] |.Document) |.value[] |.Document[] |.DocumentNummer' "$fn"`
  for d in `echo -n $main_documents $sub_documents |tr ' ' '\n' | sort -nu`; do
    if [ "$d" != "null" ]; then
      doc_url="https://www.tweedekamer.nl/downloads/document?id=$d"
      echo $doc_url
      curl -s "$doc_url" -o .tmp -w "%{http_code} %{url_effective}\n" >>documents.txt
      doc_mime_type=`file .tmp |awk '{print $2}' |tr 'A-Z' 'a-z'`
      doc_ext=`grep "$doc_mime_type" /etc/mime.types |head -1 |awk '{print $2}'`
      cp .tmp "data/$d.$doc_ext"
      echo $d
      sleep 1
      rm -f .tmp
    fi
  done

  start_url=`jq -r '.["@odata.nextLink"]' "$fn"`
  page_nr=`expr $page_nr + 1`
done
