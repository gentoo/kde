#!/bin/bash

. $(dirname "$0")/lib.sh

: ${TARGET_REPO:="$(pwd)"}

: ${QT_MINIMAL:=5.12.3}
: ${FRAMEWORKS_MINIMAL:=5.60.0}
: ${PLASMA_MINIMAL:=5.16.5}
: ${KDE_APPS_MINIMAL:=19.04.3}

help() {
	echo Simple set-based version removed.
	echo
	echo Given a set file, removes all packages of a specified version.
	echo
	echo Reads TARGET_REPO from your environment, defaulting to the current directory.
	echo
	echo Usage: set-based-remove.sh SETNAME VERSION
	echo Example: set-based-remove.sh kde-plasma-5.0 5.0.1
	exit 0
}

addglobals() {
	local category=$1
	local pf=$2

	sed -e "/inherit/s/kde5/ecm-utils kde.org/" \
		-e "s/kde5_/ecm-utils_/" \
		-e "s/punt_bogus_dep/ecm_punt_bogus_dep/" \
		-e "s/KDE_DEBUG/ECM_DEBUG/" \
		-e "s/KDE_EXAMPLES/ECM_EXAMPLES/" \
		-e "s/KDE_HANDBOOK/ECM_HANDBOOK/" \
		-e "s/KDE_DOC_DIR/ECM_HANDBOOK_DIR/" \
		-e "s/KDE_PO_DIRS/ECM_PO_DIRS/" \
		-e "s/KDE_QTHELP/ECM_QTHELP/" \
		-e "s/KDE_TEST/ECM_TEST/" \
		-e "s/KMNAME/KDE_ORG_NAME/" \
		-i ${pf}

	if [[ ${category} = kde-apps ]]; then
		grep -Eq "add_kdeapps_dep" ${pf} && sed -i "/^inherit/i \
PVCUT=\$(ver_cut 1-3)" ${pf}
		grep -Eq "^SLOT" ${pf} || sed -i "/^KEYWORDS/i \
SLOT=\"5\"" ${pf}
		grep -Eq "^LICENSE" ${pf} || sed -i "/^SLOT/i \
LICENSE=\"GPL-2\" # TODO: CHECK" ${pf}
	elif grep -Eq "add_kdeapps_dep" ${pf}; then
		[[ -n $(grep -Eq "^KDE_APPS_MINIMAL" ${pf}) ]] && \
			KDE_APPS_MINIMAL=$(grep -E "^KDE_APPS_MINIMAL" ${pf} | sed -e "s:.*=\"::" -e "s:\"$::")
		sed -i "/^inherit/i \
KDE_APPS_MINIMAL=${KDE_APPS_MINIMAL}" ${pf}
	fi

	if [[ ${category} = kde-frameworks ]]; then
		sed -i "/^inherit/i \
PVCUT=\$(ver_cut 1-2)" ${pf}
	elif grep -q "add_frameworks_dep" ${pf}; then
		[[ -n $(grep -Eq "^FRAMEWORKS_MINIMAL" ${pf}) ]] && \
			FRAMEWORKS_MINIMAL=$(grep -E "^FRAMEWORKS_MINIMAL" ${pf} | sed -e "s:.*=\"::" -e "s:\"$::")
		sed -i "/^inherit/i \
KFMIN=${FRAMEWORKS_MINIMAL}" ${pf}
	fi

	if [[ ${category} = kde-plasma ]]; then
		sed -i "/^inherit/i \
PVCUT=\$(ver_cut 1-3)" ${pf}
	elif grep -Eq "add_plasma_dep" ${pf}; then
		[[ -n $(grep -Eq "^PLASMA_MINIMAL" ${pf}) ]] && \
			PLASMA_MINIMAL=$(grep -E "^PLASMA_MINIMAL" ${pf} | sed -e "s:.*=\"::" -e "s:\"$::")
		sed -i "/^inherit/i \
PLASMA_MINIMAL=${PLASMA_MINIMAL}" ${pf}
	fi

	if grep -Eq "add_qt_dep" ${pf}; then
		[[ -n $(grep -Eq "^QT_MINIMAL" ${pf}) ]] && \
			QT_MINIMAL=$(grep -E "^QT_MINIMAL" ${pf} | sed -e "s:.*=\"::" -e "s:\"$::")
		sed -i "/^inherit/i \
QTMIN=${QT_MINIMAL}" ${pf}
	fi
}

