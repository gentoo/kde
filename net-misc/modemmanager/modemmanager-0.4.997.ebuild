# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

# ModemManager likes itself with capital letters
MY_PN="${PN/modemmanager/ModemManager}"
MY_P=${MY_PN}-${PV}

if [[ ${PV} == *9999 ]]; then
	git_eclass="git-2"
	EGIT_REPO_URI="git://anongit.freedesktop.org/${MY_PN}/${MY_PN}"
	KEYWORDS=""
else
	SRC_URI="http://cgit.freedesktop.org/${MY_PN}/${MY_PN}/snapshot/${MY_P}.tar.bz2"
	KEYWORDS="~amd64 ~arm ~x86"
fi

inherit eutils autotools ${git_eclass}

DESCRIPTION="Modem and mobile broadband management libraries"
HOMEPAGE="http://mail.gnome.org/archives/networkmanager-list/2008-July/msg00274.html"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="doc policykit test"

RDEPEND=">=dev-libs/glib-2.18
	>=sys-fs/udev-145[extras]
	>=dev-libs/dbus-glib-0.86
	net-dialup/ppp
	policykit? ( >=sys-auth/polkit-0.95 )"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35.0
	sys-devel/gettext
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_PN}-${PV}"

if [[ ${PV} == *9999* ]]; then
	src_prepare() {
		intltoolize --force --copy --automake || die
		eautoreconf
	}
fi

src_configure() {
	# ppp-2.4.5 will change the plugin directory (not added to portage yet)
	if has_version '=net-dialup/ppp-2.4.4*'; then
		pppd_plugin_dir="pppd/2.4.4"
	elif has_version '=net-dialup/ppp-2.4.5*'; then
		pppd_plugin_dir="pppd/2.4.5"
	fi

	econf \
		--disable-more-warnings \
		--with-udev-base-dir=/etc/udev/ \
		--disable-static \
		--with-dist-version=${PVR} \
		--with-pppd-plugin-dir="/usr/$(get_libdir)/${pppd_plugin_dir}" \
		$(use_with doc docs) \
		$(use_with policykit polkit) \
		$(use_with test tests)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
	# Remove useless .la files
	rm -vf "${D}"/usr/$(get_libdir)/{${MY_PN},${pppd_plugin_dir}}/*.la
}

pkg_postinst() {
	elog "If your USB modem shows up as a Flash drive when you plug it in,"
	elog "You should install sys-apps/usb_modeswitch which will automatically"
	elog "switch it over to USB modem mode whenever you plug it in."
}
