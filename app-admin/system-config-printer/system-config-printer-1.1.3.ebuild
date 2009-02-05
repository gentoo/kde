# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit python

DESCRIPTION="A printer administration tool"
HOMEPAGE="http://cyberelk.net/tim/software/system-config-printer/"
SRC_URI="http://cyberelk.net/tim/data/system-config-printer/1.1/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome-keyring nls"

RDEPEND="
	app-text/xmlto
	dev-lang/python
	dev-libs/libxml2[python]
	dev-python/dbus-python
	dev-python/libgnome-python
	dev-python/notify-python
	dev-python/pycups
	>=dev-python/pygtk-2.4
	dev-python/pyxml
	net-print/cups[dbus]
	gnome-keyring? ( dev-python/gnome-keyring-python )
"
DEPEND="${RDEPEND}
	nls? (
		dev-util/intltool
		sys-devel/gettext
	)
"

APP_LINGUAS="ar bg bn bn_IN bs ca cs cy da de el en_GB es et fa fi fr gu he hi
hr hu hy id is it ja ka kn ko lo lv mk ml mr ms nb nl nn pa pl pt pt_BR ro ru
si sk sl sr sv ta te tr uk vi zh_CN"
for X in ${APP_LINGUAS}; do
	IUSE="${IUSE} linguas_${X}"
done

pkg_setup() {
	if (use nls && [ -z "${LINGUAS}" ]) || (! use nls && [ -n "${LINGUAS}" ]); then
		echo
		ewarn "To get localized build, enable nls support and set LINGUAS variable appropriately."
		echo
	fi
}

src_configure() {
	local myconf

	# enable nls only when any LINGUAS set
	if use nls && [ -z "${LINGUAS}" ]; then
		myconf="${myconf} --disable-nls"
	else
		myconf="${myconf} $(use_enable nls)"
	fi

	econf ${myconf} || die "econf failed"
}

src_install() {
	dodoc AUTHORS ChangeLog README || die "dodoc failed"

	emake DESTDIR="${D}" install || die "emake install failed"
}

pkg_postrm() {
	python_mod_cleanup "/usr/share/${PN}"
}
