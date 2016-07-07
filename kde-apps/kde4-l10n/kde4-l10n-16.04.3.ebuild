# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_HANDBOOK="optional"
KMNAME="kde-l10n"
inherit kde4-base

DESCRIPTION="KDE internationalization package"
HOMEPAGE="http://l10n.kde.org"

KEYWORDS="~amd64 ~arm ~x86"

DEPEND="
	sys-devel/gettext
"
RDEPEND="
	>=kde-apps/kde-l10n-${PV}
"

REMOVE_DIRS="${FILESDIR}/${PN}-16.04.1-remove-dirs"
REMOVE_MSGS="${FILESDIR}/${PN}-16.03.91-remove-messages"

# /usr/portage/distfiles $ ls -1 kde-l10n-*-${PV}.* |sed -e 's:-${PV}.tar.xz::' -e 's:kde-l10n-::' |tr '\n' ' '
MY_LANGS="ar ast bg bs ca ca@valencia cs da de el en_GB eo es et eu fa fi fr ga
gl he hi hr hu ia id is it ja kk km ko lt lv mr nb nds nl nn pa pl pt pt_BR ro
ru sk sl sr sv tr ug uk wa zh_CN zh_TW"

# TODO: Drop no-op +minimal in 16.08.x - necessary kde5.eclass change happened after KF-5.23/Plasma-5.6.5
IUSE="+minimal test $(printf 'l10n_%s ' ${MY_LANGS//[@_]/-})"

URI_BASE="${SRC_URI/-${PV}.tar.xz/}"
LURI_BASE="mirror://kde/stable/${LV}/src/${KMNAME}"
SRC_URI=""

for MY_LANG in ${MY_LANGS} ; do
	SRC_URI="${SRC_URI} l10n_${MY_LANG/[@_]/-}? ( ${URI_BASE}/${KMNAME}-${MY_LANG}-${PV}.tar.xz )"
done

S="${WORKDIR}"

pkg_setup() {
	if [[ -z ${A} ]]; then
		elog
		elog "None of the requested L10N are supported by ${P}."
		elog
		elog "${P} supports these language codes:"
		elog "${MY_LANGS//[@_]/-}"
		elog
	fi
	[[ -n ${A} ]] && kde4-base_pkg_setup
}

src_unpack() {
	for my_tar in ${A}; do
		tar -xpf "${DISTDIR}/${my_tar}" --xz \
			"${my_tar/.tar.xz/}/CMakeLists.txt" "${my_tar/.tar.xz/}/4" 2> /dev/null ||
			elog "${my_tar}: tar extract command failed at least partially - continuing"
	done
}

src_prepare() {
	default
	[[ -n ${A} ]] || return

	# L10N=sr variants are subdirs within sr/ ...
	if [[ -d "${KMNAME}-sr-${PV}" ]] ; then
		for variant in "${KMNAME}"-sr-${PV}/4/sr/sr@*; do
			mkdir -p "${KMNAME}-${variant##*/}-${PV}/4" ||
				die "Failed to create L10N=${variant##*/} subdir"
			mv ${variant} "${KMNAME}-${variant##*/}-${PV}/4/${variant##*/}" ||
				die "Failed to move L10N=${variant##*/}"
			cp -f "${KMNAME}-sr-${PV}"/CMakeLists.txt "${KMNAME}-${variant##*/}-${PV}" ||
				die "Failed to prepare L10N=${variant##*/} subdir"
			echo "add_subdirectory(${variant##*/})" > "${KMNAME}-${variant##*/}-${PV}"/4/CMakeLists.txt ||
				die "Failed to prepare L10N=${variant##*/} subdir"
			cp -f "${KMNAME}-sr-${PV}"/4/sr/CMakeLists.txt "${KMNAME}-${variant##*/}-${PV}"/4/${variant##*/} ||
				die "Failed to prepare L10N=${variant##*/} subdir"
			sed -e "/^macro.*sr/d" \
				-e "s/sr/${variant##*/}/" \
				-i "${KMNAME}-${variant##*/}-${PV}"/4/${variant##*/}/CMakeLists.txt ||
				die "Failed to prepare L10N=${variant##*/} subdir"
		done
	fi

	# add all l10n to cmake
	cat <<-EOF > CMakeLists.txt || die
project(kde4-l10n)
cmake_minimum_required(VERSION 2.8.12)
$(printf "add_subdirectory( %s )\n" `find . -mindepth 1 -maxdepth 1 -type d -name "*${PV}*"`)
EOF

	# Drop KF5-based part
	find -maxdepth 2 -type f -name CMakeLists.txt -exec \
		sed -i -e "/add_subdirectory(5)/ s/^/#DONT/" {} + || die

	einfo "Removing file collisions with Plasma 5 and Applications"
	use test && einfo "Tests enabled: Listing LINGUAS causing file collisions"

	einfo "Directories..."
	while read path; do
		if use test ; then	# build a report w/ L10N="*" to submit @upstream
			local lngs
			for lng in ${MY_LANGS}; do
				SDIR="${S}/${KMNAME}-${lng}-${PV}/4/${lng}"
				if [[ -d "${SDIR}"/${path%\ *}/${path#*\ } ]] ; then
					lngs+=" ${lng}"
				fi
			done
			[[ -n "${lngs}" ]] && einfo "${path%\ *}/${path#*\ }${lngs}"
			unset lngs
		fi
		if ls -U ./*/4/*/${path%\ *}/${path#*\ } > /dev/null 2>&1; then
			sed -e "\:add_subdirectory(\s*${path#*\ }\s*): s:^:#:" \
				-i ./*/4/*/${path%\ *}/CMakeLists.txt || \
				die "Failed to comment out ${path}"
		else
			einfo "F: ${path}"	# run with L10N="*" to cut down list
		fi
	done < <(grep -ve "^$\|^\s*\#" "${REMOVE_DIRS}")
	einfo
	einfo "Messages..."
	while read path; do
		if use test ; then	# build a report w/ L10N="*" to submit @upstream
			local lngs
			for lng in ${MY_LANGS}; do
				SDIR="${S}/${KMNAME}-${lng}-${PV}/4/${lng}"
				if [[ -e "${SDIR}"/messages/${path} ]] ; then
					lngs+=" ${lng}"
				fi
			done
			[[ -n "${lngs}" ]] && einfo "${path}${lngs}"
			unset lngs
		fi
		if ls -U ./*/4/*/messages/${path} > /dev/null 2>&1; then
			rm ./*/4/*/messages/${path} || die "Failed to remove ${path}"
		else
			einfo "F: ${path}"	# run with L10N="*" to cut down list
		fi
	done < <(grep -ve "^$\|^\s*\#" "${REMOVE_MSGS}")
}

src_configure() {
	mycmakeargs=(
		-DBUILD_docs=$(usex handbook)
	)
	[[ -n ${A} ]] && kde4-base_src_configure
}

src_compile() {
	[[ -n ${A} ]] && kde4-base_src_compile
}

src_test() { :; }

src_install() {
	[[ -n ${A} ]] && kde4-base_src_install
}
