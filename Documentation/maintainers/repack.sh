#!/bin/sh
# Script to repack upstream tarbolls
#
SVNREV=$2
KDEVER=$1

# Unpaking
for x in $(ls *.tar.bz2)
do
	tar xpjf $x
done

# Renaming dirs
for x in $(ls -d *.svn${SVNREV})
do
	mv ${x} ${x/.svn${SVNREV}/}
done

# making tars
for x in $(ls -d *-${KDEVER})
do
	tar cpf $x.tar $x
done

# making tar.lzma
for x in $(ls *.tar)
do
	lzma -9 -v $x
done

exit 0
