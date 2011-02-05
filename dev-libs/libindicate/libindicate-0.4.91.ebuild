# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libindicate/libindicate-0.4.4.ebuild,v 1.1 2011/01/17 09:34:20 tampakrap Exp $

EAPI=2

inherit autotools eutils versionator

MY_MAJOR_VERSION="$(get_version_component_range 1-2)"
if version_is_at_least "${MY_MAJOR_VERSION}.50" ; then
	MY_MAJOR_VERSION="$(get_major_version).$(($(get_version_component_range 2)+1))"
fi

BROKEN_MONO="0.4.91"

DESCRIPTION="Library to raise flags on DBus for other components of the desktop to pick up and visualize"
HOMEPAGE="https://launchpad.net/libindicate/"
SRC_URI="http://launchpad.net/${PN}/${MY_MAJOR_VERSION}/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc gtk +introspection mono python"

RESTRICT="test"

# For the dependency on dev-libs/libdbusmenu see launchpad-bug #552667
RDEPEND="dev-libs/glib:2[introspection=]
	dev-libs/dbus-glib
	>=dev-libs/libdbusmenu-0.3.90[introspection=]
	dev-libs/libxml2:2
	x11-libs/gtk+:2
	python? ( dev-python/pygtk )
	mono? (
		dev-dotnet/gtk-sharp
		dev-dotnet/gtk-sharp-gapi
	)"
DEPEND="${RDEPEND}
	doc? ( dev-util/gtk-doc )
	introspection? ( >=dev-libs/gobject-introspection-0.6.7 )
	dev-util/gtk-doc-am
	dev-util/pkgconfig"

pkg_setup() {
	if use mono && has "${PV}" "${BROKEN_MONO}" ; then
		eerror "Mono bindings (USE=mono) are broken in this version"
		die "Mono bindings (USE=mono) are broken in this version"
	fi
	if use python && use !gtk ; then
		eerror "Python bindings (USE=python) require GTK support (USE=gtk)"
		die "Python bindings (USE=python) require GTK support (USE=gtk)"
	fi
}

src_prepare() {
	# Make python optional, launchpad-bug #643921
	epatch "${FILESDIR}/${P}-optional-python.patch"
	# Restore SUBDIRS to make optional-mono apply
	sed -i bindings/Makefile.am \
		-e 's/^SUBDIRS =.*/SUBDIRS = mono python/'
	# Make mono optional, launchpad-bug #643922
	epatch "${FILESDIR}/${P}-optional-mono.patch"
	# Make SUBDIRS empty, after applying optional-python and optional-mono
	sed -i bindings/Makefile.am \
		-e 's/^SUBDIRS =.*/SUBDIRS = $(MONO_SUBDIR) $(PYTHON_SUBDIR)/'
	# Make gtk optional, launchpad-bug #431311
	epatch "${FILESDIR}/${PN}-0.4.4-optional-gtk.patch"
	# Make doc optional, launchpad-bug #643911
	epatch "${FILESDIR}/${PN}-0.4.4-optional-doc.patch"
	# Do not compile mono-example by default, launchpad-bug #643912
	epatch "${FILESDIR}/${PN}-0.4.4-optional-mono-example.patch"
	# Do not compile examples by default, launchpad-bug #643917
	epatch "${FILESDIR}/${PN}-0.4.4-optional-examples.patch"
	# Fix trouble with autoreconf and m4 directory, launchpad-bug #683552
	epatch "${FILESDIR}/${PN}-0.4.4-fix-aclocal.patch"
	# Fixup undeclared HAVE_INTROSPECTION, launchpad-bug #552537
	epatch "${FILESDIR}/${PN}-0.4.4-fix-introspection.patch"
	# Fix out-of-source builds, launchpad-bug #643913
	epatch "${FILESDIR}/${PN}-0.4.4-fix-out-of-source-build.patch"
	# Fix python version detection, launchpad-bug #594992
	epatch "${FILESDIR}/${P}-fix-python-version.patch"
	# Fix parallel-make for mono bindings, launchpad-bug #709954
	epatch "${FILESDIR}/${PN}-0.4.4-mono-parallel-make.patch"
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
		$(use_enable introspection) \
		$(use_enable mono) \
		$(use_enable python) \
		${conf} || die "configure failed"
}

src_test() {
	emake check || die "testsuite failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS || die "dodoc failed"
}
