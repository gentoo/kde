# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libdbusmenu/libdbusmenu-0.3.16-r2.ebuild,v 1.1 2011/02/07 09:56:46 tampakrap Exp $

EAPI=3

inherit autotools eutils versionator virtualx

MY_MAJOR_VERSION="$(get_version_component_range 1-2)"
if version_is_at_least "${MY_MAJOR_VERSION}.50" ; then
	MY_MAJOR_VERSION="$(get_major_version).$(($(get_version_component_range 2)+1))"
fi

DESCRIPTION="Library to pass menu structure across DBus"
HOMEPAGE="https://launchpad.net/dbusmenu"
SRC_URI="http://launchpad.net/dbusmenu/${MY_MAJOR_VERSION}/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk +introspection test vala"

RDEPEND="dev-libs/glib:2
	dev-libs/dbus-glib
	dev-libs/libxml2:2
	gtk? ( x11-libs/gtk+:2 )"
DEPEND="${RDEPEND}
	introspection? ( >=dev-libs/gobject-introspection-0.6.7 )
	test? (
		dev-libs/json-glib[introspection=]
		dev-util/dbus-test-runner
	)
	vala? ( dev-lang/vala:0.10 )
	dev-util/intltool
	dev-util/pkgconfig"

pkg_setup() {
	if use vala && use !introspection ; then
		eerror "Vala bindings (USE=vala) require introspection support (USE=introspection)"
		die "Vala bindings (USE=vala) require introspection support (USE=introspection)"
	fi
}

src_configure() {
	VALA_API_GEN=$(type -p vapigen-0.10) \
		econf \
		--with-gtk=2 \
		$(use_enable gtk) \
		$(use_enable gtk dumper) \
		$(use_enable introspection) \
		$(use_enable test tests) \
		$(use_enable vala)
}

src_test() {
	Xemake check || die "testsuite failed"
}

src_install() {
	emake DESTDIR="${ED}" install || die "make install failed"
	dodoc AUTHORS || die "dodoc failed"
}
