# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit autotools eutils versionator

DESCRIPTION="Library to raise flags on DBus for other components of the desktop to pick up and visualize"
HOMEPAGE="https://launchpad.net/libindicate/"
SRC_URI="http://launchpad.net/${PN}/$(get_version_component_range 1-2)/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

# They put their mother in the tarball ? ^^
RESTRICT="test"

# For the dependency on dev-libs/libdbusmenu see launchpad-bug #552667
RDEPEND="dev-libs/glib:2
	dev-libs/dbus-glib
	dev-libs/libdbusmenu
	dev-libs/libxml2:2
	x11-libs/gtk+:2
	dev-python/pygtk
	dev-dotnet/gtk-sharp
	dev-dotnet/gtk-sharp-gapi"
DEPEND="${RDEPEND}
	doc? ( dev-util/gtk-doc )
	dev-util/gtk-doc-am
	dev-util/pkgconfig"

src_prepare() {
	# Without patches:
	# Make python optional, launchpad-bug #643921
	# Make mono optional, launchpad-bug #643922

	# Incomplete patches:
	# Make gtk optional, needs optional-python or code modifications, launchpad-bug #431311
	#epatch "${FILESDIR}/${P}-optional-gtk.patch"

	# Make doc optional, launchpad-bug #643911
	epatch "${FILESDIR}/${P}-optional-doc.patch"
	# Do not compile mono-example by default, launchpad-bug #643912
	epatch "${FILESDIR}/${P}-optional-mono-example.patch"
	# Do not compile examples by default, launchpad-bug #643917
	epatch "${FILESDIR}/${P}-optional-examples.patch"
	# Fix trouble with autoreconf and m4 directory, launchpad-bug #683552
	epatch "${FILESDIR}/${P}-fix-aclocal.patch"
	# Fixup undeclared HAVE_INTROSPECTION, launchpad-bug #552537
	epatch "${FILESDIR}/${P}-fix-introspection.patch"
	# Fix out-of-source builds, launchpad-bug #643913
	epatch "${FILESDIR}/${P}-fix-out-of-source-build.patch"
	# Fix compilation for python != 2.6, launchpad-bug #594992
	epatch "${FILESDIR}/${P}-fix-python-version.patch"
	# Drop -Werror in a release
	sed -e 's:-Werror::g' -i libindicate/Makefile.am libindicate-gtk/Makefile.am || die "sed failed"
	eautoreconf
}

src_configure() {
	# gobject-instrospection is a nightmare in this package, it's fixable for libindicate
	# and not for libindicate-gtk, disable it until its fixed on upstream
	econf \
		--disable-dependency-tracking \
		--docdir=/usr/share/doc/${PF} \
		$(use_enable doc) \
		|| die "configure failed"
}

src_test() {
	emake check || die "testsuite failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS || die "dodoc failed"
}
