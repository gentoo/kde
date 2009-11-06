#!/bin/sh
# Script to repack upstream tarballs
#
SVNREV=$2
KDEVER=$1

# Unpaking
for x in $(ls *.tar.bz2)
do
	tar xpjf $x
done

# Renaming dirs
for x in $(ls -d *svn${SVNREV})
do
	mv ${x} ${x/svn${SVNREV}/}
done

# making tars
for x in $(ls -d *-${KDEVER})
do
	tar cpf $x.tar $x
	rm -rf $x
done

# making tar.xz
for x in $(ls *.tar)
do
	xz -9 -e -v $x
done

exit 0
