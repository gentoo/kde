#!/usr/bin/env bash
###############################################################################
# KDE Version bumper
# Created by Gentoo kde-herd
# This tool is meant to be used for ease of version bumping for KDE ebuilds
# v 0.21
###############################################################################
# functions
###############################################################################
# took lines from slots which does not point to other slots
get_packages_from_slot() {
	local SLOTFILE

	# if user specify set then use desired one only
	find ${PORTDIR_BUMPING}/sets/ -maxdepth 1 -type f -name ${SET}\*-${SLOT} -print \
			| while read SLOTFILE; do
		echo ${SLOTFILE} # debug
		# remove empty lines, another slots and comments, replace slot by
		# version.ebuild
		cat ${SLOTFILE} |grep -v ^@ |grep -v ^$ |grep -v ^# \
			|sed -e "s/:${SLOT}//g" \
			>> ${TMPFILE}
	done
}

# update package keywords from anything to testing
update_package_keywords() {
	ekeyword ~all ${1}
}

# regenerate manifest files
update_package_manifest() {
	cd "${PORTDIR_BUMPING}"/"${EBUILD_BASEDIR}"/
	repoman manifest
	cd "${PORTDIR_BUMPING}" #go back to workdir
}

# add basic line to changelog telling that we bumped new revision
update_package_changelog() {
	local EBUILD=${1}

	cd "${PORTDIR_BUMPING}"/"${EBUILD_BASEDIR}"/
	git add ${EBUILD}
	# be quiet when creating changelog
	echangelog "Version bump." >> /dev/null
	cd "${PORTDIR_BUMPING}" # go back to workdir
}

# create new slot for all packages when creating new minor bump 4.1 -> 4.2
add_new_sloted_version() {
	local SLOTFILE
	local NEWSLOTFILE

	find ${PORTDIR_BUMPING}/sets/ -maxdepth 1 -type f -name \*-${SLOT} -print \
		| while read SLOTFILE; do
		NEWSLOTFILE=${SLOTFILE/${SLOT}/${BUMP_VERSION}}
		echo "creating ${NEWSLOTFILE}"
		# copy actualy that file
		cp ${SLOTFILE} ${NEWSLOTFILE}
		# fix versioning
		sed -i \
			-e "s:${SLOT}:${BUMP_VERSION}:" \
			${NEWSLOTFILE} || die "unable to update slotfile versioning"
		# add to git
		git add ${NEWSLOTFILE}
	done
}

# write ebuild directories in which i will work to file.
find_packagedirs_for_removal() {
	find ${PORTDIR_BUMPING}/kde-base/ -name \*${VERSION}\*.ebuild -print |while read FILE; do
		echo ${FILE} |sed -e "s:${PORTDIR_BUMPING}/kde-base/::" \
			|awk -F'/' '{print "kde-base/"$1}' \
			>> ${TMPFILE}
	done
}

