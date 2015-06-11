#!/usr/bin/env sh

N=7

for i in $(seq $N); do
    echo "<<MissingLinksPage($i,$N)>>" > "missing_links_$i.md"
done
