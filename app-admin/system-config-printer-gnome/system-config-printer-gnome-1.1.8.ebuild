# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit python autotools

MY_P="${PN%-gnome}-${PV}"

DESCRIPTION="Gnome frontend for a Red Hat's printer administration tool"
HOMEPAGE="http://cyberelk.net/tim/software/system-config-printer/"
SRC_URI="http://cyberelk.net/tim/data/system-config-printer/1.1/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="gnome-keyring"

COMMON_DEPEND="
	dev-lang/python
"
DEPEND="${COMMON_DEPEND}
	app-text/docbook-xml-dtd:4.1.2
	app-text/xmlto
	dev-util/intltool
	virtual/libintl
"
RDEPEND="${COMMON_DEPEND}
	>=app-admin/system-config-printer-common-${PV}
	dev-python/libgnome-python
	dev-python/notify-python
	>=dev-python/pygtk-2.4
	dev-python/pyxml
	gnome-keyring? ( dev-python/gnome-keyring-python )
"

APP_LINGUAS="ar as bg bn bn_IN bs ca cs cy da de el en_GB es et fa fi fr gu he hi
hr hu hy id is it ja ka kn ko lo lv mk ml mr ms nb nl nn or pa pl pt pt_BR ro ru
si sk sl sr sv ta te th tr uk vi zh_CN"
for X in ${APP_LINGUAS}; do
	IUSE="${IUSE} linguas_${X}"
done

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}/${P}-split.patch"

	eaclocal
	eautomake
	eautoconf
}

src_configure() {
	local myconf

	# disable installation of translations when LINGUAS not chosen
	if [[ -z "${LINGUAS}" ]]; then
		myconf="${myconf} --disable-nls"
	else
		myconf="${myconf} --enable-nls"
	fi

	econf ${myconf} || die "econf failed"
}

src_install() {
	dodoc AUTHORS ChangeLog README || die "dodoc failed"

	emake DESTDIR="${D}" install || die "emake install failed"
}
