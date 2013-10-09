# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde-l10n/kde-l10n-4.11.1.ebuild,v 1.1 2013/09/03 19:04:47 creffett Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="KDE internationalization package"
HOMEPAGE="http://l10n.kde.org"

DEPEND="
	sys-devel/gettext
"
RDEPEND="!<kde-base/konq-plugins-4.6"

KEYWORDS=" ~amd64 ~arm ~ppc ~ppc64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="+handbook"

# /usr/portage/distfiles $ ls -1 kde-l10n-*-${PV}.* |sed -e 's:-${PV}.tar.xz::' -e 's:kde-l10n-::' |tr '\n' ' '
MY_LANGS="ar bg bs ca ca@valencia cs da de el en_GB es et eu fa fi fr ga gl he
hi hr hu ia is it ja kk km ko lt lv mr nb nds nl nn pa pl pt pt_BR ro ru sk sl
sr sv tg tr ug uk vi wa zh_CN zh_TW"

URI_BASE="${SRC_URI/-${PV}.tar.xz/}"
SRC_URI=""

for MY_LANG in ${MY_LANGS} ; do
	IUSE="${IUSE} linguas_${MY_LANG}"
	SRC_URI="${SRC_URI} linguas_${MY_LANG}? ( ${URI_BASE}/${PN}-${MY_LANG}-${PV}.tar.xz )"
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

src_prepare() {
	find "${S}" -name CMakeLists.txt -type f \
		-exec sed -i -e 's:^ *add_subdirectory( *kdepim-runtime *):# no kdepim-runtime:g' {} +
	find "${S}" -name CMakeLists.txt -type f \
		-exec sed -i -e 's:^ *add_subdirectory( *kdepim *):# no kdepim:g' {} +

	# bug 481106, please remove in 4.11.1 and later
	use linguas_pl && rm "${S}"/${PN}-pl-${PV}/messages/kde-runtime/{accountwizard*,akonadi_*}.po

	kde4-base_src_prepare
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_build handbook docs)
	)
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
