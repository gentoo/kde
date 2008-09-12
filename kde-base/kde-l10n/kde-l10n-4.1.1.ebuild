# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

inherit kde4-base

DESCRIPTION="KDE internationalization package"
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2"

DEPEND="sys-devel/gettext"
RDEPEND=""

KEYWORDS="~amd64 ~x86"
IUSE=""

LNGS="bg ca cs csb da de el en_GB eo es et fi fr fy ga gl hi hu it ja kk km ko
ku lt lv mk ml nb nds nl nn pa pl pt pt_BR ru sl sr sv ta th tr uk wa zh_CN zh_TW"

URI_BASE="${SRC_URI/-${PV}.tar.bz2/}"
SRC_URI=""

for LNG in ${LNGS} ; do
	IUSE="${IUSE} linguas_${LNG}"
	SRC_URI="${SRC_URI} linguas_${LNG}? ( ${URI_BASE}/${PN}-${LNG}-${PV}.tar.bz2 )"
done

S="${WORKDIR}"

src_unpack() {
	local LNG
	local DIR
	if [[ -z ${A} ]]; then
		echo
		elog "You either have the LINGUAS variable unset, or it only"
		elog "contains languages not supported by ${P}."
		elog "You won't have any additional language support."
		echo
		elog "${P} supports these language codes:"
		elog "${LNGS}"
		echo
	fi

	[[ -n ${A} ]] && unpack ${A}
	cd "${S}"

	# add all linguas to cmake
	if [[ -n ${A} ]]; then
		for LNG in ${LINGUAS}; do
			DIR="${PN}-${LNG}-${PV}"
			[[ -d "${DIR}" ]] && echo "add_subdirectory( ${DIR} )" >> "${S}"/CMakeLists.txt
		done
	fi
}

src_compile() {
	[[ -n ${A} ]] && kde4-base_src_compile
}

src_install() {
	[[ -n ${A} ]] && kde4-base_src_install
}
