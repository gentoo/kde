#!/bin/sh

: ${PORTDIR:="$(pwd)"}

help() {
	echo Simple tool to bump KDE package.* files.
	echo
	echo Given a set name, copies the live package.* files to the new
	echo version and updates appropriate.
	echo
	echo Reads PORTDIR from your enviroment, defaulting to the current directory.
	echo
	echo Usage: keyword-bump.sh SETNAME DESTINATIONVERSION
	echo Example: keyword-bump.sh kde-plasma 5.1
	exit 0
}

pretty_setname() {
	local set="${1}"
	echo ${set} | tr "-" " " | sed -e "s/\b\(.\)/\u\1/g" -e "s/kde/KDE/i"
}

SETNAME="$1"
DESTINATIONVERSION="$2"
TARGET="${SETNAME}-${DESTINATIONVERSION}"

if [[ $1 == "--help" ]] ; then
	help
fi

if [[ -z "${SETNAME}" || -z "${DESTINATIONVERSION}" ]] ; then
	echo ERROR: Not enough arguments
	echo
	help
fi

pushd "${PORTDIR}/Documentation" > /dev/null

pushd package.unmask > /dev/null
cp -r .${SETNAME}-live .${TARGET}
pushd .${TARGET} > /dev/null
rm ${SETNAME}-live
ln -s  ../../../sets/${TARGET} ${TARGET}
echo "# You can use this file to mask/unmask the $(pretty_setname ${TARGET}) release." > _HEADER_
echo "# Edit Documentation/package.unmask/.${TARGET}/ files instead." >> _HEADER_
popd > /dev/null
popd > /dev/null

pushd package.accept_keywords > /dev/null
cp -r .${SETNAME}-live.base .${TARGET}
pushd .${TARGET} > /dev/null
rm ${SETNAME}-live
ln -s  ../../../sets/${TARGET} ${TARGET}
echo "# You can use this file to keyword/unkeyword the $(pretty_setname ${TARGET}) release." > _HEADER_
echo "# Edit Documentation/package.accept_keywords/.${TARGET}/ files instead." >> _HEADER_
popd > /dev/null
popd > /dev/null

popd > /dev/null
