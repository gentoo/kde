#!/usr/bin/env bash
###############################################################################
# KDE Version bumper
# Created by Gentoo kde-herd
# This tool is meant to be used for ease of version bumping for KDE ebuilds
# v 0.22
###############################################################################
# functions
###############################################################################
# took lines from slots which does not point to other slots
get_packages_from_slot() {
	local SLOTFILE

	# if user specify set then use desired one only
	find ${PORTDIR_BUMPING}/sets/ -maxdepth 1 -type f -name ${SET}\*-${SLOT} -print \
			| grep -v kdedeps | while read SLOTFILE; do
		echo ${SLOTFILE} # debug
		# remove empty lines, another slots and comments, replace slot by
		# version.ebuild
		sed -e '/^[@#]/d' \
		    -e '/^$/d' \
		    -e '\@kde-base/@!d' \
		    -e 's/^>=//g' \
		    -e 's/^~//g' \
		    -e 's/^<//g' \
		    -e 's/-4\..\.50$//g' \
		    -e 's/-4\.1.\.50$//g' \
		    -e 's/-9999$//g' \
			${SLOTFILE} >> ${TMPFILE}
	done
}

# create new slot for all packages when creating new minor bump 4.1 -> 4.2
add_new_sloted_version() {
	local SLOTFILE
	local NEWSLOTFILE
	local PREVVER

	find ${PORTDIR_BUMPING}/sets/ -maxdepth 1 -type f -name \*-${SLOT} -print \
		| while read SLOTFILE; do
		NEWSLOTFILE=${SLOTFILE/${SLOT}/${BUMP_VERSION}}
		PREVVER=4.$((${BUMP_VERSION#4.}-1))
		echo "creating ${NEWSLOTFILE}"
		# copy actualy that file
		cp ${SLOTFILE} ${NEWSLOTFILE}
		# fix versioning
		sed -r -i \
			-e "\@kde-base/@{s:~:>=:;s:-(9999|4\..\.50)$:-${PREVVER}.50:};/@kde/s:${SLOT}:${BUMP_VERSION}:" \
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

# Updates keywords:
# - for stable releases - use latest keywords from tree
# - for snapshot/alpha/beta/rc releases - use fixed ~amd64, ~x86 and ~{amd64,x86}-linux keywords
# - for live ebuilds - don't use any keywords
# - in either of the first two cases, drop arch to testing
update_keywords() {
	local MINIMAL_KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux" KEYWORDS
	# Initially strip all keywords
	ekeyword ^all ${1} > /dev/null
	if [[ ${BUMP_VERSION} =~ ([4-9]+)\.?([0-9]*)\.?([0-9]*) ]]; then
		local version_major=${BASH_REMATCH[1]}
		local version_minor=${BASH_REMATCH[2]}
		local version_patch=${BASH_REMATCH[3]}
		if [[ -n ${version_patch} ]]; then
			if (( version_patch == 0 )); then
				# Major release we want minimum keywords
				KEYWORDS=${MINIMAL_KEYWORDS}
			elif (( version_patch == 49 )); then
				# We don't want any keywords for live ebuilds
				KEYWORDS=
			elif (( version_patch < 50 )); then
				# Patch version is < 50 - stable release, try to obtain keywords from tree
				if pushd "$(portageq portdir)/${2}" &> /dev/null; then
					KEYWORDS=$(ls -1r *-4*.ebuild | grep -v ${BUMP_VERSION} | head -n 1 | xargs sed -ne 's/^KEYWORDS="\(.*\)"/\1/p')
					[[ -z ${KEYWORDS} ]] && KEYWORDS=${MINIMAL_KEYWORDS}
				else
					KEYWORDS=${MINIMAL_KEYWORDS}
				fi
				popd &> /dev/null
			elif (( version_patch <= 99 )); then
				# Patch version >= 50 and <= 99 - snapshot/alpha/beta/rc release, ~amd64 ~x86 keywords
				KEYWORDS=${MINIMAL_KEYWORDS}
			fi
		fi
	fi
	ekeyword ${KEYWORDS} "${1}" > /dev/null
	ekeyword ~all "${1}" > /dev/null
}

# print out help function
help() {
	echo "Welcome to KDE package version bumper"
	echo
	echo "When bumping:"
	echo "For correct usage set SLOT, VERSION and BUMP_VERSION arguments."
	echo "BUMP_VERSION is used as target version and version specify what ebuilds are used as base."
	echo "-l argument specify sets to use (optional)"
	echo "Example:"
	echo "$0 -a bump -s 4.4 -v 9999 -b 4.3.90 -l kdebase"
	echo
	echo "When removing:"
	echo "$0 -a remove -v 4.4.0"
	echo
	echo "When creating new slot:"
	echo "-s STARTSLOT -b BUMPSLOT"
	echo "$0 -a slot -s 4.4 -b 4"
	echo
	echo "When diffing two versions for cmakelists"
	echo "-v OLDVERSION -b NEWVERSION -p DIRECTORY_WHERE_ARE_TBZS -o OUTPUT_DIR"
	echo "$0 -a diff -v 4.4.0 -b 4.4.1 -p \"/usr/portage/distfiles\" -o /tmp"
	echo
	echo "When moving kde from overlay to the main tree"
	echo "-v VERSION"
	echo "$0 -a cvsmove -v 4.4.4"
	exit 0
}

_cvsupdate() {
	pushd "${1}" &> /dev/null
	#cvs up
	popd &> /dev/null
}
_addcvsfile() {
	pushd "${1}" &> /dev/null
	echo "${1}/${2}"
	cvs add ${2}
	popd &> /dev/null
}
_check_patches() {
	pushd "${1}" &> /dev/null
	rm ${TMPFILE} &> /dev/null
	touch ${TMPFILE} &> /dev/null
	[[ -d files/ ]] || return
	find ./files/ -type f |grep -v "CVS/" |grep -v ".svn" |sort -u |sed -e "s:\./files/::g" |while read PATCH; do
		P1="`echo ${3}| sed -e "s:.ebuild::g"`"
		[[ ${P1/*-/} == r* ]] && P1=`echo ${P1} |  sed -e "s:${P1/*-/}::g" -e "s:-$::g"`
		PV=${P1/*-/}
		PN=`echo ${P1} |  sed -e "s:${P1/*-/}::g" -e "s:-$::g"`
		if [[ $(cat ${3} | sed -e "s:\${PN}:${PN}:g" -e "s:\${PV}:${PV}:g" -e "s:\${P}:${PN}-${PV}:g" |grep "${PATCH}" |wc -l) -gt 0 ]]; then
			echo "${PATCH}" >> ${TMPFILE}
		fi
	done
	popd &> /dev/null
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
		a) OPERATION=${OPTARG} ;;
		s) SLOT=${OPTARG} ;;
		v) VERSION=${OPTARG} ;;
		b) BUMP_VERSION="${OPTARG}" ;;
		l) SET="${OPTARG}" ;;
		p) DIR="${OPTARG}" ;;
		o) OUTPUT_DIR="${OPTARG}" ;;
		*) help ;;
		?) help ;;
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
	cvsmove)
		[[ -z "${VERSION}" ]] && help
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
			# ie. bumping 4.4.92 you set keywords to "~amd64 ~x86" but ebuilds from 9999 (before tagging) or 4.5.9999 (after tagging).
			# and bumping 4.4.5 you pick keywords from 4.4.4 but ebuilds from 4.4.9999.
			OLD=`find ${OLD_BASE} -name \*-${VERSION}\*.ebuild | sort -r | head -n 1`
			mkdir "${PORTDIR_BUMPING}"/"${EBUILD_BASEDIR}"/ -p # wont harm kittens
			NEW="${PORTDIR_BUMPING}"/"${EBUILD_BASEDIR}"/"${EBUILD_BASENAME}"-${BUMP_VERSION}.ebuild
			EBUILD_NAME="${EBUILD_BASENAME}"-${BUMP_VERSION}.ebuild
			pushd "${PORTDIR_BUMPING}/${EBUILD_BASEDIR}" > /dev/null
			if [ -f ${NEW} ]; then
				# update keywords
				echo "Updating keywords for ${NEW}"
				update_keywords ${NEW} ${EBUILD_BASEDIR}
				repoman manifest
				if [[ -d "${PORTDIR_BUMPING}/.git" ]]; then
					git add .
				fi
			else
				# actualy create our desired ebuild files
				# echo "Creating: ${NEW}" # verbosity
				cp "${OLD}" "${NEW}"
				if [ `grep ".patch" ${NEW} |wc -l` -gt 0 ]; then
						INFO_LIST="${INFO_LIST} You should pay more attention to ebuild ${NEW}, because it has some patches.\n"
				fi
				# update keywords
				update_keywords ${NEW} ${EBUILD_BASEDIR}
				repoman manifest
				if [[ -d "${PORTDIR_BUMPING}/.git" ]]; then
					git add .
				fi
			fi
			popd > /dev/null
		done
		echo -e ${INFO_LIST}
		;;
	remove)
		find_packagedirs_for_removal
		EBUILD_BASEDIR_LIST=`cat ${TMPFILE} |sort -u`
		for EBUILD_BASEDIR in ${EBUILD_BASEDIR_LIST}; do
			EBUILD_BASENAME=${EBUILD_BASEDIR/*\//}
			pushd "${PORTDIR_BUMPING}"/"${EBUILD_BASEDIR}" > /dev/null
			if [[ -d "${PORTDIR_BUMPING}/.git" ]]; then
				EBUILD=`find ./ -name \*.ebuild | grep "${VERSION}\(\-r[0-9]\+\)\?\\." | sort |tail -n 1`
				git rm "${EBUILD}"
			elif [[ -d CVS ]]; then
				cvs remove -f "${EBUILD_BASENAME}-${VERSION}"*.ebuild
				echangelog "Remove KDE SC ${VERSION}"
			fi
#			if [[ -d files/ ]]; then
#				# generate list of patches.
#				find ./files/ -type f |grep -v "CVS/" |grep -v ".svn" |sort -u |sed -e "s:\./files/::g" > /tmp/patches-per-package.txt
#				PATCHES="`cat /tmp/patches-per-package.txt`"
#				for PATCH in ${PATCHES}; do
#					PATCH_IN_USE="false"
#					find ./ -type f -name \*.ebuild |sort -u |sed -e "s:\./::g" > ${TMP}/ebuild-list-per-package.txt
#					EBUILDS="`cat ${TMP}/ebuild-list-per-package.txt`"
#					for EBUILD in ${EBUILDS}; do
#						P1="`echo ${EBUILD}| sed -e "s:.ebuild::g"`"
#						[[ ${P1/*-/} == r* ]] && P1=`echo ${P1} |  sed -e "s:${P1/*-/}::g" -e "s:-$::g"`
#						PV=${P1/*-/}
#						PN=`echo ${P1} |  sed -e "s:${P1/*-/}::g" -e "s:-$::g"`
#						if [[ $(cat ${EBUILD} | sed -e "s:\${PN}:${PN}:g" -e "s:\${PV}:${PV}:g" -e "s:\${P}:${PN}-${PV}:g" |grep "${PATCH}" |wc -l) -gt 0 ]]; then
#							PATCH_IN_USE="true"
#							break
#						fi
#					done
#					if [[ ${PATCH_IN_USE} = "false" ]]; then
#						echo "Removing ${PATCH}. No longer used in package ${EBUILD_BASEDIR}."
#						git rm -rf $(find ./files/ -type f -name ${PATCH})
#					fi
#				done
#			fi
			repoman manifest
			if [[ -d "${PORTDIR_BUMPING}/.git" ]]; then
				git add --all .
			fi
			popd &> /dev/null #go back to workdir
		done
		;;
	slot) add_new_sloted_version ;;
	diff) check_cmakelists ;;
	cvsmove)
		MAINTREE="$(portageq portdir)"
		OVERLAY="`pwd`"
		BUMP_VERSION=${VERSION}
		# course of action we are doing here
		# cvs up whole tree, then kde-base
		# then start going per each dir
		# cvs up, move the ebuild, its patches if needed, run echangelog, run keywords check, manifest
		#_cvsupdate "${MAINTREE}"
		find ./kde-base/ -mindepth 1 -maxdepth 1 -type d |sed -e "s:./::" | sort |while read dir; do
			# we also have to check if directory contains our version if not, we dont copy it
			pushd "${OVERLAY}/${dir}" &> /dev/null
			if [[ `find ./ -name \*.ebuild|grep ${VERSION} |wc -l` -gt 0 ]]; then
				popd &> /dev/null
				WRKDIR="${MAINTREE}/${dir}"
				if [[ ! -d "${WRKDIR}" ]]; then
					# we need to add the directory to scm tracking
					mkdir -p "${WRKDIR}"
					_addcvsfile "${MAINTREE}/${dir/\/*/}" ${dir/*\//}
				fi
				_cvsupdate "${WRKDIR}"
				# we need to copy the file we want to play with
				## first generate the correct filename, we expect that if someone added -rX to the package it has reason.
				pushd "${OVERLAY}/${dir}" &> /dev/null
				EBUILD=`find ./ -name \*.ebuild | grep "${VERSION}\(\-r[0-9]\+\)\?\\." | sort |tail -n 1`
				echo ${EBUILD}
				cp -f ${EBUILD} "${WRKDIR}"
				popd &> /dev/null
				_addcvsfile "${WRKDIR}" ${EBUILD/*\//}
				# now we need to search up all patches ebuild is containing and move them along if they are needed.
				_check_patches "${OVERLAY}/${dir}" "${WRKDIR}" ${EBUILD/*\//}
				if [[ `cat ${TMPFILE} |wc -l` -gt 0 ]]; then
					cat ${TMPFILE} |while read file; do
						# we actualy have to check if the file is not in subdir and create corresponding directory structure
						if [[ ! -d "${WRKDIR}/files" ]]; then
							# create files dir
							mkdir -p "${WRKDIR}/files"
							_addcvsfile "${WRKDIR}" files/
						fi
						pushd "${OVERLAY}/${dir}" &> /dev/null
						PTH=`find ./ -name ${file/*\//} |sed -e "s:./::" -e "s:${file/*\//}::"`
						PDIR=""
						if [[ ${PTH} != "files/" ]]; then
							# fixme i expect only one depth folders
							# anyway no kde package don't use more than one so i wont bother for now
							PDIR=${PTH/files\//}
							mkdir -p "${PDIR}"
							_addcvsfile "${WRKDIR}/files/" "${PDIR}"
						fi
						# note that we always replace the patches, no warnings we just poke ourselves over them :]
						cp -f "files/${PDIR}${file}" "${WRKDIR}/files/${PDIR}"
						_addcvsfile "${WRKDIR}/files/${PDIR}" ${file}
						popd &> /dev/null
					done
				fi
				# now we have to check up the keywords
				pushd "${WRKDIR}" &> /dev/null
				update_keywords "${EBUILD/*\//}" ${dir}
				echangelog "Version bump KDE SC ${VERSION}"
				repoman manifest
				popd &> /dev/null
			else
				popd &> /dev/null
			fi
		done
		;;
	*) help ;;
esac
###############################################################################
# EOF
###############################################################################
