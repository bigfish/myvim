#!/bin/bash
bundles=`pwd`/bundles.txt
echo -n "" > $bundles

cd bundle
for repo in `ls`;do

    if [ -d $repo ];then
        cd $repo
        if [ -d .git ];then
            sha=`git log|head -n1|cut -d' ' -f2`
            if git config --get remote.origin.url;then
                echo `git config --get remote.origin.url` $sha >> $bundles
            fi
        fi
        cd .. 
    fi
done

