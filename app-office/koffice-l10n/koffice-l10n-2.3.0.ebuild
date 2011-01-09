# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/koffice-l10n/koffice-l10n-2.1.1.ebuild,v 1.1 2010/02/27 22:35:17 ssuominen Exp $

EAPI="2"

inherit kde4-base

DESCRIPTION="KOffice localization package"
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2"

DEPEND="sys-devel/gettext"
RDEPEND=""

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="doc"

MY_LANGS="ca ca@valencia da de el en_GB es et fr gl hu it ja kk nb nds nl pt pt_BR
	ru sv tr uk zh_CN zh_TW"
URI_BASE="mirror://kde/stable/koffice-${PV}/${PN}/"
SRC_URI=""
SLOT="2"

for MY_LANG in ${MY_LANGS} ; do
	IUSE="${IUSE} linguas_${MY_LANG}"
	SRC_URI="${SRC_URI} linguas_${MY_LANG}? ( ${URI_BASE}/${PN}-${MY_LANG}-${PV}.tar.bz2 )"
done

S="${WORKDIR}"

src_unpack() {
	local lng dir
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

	[[ -n ${A} ]] && unpack ${A}
	cd "${S}"

	# add all linguas to cmake
	if [[ -n ${A} ]]; then
		for lng in ${MY_LANGS}; do
			dir="${PN}-${lng}-${PV}"
			if [[ -d "${dir}" ]] ; then
				echo "add_subdirectory( ${dir} )" >> "${S}"/CMakeLists.txt
			fi
		done
	fi
}

src_configure() {
	local mycmakeargs

	mycmakeargs="${mycmakeargs} -DBUILD_MESSAGES=ON -DBUILD_DATA=ON
		$(cmake-utils_use_build doc)"
	[[ -e "${S}"/CMakeLists.txt ]] && kde4-base_src_configure
}

src_compile() {
	[[ -e "${S}"/CMakeLists.txt ]] && kde4-base_src_compile
}

src_test() {
	[[ -e "${S}"/CMakeLists.txt ]] && kde4-base_src_test
}

src_install() {
	[[ -e "${S}"/CMakeLists.txt ]] && kde4-base_src_install
}