modlines() {
	local category=$1
	local pf=$2

	_fqdndep() {
		local dep_cat=$1
		local dep_ver=$2
		local line=$3

		local tmp dep_op dep_pn dep_use dep_slot

		# line: <package name> [USE flags] [minimum version] [slot + operator]
		dep_pn=$(echo ${line} | cut -d " " -f 1 | sed -e "s/'//g")

		tmp=$(echo ${line} | cut -d " " -f 2 | sed -e "s/'//g")
		[[ ${tmp} != ${dep_pn} ]] && dep_use="${tmp}"
		[[ -n ${dep_use} ]] && dep_use="[$dep_use]"

		tmp=$(echo ${line} | cut -d " " -f 3 | sed -e "s/'//g")
		[[ ${tmp} != ${dep_pn} && ${tmp} != ${dep_use} && -n ${tmp} ]] && dep_ver="${tmp}"
		if [[ -n ${dep_ver} ]] ; then
			dep_op=">="
			dep_ver="-${dep_ver}"
		fi

		tmp=$(echo ${line} | cut -d " " -f 4 | sed -e "s/'//g")
		[[ ${tmp} != ${dep_pn} && ${tmp} != ${dep_use} && ${tmp} != ${dep_ver} ]] && dep_slot=${tmp}
		if [[ -n ${dep_slot} ]]; then
			dep_slot="\:${dep_slot}" # we need to escape it for the sed
		else
			dep_slot="\:5" # we need to escape it for the sed
		fi

		echo "${dep_op}${dep_cat}/${dep_pn}${dep_ver}${dep_slot}${dep_use}"
	}

	_modline() {
		sed -e "s:\$($1 $2):$4:" -i ${3}
	}

	while read line; do
		local ver="\${KFMIN}"
		[[ ${category} = kde-frameworks ]] && ver="\${PVCUT}"
		_modline add_frameworks_dep "${line}" ${pf} "$(_fqdndep kde-frameworks ${ver} "${line}")"
	done < <(grep -oP '(?<=\$\(add_frameworks_dep )[^\)]*' ${pf})

	while read line; do
		local ver="\${KDE_APPS_MINIMAL}"
		[[ ${category} = kde-apps ]] && ver="\${PVCUT}"
		_modline add_kdeapps_dep "${line}" ${pf} "$(_fqdndep kde-apps ${ver} "${line}")"
	done < <(grep -oP '(?<=\$\(add_kdeapps_dep )[^\)]*' ${pf})

	while read line; do
		local ver="\${PLASMA_MINIMAL}"
		[[ ${category} = kde-plasma ]] && ver="\${PVCUT}"
		_modline add_plasma_dep "${line}" ${pf} "$(_fqdndep kde-plasma ${ver} "${line}")"
	done < <(grep -oP '(?<=\$\(add_plasma_dep )[^\)]*' ${pf})

	while read line; do
		local ver="\${QTMIN}"
		_modline add_qt_dep "${line}" ${pf} "$(_fqdndep dev-qt ${ver} "${line}")"
	done < <(grep -oP '(?<=\$\(add_qt_dep )[^\)]*' ${pf})
}


SETNAME="$1"
VERSION="$2"

if [[ $1 == "--help" ]] ; then
	help
fi

if [[ -z "${SETNAME}" || -z "${VERSION}" ]] ; then
	echo ERROR: Not enough arguments
	echo
	help
fi

packages=$(get_package_list_from_set ${SETNAME})

for package in ${packages} ; do
	trap "echo Exited without finishing!; exit;" SIGINT SIGTERM
	pushd "${TARGET_REPO}/${package}" > /dev/null

	pn=$(basename $(pwd))

	for pf in ${pn}-${VERSION}.ebuild ${pn}-${VERSION}-r*.ebuild; do
		[[ -e ${pf} ]] || continue
		[[ -n $(grep -Eq "inherit.*kde5" ${pf}) ]] && continue
		addglobals ${package%/*} ${pf}
		[[ -n $(grep -Eq "(add_plasma_dep|kde-frameworks|add_plasma_dep|add_qt_dep)" ${pf}) ]] && continue
		modlines ${package%/*} ${pf}
	done

	popd > /dev/null
done
