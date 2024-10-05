#!/bin/bash

DEPLOYDIR="/tmp/hostinger_deploy/about_me"
REPO=$1

rm -rf ${DEPLOYDIR}

echo "Building the app..."
if elm-land build;  then
  echo "elm-land build success";
   if mkdir -p ${DEPLOYDIR};  then
     cd ${DEPLOYDIR};
     echo "Cloning...";
     if git clone ${REPO} deploy; then
       echo "git clone ${REPO} successful.."
       cd -
       echo "copying files"
       if cp -r dist/* ${DEPLOYDIR}/deploy; then
	 cd ${DEPLOYDIR}/deploy
	  git add  *
	if git commit -m "$(date +%F_%H-%M-%S)" ; then
	   git push 
	  echo "Deploy Successful.."
	else
	  echo "git commit failed.."
	fi
       else
	 echo "Copy failed";
       fi
     else
       echo "git clone ${REPO} Failed.";
     fi
   else 
     echo "failed to create ${DEPLOYDIR}.";
   fi
else 
  echo "elm-land build failed";
fi

