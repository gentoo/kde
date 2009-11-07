# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde-l10n/kde-l10n-4.3.3.ebuild,v 1.1 2009/11/02 20:57:08 wired Exp $

EAPI="2"

inherit kde4-base

DESCRIPTION="KDE internationalization package"
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2"

DEPEND="
	app-arch/xz-utils
	sys-devel/gettext
"
RDEPEND=""

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="+handbook"

MY_LANGS="af ar be bg bn bn_IN br ca cs csb cy da de el en_GB eo es et eu fa fi
			fr fy ga gl gu he hi hne hsb hr hu hy is it ja ka kk km kn ko ku lb
			lt lv mai mk ml mr ms mt nb nds ne nl nn nso oc pa pl pt pt_BR ro ru
			rw se sk sl sr sv ta te tg th tr uk uz vi wa xh	zh_CN zh_HK zh_TW"

SRC_URI=""

for MY_LANG in ${MY_LANGS} ; do
	IUSE="${IUSE} linguas_${MY_LANG}"
	SRC_URI="${SRC_URI} linguas_${MY_LANG}? ( http://dev.gentooexperimental.org/~alexxy/kde/${PV}/${PN}/${PN}-${MY_LANG}-${PV}.tar.xz )"
done

S="${WORKDIR}"

src_unpack() {
	local LNG DIR file
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

	for file in ${A}; do
		echo ">>> Unpacking ${file} to ${PWD}"
		xz -dc "${DISTDIR}"/${file} | tar xof -
		assert "failed unpacking ${file}"
	done
	# For EAPI >= 3, or if not using .tar.xz archives:
	# [[ -n ${A} ]] && unpack ${A}
	cd "${S}"

	# add all linguas to cmake
	if [[ -n ${A} ]]; then
		for LNG in ${LINGUAS}; do
			DIR="${PN}-${LNG}-${PV}"
			if [[ -d "${DIR}" ]] ; then
				echo "add_subdirectory( ${DIR} )" >> "${S}"/CMakeLists.txt
			fi
		done
	fi
}

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_build handbook docs)"
	[[ -n ${A} ]] && kde4-base_src_configure
}

src_compile() {
	[[ -n ${A} ]] && kde4-base_src_compile
}

src_install() {
	[[ -n ${A} ]] && kde4-base_src_install
}
