#!/bin/bash
TMP="/tmp/"
CATEGORY="kde-apps"
# we also assume that we are run from the directory where we want to remove patches eg. directory where are categories.
find -mindepth 2 -maxdepth 3 -type d -name files -print | sort -u |sed -e "s:/files::g" -e "s:\./::g" |grep ${CATEGORY} > ${TMP}/packages-with-patches.txt
EBUILD_BASEDIRS="`cat ${TMP}/packages-with-patches.txt`"
for EBBD in ${EBUILD_BASEDIRS}; do
	pushd $EBBD >> /dev/null
	# now we are in ebuild directory (eg. kde-apps/dolphin)
	find ./files/ -type f |sort -u |sed -e "s:\./files/::g" > ${TMP}/patches-per-package.txt # d. generated on the fly per package.
	PATCHES="`cat ${TMP}/patches-per-package.txt`"
	for PATCH in ${PATCHES}; do
		PATCH_IN_USE="false"
		# look for ebulids and replace the ${P} ${PV} and ${PN} with its specified values.
		find ./ -type f -name \*.ebuild |sort -u |sed -e "s:\./::g" > ${TMP}/ebuild-list-per-package.txt # d. generated on the fly per package.
		EBUILDS="`cat ${TMP}/ebuild-list-per-package.txt`"
		for EBUILD in ${EBUILDS}; do
			P1="`echo ${EBUILD}| sed -e "s:.ebuild::g"`"
			if [[ ${P1/*-/} == r* ]]; then
				P1=`echo ${P1} |  sed -e "s:${P1/*-/}::g" -e "s:-$::g"`
			fi
			PV=${P1/*-/}
			PN=`echo ${P1} |  sed -e "s:${P1/*-/}::g" -e "s:-$::g"`
			cat ${EBUILD} | sed -e "s:\${PN}:${PN}:g" -e "s:\${PV}:${PV}:g" -e "s:\${P}:${PN}-${PV}:g" |grep "${PATCH}" |wc -l > ${TMP}/tst
			COUNT=`cat ${TMP}/tst`
			#echo "cat ${EBUILD} | sed -e \"s:\${PN}:${PN}:g\" -e \"s:\${PV}:${PV}:g\" -e \"s:\${P}:${PN}-${PV}:g\" |grep \"${PATCH}\"" # debug
			if [[ ${COUNT} -gt 0 ]]; then
				#echo "IN USE: ${PATCH}" # debug
				PATCH_IN_USE="true"
				break # escape no need to work further
			fi
		done
		if [[ ${PATCH_IN_USE} == "false" ]]; then
			# for now just write out.
			echo "NOT IN USE!: \"${EBBD}/files/${PATCH}\"" >> ${TMP}/${CATEGORY}-unused-patches.txt
		fi
	done
	popd >> /dev/null
done
