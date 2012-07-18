#! /bin/bash
cd bundle
for repo in `ls`;do
		cd $repo;
		echo "updating $repo"
		git pull
		cd ..
done
