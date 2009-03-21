# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="KDE internationalization package"
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2"

KEYWORDS="~amd64 ~x86"
IUSE=""

SRC_URI=""

DEPEND=">=sys-devel/gettext-0.17"

LANGS="af ar be bg bn bn_IN br ca cs csb cy da de el en_GB eo es et eu fa fi fr
	fy ga gl gu he hi hr hsb hu hy is it ja ka kk km kn ko ku lb lt lv mk ml
	ms mt nb nds ne nl nn nso oc pa pl pt pt_BR ro ru rw se sk sl sr sv ta te tg
	th tr uk uz vi wa xh zh_CN zh_HK zh_TW"

SRC_URI=""

for LNG in ${LANGS}; do
	IUSE="${IUSE} linguas_${LNG}"
	SRC_URI="${SRC_URI} linguas_${LNG}? ( http://dev.gentooexperimental.org/~alexxy/kde/${PV}/${PN}/${PN}-${LNG}-${PV}.tar.lzma )"
done

S="${WORKDIR}"

pkg_setup() {
	local lng
	for lng in ${LINGUAS}; do
		enabled_linguas+=" ${lng}"
	done
	if [[ -z ${enabled_linguas} ]]; then
		elog
		elog "You either have the LINGUAS variable unset, or it only"
		elog "contains languages not supported by ${P}."
		elog "You won't have any additional language support."
		elog
		elog "${P} supports these language codes:"
		elog "${LANGS}"
		elog
	fi
	kde4-base_pkg_setup
}

src_unpack() {
	local lng

	for lng in ${enabled_linguas}; do
		[[ -n ${A} ]] && unpack ${A}
	done
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

		for lng in ${enabled_linguas} ; do
			"${S}"/kde-l10n-${lng}-${PV}/scripts/scripts/autogen.sh kde-l10n-${lng}-${PV}
			echo "add_subdirectory( kde-l10n-${lng}-${PV} )" >> "${S}"/CMakeLists.txt
			sed -i -e "s:kde-l10n-${lng}-${PV}:${lng}:g"  "${S}"/kde-l10n-${lng}-${PV}/CMakeLists.txt
		done
		kde4-base_src_configure
	fi
}

src_compile() {
	[[ -z ${enabled_linguas} ]] || kde4-base_src_compile
}

src_install() {
	[[ -z ${enabled_linguas} ]] || kde4-base_src_install
}
