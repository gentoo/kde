# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

RESTRICT="test" # tests are failing atm

inherit autotools-utils multilib python nsplugins

MY_PN="PackageKit"
MY_P=${MY_PN}-${PV}

DESCRIPTION="Manage packages in a secure way using a cross-distro and cross-architecture API"
HOMEPAGE="http://www.packagekit.org/"
SRC_URI="http://www.packagekit.org/releases/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="connman cron gtk +introspection networkmanager nls nsplugin pm-utils
+policykit qt4 static-libs test udev"

CDEPEND="
	dev-db/sqlite:3
	>=dev-libs/dbus-glib-0.74
	>=dev-libs/glib-2.16.1:2
	>=sys-apps/dbus-1.2.24
	connman? ( net-misc/connman )
	gtk? (
		dev-libs/dbus-glib
		media-libs/fontconfig
		>=x11-libs/gtk+-2.14.0:2
		x11-libs/pango
	)
	introspection? ( dev-libs/gobject-introspection )
	networkmanager? ( >=net-misc/networkmanager-0.6.4 )
	nsplugin? (
		dev-libs/dbus-glib
		dev-libs/glib:2
		dev-libs/nspr
		x11-libs/cairo
		>=x11-libs/gtk+-2.14.0:2
		x11-libs/pango
	)
	policykit? ( >=sys-auth/polkit-0.96 )
	qt4? (
		>=x11-libs/qt-core-4.4.0
		>=x11-libs/qt-dbus-4.4.0
		>=x11-libs/qt-sql-4.4.0
	)
	udev? ( >=sys-fs/udev-145[extras] )
"
DEPEND="${CDEPEND}
	dev-libs/libxslt
	>=dev-util/intltool-0.35.0
	dev-util/pkgconfig
	sys-devel/gettext
	nsplugin? ( >=net-libs/xulrunner-1.9.1 )
	test? (
		qt4? (
			dev-util/cppunit
			>=x11-libs/qt-gui-4.4.0
		)
	)
"
RDEPEND="${CDEPEND}
	>=app-portage/layman-1.2.3
	sys-apps/portage
	pm-utils? ( sys-power/pm-utils )
"

S="${WORKDIR}/${MY_P}"

# NOTES:
# mono doesn't install anything (RDEPEND dev-dotnet/gtk-sharp-gapi:2
#	(R)DEPEND dev-dotnet/glib-sharp:2 dev-lang/mono), upstream bug 23247

# TODO:
# +doc to install doc/website
# check if test? qt? ( really needs qt-gui)

# UPSTREAM:
# documentation/website with --enable-doc-install
# failing tests

DOCS=(AUTHORS ChangeLog MAINTAINERS NEWS README TODO)

src_prepare() {
	autotools-utils_src_prepare
}

src_configure() {
	# localstatedir: for gentoo it's /var/lib but for $PN it's /var
	# option-check,libtool-lock,strict,local: obvious reasons
	# gtk-doc: doc already built
	# command,debuginfo,gstreamer,service-packs: not supported by backend
	myeconfargs=(
		--localstatedir="/var"
		--disable-command-not-found
		--disable-debuginfo-install
		--disable-dummy
		--disable-gtk-doc
		--disable-gstreamer-plugin
		--disable-local
		--disable-managed
		--disable-service-packs
		--disable-strict
		--disable-tests
		--enable-libtool-lock
		--enable-man-pages
		--enable-option-checking
		--enable-portage
		--with-default-backend=portage
		$(use_enable connman)
		$(use_enable cron)
		$(use_enable gtk gtk-module)
		$(use_enable introspection)
		$(use_enable networkmanager)
		$(use_enable nls)
		$(use_enable nsplugin browser-plugin)
		$(use_enable pm-utils)
		$(use_enable qt4 qt)
		$(use_enable test tests)
		$(use_enable udev device-rebind)
	)

	if use policykit; then
		myconfargs+=(--with-security-framework=polkit)
	else
		myconfargs+=(--with-security-framework=dummy)
	fi

	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install

	if use nsplugin; then
		src_mv_plugins "/usr/$(get_libdir)/mozilla/plugins"
	fi

	python_convert_shebangs -q -r $(python_get_version) "${D}"
	python_clean_installation_image -q
}

pkg_postinst() {
	python_mod_optimize -q "$(python_get_sitedir)/${PN}"

	if ! use policykit; then
		ewarn "You are not using policykit, the daemon can't be considered as secure."
		ewarn "All users will be able to do anything through ${MY_PN}."
		ewarn "Please, consider rebuilding ${MY_PN} with policykit USE flag."
		ewarn "THIS IS A SECURITY ISSUE."
		echo
		ebeep
		epause 5
	fi
}

pkg_prerm() {
	einfo "Removing downloaded files with ${MY_PN}..."
	[[ -d "${ROOT}/var/cache/${MY_PN}/downloads" ]] && \
		rm -rf "${ROOT}/var/cache/${MY_PN}/downloads"/*
}

pkg_postrm() {
	python_mod_cleanup -q "$(python_get_sitedir)/${PN}"
}