# diff CMakeLists.txt recursively through new sources again old one to see
# if there are any added ebuilds
check_cmakelists() {
	cd "${OUTPUT_DIR}"
	find ${DIR} -maxdepth 1 -type f -name kde\*-${BUMP_VERSION}.tar.bz2 -print \
			|while read FILE; do
		FILENAME=${FILE/*\/}
		FILENAME=${FILENAME/.tar.bz2/}
		rm CMakeListsDiff-${FILENAME}.diff > /dev/null
		touch CMakeListsDiff-${FILENAME}.diff
		echo "Checking CMakeLists.txt in: ${FILENAME} > ${OUTPUT_DIR}/CMakeListsDiff-${FILENAME}.diff"
		# unpack files into /var/tmp/portage/
		tar -xjf ${FILE} -C "${OUTPUT_DIR}"/
		tar -xjf ${FILE/${BUMP_VERSION}/${VERSION}} \
			-C "${OUTPUT_DIR}"/
		find ${FILENAME} -type f -name CMakeLists.txt -print \
				|while read CLIST; do
			# echo ${CLIST/${BUMP_VERSION}/${VERSION}}
			# echo ${CLIST}
			diff -urNibB ${CLIST/${BUMP_VERSION}/${VERSION}} ${CLIST} \
			>> CMakeListsDiff-${FILENAME}.diff
		done
		if [ `cat CMakeListsDiff-${FILENAME}.diff |grep -i [+-]addsubdirectory |wc -l` -gt 0 ]; then
			echo "I found something really interesting in ${FILENAME}"
			echo "You should really look into ${OUTPUT_DIR}/CMakeListsDiff-${FILENAME}.diff"
			echo
		fi
		# cleanup our dirt
		rm -rf ${FILENAME}*
		rm -rf ${FILENAME/${BUMP_VERSION}/${VERSION}}*
	done
}

# print out help function
help() {
	echo "Welcome to KDE package version bumper"
	echo
	echo "When bumping:"
	echo "For correct usage set SLOT, VERSION and BUMP_VERSION arguments."
	echo "-l argument specify SET and is optional"
	echo "Example:"
	echo "$0 -a bump -s 4.1 -v 4.1.0 -b 4.1.1 -l kdebase"
	echo
	echo "When removing:"
	echo "$0 -a remove -v 4.1.0"
	echo
	echo "When creating new slot:"
	echo "-s STARTSLOT -b BUMPSLOT"
	echo "$0 -a slot -s 4.1 -b 4"
	echo
	echo "When diffing two versions for cmakelists"
	echo "-v OLDVERSION -b NEWVERSION -p DIRECTORY_WHERE_ARE_TBZS -o OUTPUT_DIR"
	echo "$0 -a diff -v 4.1.0 -b 4.1.1 -p \"/usr/portage/distfiles\" -o /tmp"
	exit 0
}
###############################################################################
# main
###############################################################################
# argument passing
###############################################################################
if [[ $1 == "--help" ]]; then
	help
fi
SLOT=
VERSION=
OPERATION=
BUMP_VERSION=
SET=
DIR=
OUTPUT_DIR=
while getopts a:s:v:b:l:p:o: arg ; do
	case ${arg} in
		a) OPERATION=${OPTARG};;
		s) SLOT=${OPTARG};;
		v) VERSION=${OPTARG};;
		b) BUMP_VERSION="${OPTARG}";;
		l) SET="${OPTARG}";;
		p) DIR="${OPTARG}";;
		o) OUTPUT_DIR="${OPTARG}";;
		*) help;;
		?) help;;
	esac
done
case ${OPERATION} in
	bump)
		[[ -z "${SLOT}" || -z "${VERSION}" || -z "${BUMP_VERSION}" ]] && help
		;;
	remove)
		[[ -z "${VERSION}" ]] && help
		;;
	slot)
		[[ -z "${SLOT}" || -z "${BUMP_VERSION}" ]] && help
		;;
	diff)
		[[ -z "${VERSION}" || -z "${BUMP_VERSION}" || -z "${DIR}" || -z "${OUTPUT_DIR}" ]] && \
			help
		;;
	*)
		help
		;;
esac
###############################################################################
# global variables
###############################################################################
# these variables needs to be full paths!
# for portdir bumping it should be addable by another argument
PORTDIR_BUMPING="`pwd`" # for time being could be env portagedir
TMPFILE=/tmp/kdeBumpList.txt
###############################################################################
# Remove the temporary file before starting our run
if [[ -e ${TMPFILE} ]]; then
	rm ${TMPFILE}
fi
case ${OPERATION} in
	bump)
		get_packages_from_slot
		EBUILD_BASEDIR_LIST=`cat ${TMPFILE} |sort -u`
		INFO_LIST=
		for EBUILD_BASEDIR in ${EBUILD_BASEDIR_LIST}; do
			EBUILD_BASENAME=${EBUILD_BASEDIR/*\//}
			#OLD_BASE="$(portageq portdir)"/"${EBUILD_BASEDIR}"/
			OLD_BASE="${PORTDIR_BUMPING}"/"${EBUILD_BASEDIR}"/ # uncoment if you work in overlay only
			# by default we should pick-up live stable or live ebuilds. But we need to restore the keywords from the previous version of kde
			# ie. bumping 4.2.71 you pick keywords from 4.2.70 but the ebuilds from 9999.
			# and bumping 4.2.3 you pick keywords from 4.2.2 but ebuilds from 4.2.9999.
			OLD=`find ${OLD_BASE} -name \*${VERSION}\*.ebuild |sort -r |head -n 1`
			mkdir "${PORTDIR_BUMPING}"/"${EBUILD_BASEDIR}"/ -p # wont harm kittens
			NEW="${PORTDIR_BUMPING}"/"${EBUILD_BASEDIR}"/"${EBUILD_BASENAME}"-${BUMP_VERSION}.ebuild
			EBUILD_NAME="${EBUILD_BASENAME}"-${BUMP_VERSION}.ebuild
			# echo ${OLD} # debug
			# echo ${NEW} # debug
			if [ -f ${NEW} ]; then
				echo "Skipping ${NEW} already created!";
				# rm -rf ${NEW} # debug
			else
				# actualy create our desired ebuild files
				# echo "Creating: ${NEW}" # verbosity
				cp "${OLD}" "${NEW}"
				if [ `grep ".patch" ${NEW} |wc -l` -gt 0 ]; then
						INFO_LIST="${INFO_LIST} You should pay more attention to ebuild ${NEW}, because it has some patches.\n"
				fi
				# we have update keywords
				update_package_keywords ${NEW}
				# update manifest and changelog
				update_package_changelog ${EBUILD_NAME}
				update_package_manifest
			fi
		done
		echo -e ${INFO_LIST}
		;;
	remove)
		find_packagedirs_for_removal
		EBUILD_BASEDIR_LIST=`cat ${TMPFILE} |sort -u`
		for EBUILD_BASEDIR in ${EBUILD_BASEDIR_LIST}; do
			EBUILD_BASENAME=${EBUILD_BASEDIR/*\//}
			pushd "${PORTDIR_BUMPING}"/"${EBUILD_BASEDIR}" > /dev/null
			git rm ${EBUILD_BASENAME}-${VERSION}*.ebuild
			if [[ -d files/ ]]; then
				# generate list of patches.
				find ./files/ -type f |grep -v "CVS/" |grep -v ".svn" |sort -u |sed -e "s:\./files/::g" > /tmp/patches-per-package.txt
				PATCHES="`cat /tmp/patches-per-package.txt`"
				for PATCH in ${PATCHES}; do
					PATCH_IN_USE="false"
					find ./ -type f -name \*.ebuild |sort -u |sed -e "s:\./::g" > ${TMP}/ebuild-list-per-package.txt
					EBUILDS="`cat ${TMP}/ebuild-list-per-package.txt`"
					for EBUILD in ${EBUILDS}; do
						P1="`echo ${EBUILD}| sed -e "s:.ebuild::g"`"
						[[ ${P1/*-/} == r* ]] && P1=`echo ${P1} |  sed -e "s:${P1/*-/}::g" -e "s:-$::g"`
						PV=${P1/*-/}
						PN=`echo ${P1} |  sed -e "s:${P1/*-/}::g" -e "s:-$::g"`
						if [[ $(${EBUILD} | sed -e "s:\${PN}:${PN}:g" -e "s:\${PV}:${PV}:g" -e "s:\${P}:${PN}-${PV}:g" |grep "${PATCH}" |wc -l) -gt 0 ]]; then
							PATCH_IN_USE="true"
							break
						fi
					done
					if [[ ${PATCH_IN_USE} == "false" ]]; then\
						echo "Removing ${PATCH}. No longer used in package ${EBUILD_BASEDIR}."
						git rm -rf ${PATCH}
					fi
				done
			fi
			echangelog "Version removed." &> /dev/null
			repoman manifest
			popd &> /dev/null #go back to workdir
		done
		;;
	slot) add_new_sloted_version ;;
	diff) check_cmakelists ;;
	*) help ;;
esac
###############################################################################
# EOF
###############################################################################
