# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/telepathy-glib/telepathy-glib-0.14.7.ebuild,v 1.1 2011/06/03 17:01:40 pacho Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"

inherit python virtualx

DESCRIPTION="GLib bindings for the Telepathy D-Bus protocol."
HOMEPAGE="http://telepathy.freedesktop.org"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="debug +introspection +vala"

# Tests fail in /stream-tube/creation
RESTRICT="test"
RDEPEND=">=dev-libs/glib-2.25.16:2
	>=dev-libs/dbus-glib-0.82
	introspection? ( >=dev-libs/gobject-introspection-0.9.6 )
	vala? (
		dev-lang/vala:0.12[vapigen]
		>=dev-libs/gobject-introspection-0.9.6 )"
DEPEND="${RDEPEND}
	dev-libs/libxslt
	>=dev-util/pkgconfig-0.21"

src_prepare() {
	python_convert_shebangs -r 2 examples tests tools
	default_src_prepare
}

src_configure() {
	local myconf

	if use vala; then
		myconf="--enable-introspection
			VALAC=$(type -p valac-0.12)
			VAPIGEN=$(type -p vapigen-0.12)"
	fi

	econf --disable-static \
		PYTHON=$(PYTHON -2 -a) \
		$(use_enable debug backtrace) \
		$(use_enable debug handle-leak-debug) \
		$(use_enable debug debug-cache) \
		$(use_enable introspection) \
		$(use_enable vala vala-bindings) \
		${myconf}
}

src_test() {
	# Needs dbus for tests (auto-launched)
	Xemake -j1 check || die
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README || die "dodoc failed"

	find "${ED}" -name '*.la' -exec rm -f '{}' + || die
}
