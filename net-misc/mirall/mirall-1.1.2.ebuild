# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/mirall/mirall-1.1.1-r1.ebuild,v 1.2 2012/11/30 06:02:43 creffett Exp $

EAPI=5

LANG_DIR="translations"
PLOCALES="ca cs_CZ da de el en eo es es_AR et_EE eu fa fi_FI fr gl he hr hu_HU it ja_JP ko lb lt_LT mk
nb_NO nl oc pl pt_BR pt_PT ro ru ru_RU sk_SK sl sr@latin sv ta_LK tr uk vi zh_CN zh_TW"
inherit cmake-utils l10n

DESCRIPTION="Synchronization of your folders with another computers"
HOMEPAGE="http://owncloud.org/"
SRC_URI="http://download.owncloud.com/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=net-misc/csync-0.60.2
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-test:4
"
DEPEND="${RDEPEND}"

src_prepare() {
	# Yay for fcked detection.
	export CSYNC_DIR="${EPREFIX}/usr/include/ocsync/"

	local lang
	for lang in ${PLOCALES} ; do
		if ! use linguas_${lang} ; then
			rm ${LANG_DIR}/${PN}_${lang}.ts
		fi
	done
}

pkg_postinst() {
	if ! has_version net-misc/csync[samba]; then
		elog "For samba support, build net-misc/csync with USE=samba"
	fi
	if ! has_version net-misc/csync[sftp]; then
		elog "For sftp support, build net-misc/csync with USE=sftp"
	fi
}
