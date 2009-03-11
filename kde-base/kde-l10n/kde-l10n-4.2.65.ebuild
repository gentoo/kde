# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde-l10n/kde-l10n-4.2.1.ebuild,v 1.1 2009/03/04 21:00:29 alexxy Exp $

EAPI="2"

inherit kde4-base

DESCRIPTION="KDE internationalization package"
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2"

DEPEND="sys-devel/gettext"
RDEPEND=""

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

MY_LANGS="af ar be bg bn bn_IN br ca cs csb cy da de el en_GB eo es et eu
		fa fi fr fy ga gl gu he hi hr hsb hu hy is it ja ka kk km kn ko ku lb lt lv mk ml
	    ms mt nb nds ne nl nn nso oc pa pl pt pt_BR ro ru rw se sk sl sr sv ta 	te tg
	    th tr uk uz vi wa xh zh_CN zh_HK zh_TW"

URI_BASE="${SRC_URI/-${PV}.tar.lzma/}"
SRC_URI=""

for MY_LANG in ${MY_LANGS} ; do
	IUSE="${IUSE} linguas_${MY_LANG}"
	SRC_URI="${SRC_URI} linguas_${MY_LANG}? ( ${URI_BASE}/${PN}-${MY_LANG}-${PV}.tar.lzma )"
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

	[[ -n ${A} ]] && unpack ${A}
} 

src_configure() {
	    local lng
	    if [[ ! -z ${enabled_linguas} ]]; then
			cat <<-EOF > "${S}"/CMakeLists.txt
			project(kde-l10n)
			find_package(KDE4 REQUIRED)
			include (KDE4Defaults)
			include(MacroOptionalAddSubdirectory)
			find_package(Gettext REQUIRED)
			EOF
		
			for	lng in ${enabled_linguas} ; do
				"${S}"/scripts/autogen.sh ${lng}
				echo "add_subdirectory( ${lng} )" >> "${S}"/CMakeLists.txt
			done
			kde4-base_src_configure
		fi
}

src_compile() {
	[[ -n ${A} ]] && kde4-base_src_compile
}

src_install() {
	[[ -n ${A} ]] && kde4-base_src_install
}
