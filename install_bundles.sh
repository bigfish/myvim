#!/bin/bash
cd bundle
set IFS='\n'
cat ../bundles.txt | while read url sha;do
    dir=${url##*/}
    dir=${dir%.git}
    if [ -d $dir ];then
        cd $dir
        git pull
    else
        git clone $url
        cd $dir
    fi
    git checkout $sha
    cd .. 
done
