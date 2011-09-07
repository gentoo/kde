# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
KDE_MINIMAL="4.6"

inherit kde4-base

DESCRIPTION="KDE PIM internationalization package"
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2"

DEPEND="
	sys-devel/gettext
"
RDEPEND=""

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

MY_LANGS="ar bg ca ca@valencia cs da de el en_GB es et eu
		fi fr ga gl gu he hi hr hu ia id is it ja kk km kn ko lt lv
		mai nb nds nl nn pa pl pt pt_BR ro ru sk sl sr sv th
		tr uk wa zh_CN zh_TW"

URI_BASE="${SRC_URI/-${PV}.tar.bz2/}"
SRC_URI=""

for MY_LANG in ${MY_LANGS} ; do
	IUSE="${IUSE} linguas_${MY_LANG}"
	SRC_URI="${SRC_URI} linguas_${MY_LANG}? (
	${URI_BASE}/kde-l10n-${MY_LANG}-4.6.5.tar.bz2 )"
done

S="${WORKDIR}"

src_unpack() {
	local LNG DIR
	if [[ -z ${A} ]]; then
		elog
		elog "You either have the LINGUAS variable unset, or it only"
		elog "contains languages not supported by ${P}."
		elog "You won't have any additional language support."
		elog
		elog "${P} supports these language codes:"
		elog "${MY_LANGS}"
		elog
	fi

	# For EAPI >= 3, or if not using .tar.xz archives:
	[[ -n ${A} ]] && unpack ${A}
	cd "${S}"

	# for all linguas do:
	if [[ -n ${A} ]]; then
		for LNG in ${LINGUAS}; do
			einfo "Processing ${LNG} localization"
			DIR="kde-l10n-${LNG}-4.6.5"

			# add subdir to toplevel cmake file
			if [[ -d "${DIR}" ]] ; then
				echo "add_subdirectory( ${DIR} )" >> "${S}"/CMakeLists.txt
			fi

			# remove everything except kdepim
			for SUBDIR in data docs messages scripts ; do
				if [[ -d "${S}/${DIR}/${SUBDIR}" ]] ; then
					einfo "   ${SUBDIR} subdirectory"
					echo > "${S}/${DIR}/${SUBDIR}/CMakeLists.txt"
					[[ -d "${S}/${DIR}/${SUBDIR}/kdepim" ]] && ( echo "add_subdirectory(kdepim)" >> "${S}/${DIR}/${SUBDIR}/CMakeLists.txt" )
				fi
			done

			# in some cases we may have sub-lingua subdirs, e.g. sr :(
			for XSUBDIR in "${S}/${DIR}/${LNG}"@* ; do
				XLNG=$(echo ${XSUBDIR}|sed -e 's:^.*/::')
				if [[ -d "${XSUBDIR}" ]] ; then
					einfo "   ${XLNG} variant"
					# remove everything except kdepim
					for SUBDIR in data docs messages scripts ; do
						if [[ -d "${XSUBDIR}/${SUBDIR}" ]] ; then
							einfo "      ${SUBDIR} subdirectory"
							echo > "${XSUBDIR}/${SUBDIR}/CMakeLists.txt"
							[[ -d "${XSUBDIR}/${SUBDIR}/kdepim" ]] && ( echo "add_subdirectory(kdepim)" >> "${XSUBDIR}/${SUBDIR}/CMakeLists.txt" )
						fi
					done
				fi
			done
		done
	fi
}

src_prepare() {
	[[ -n ${A} ]] && kde4-base_src_prepare
}

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DBUILD_docs=OFF"
	[[ -n ${A} ]] && kde4-base_src_configure
}

src_compile() {
	[[ -n ${A} ]] && kde4-base_src_compile
}

src_test() {
	[[ -n ${A} ]] && kde4-base_src_test
}

src_install() {
	[[ -n ${A} ]] && kde4-base_src_install
}
