# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kopete/kopete-4.2.0.ebuild,v 1.3 2009/02/01 07:45:30 jmbsvicetto Exp $

EAPI="2"

KMNAME="kdenetwork"
inherit kde4-meta

DESCRIPTION="KDE multi-protocol IM client"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug htmlhandbook ssl"

# Available plugins
#
#	addbookmarks: NO DEPS
#	alias: NO DEPS
#	autoreplace: NO DEPS
#	contactnotes: NO DEPS
#	highlight: NO DEPS
#	history: NO DEPS
#	latex: virtual/latex as RDEPEND
#	nowlistening: NO DEPS
#	otr: libotr
#	pipes: NO DEPS
#	privacy: NO DEPS
#	statistics: dev-db/sqlite:3
#	texteffect: NO DEPS
#	translator: NO DEPS
#	urlpicpreview: NO DEPS
#	webpresence: libxml2 libxslt
# NOTE: By default we enable all plugins that don't have any dependencies
PLUGINS="+addbookmarks +alias +autoreplace +contactnotes +highlight +history latex
+nowlistening otr +pipes +privacy +statistics +texteffect +translator +urlpicpreview webpresence"

# Available protocols
#
#	bonjour: NO DEPS
#	gadu: openssl
#	groupwise: app-crypt/qca:2
#	irc: NO DEPS, probably will fail so inform user about it
#	jabber: net-dns/libidn app-crypt/qca:2 ENABLED BY DEFAULT NETWORK
#	jingle: media-libs/speex net-libs/ortp
#	meanwhile: net-libs/meanwhile
#	msn: libmsn
#	oscar: NO DEPS
#	qq: NO DEPS
#	sms: NO DEPS
#   telepathy: net-libs/decibel
#   testbed: NO DEPS
#	winpopup: NO DEPS
#	wlm: libmsn
#	yahoo: NO DEPS
PROTOCOLS="bonjour gadu groupwise +jabber jingle meanwhile msn oscar qq
testbed winpopup wlm yahoo"

# disabled protocols
#   telepathy: net-libs/decibel
#   irc: NO DEPS

IUSE="${IUSE} ${PLUGINS} ${PROTOCOLS}"

# Tests are KDE-ish.
RESTRICT="test"

COMMONDEPEND="
	dev-libs/libpcre
	x11-libs/libXScrnSaver
	gadu? ( dev-libs/openssl )
	groupwise? ( app-crypt/qca:2 )
	jabber? (
		app-crypt/qca:2
		net-dns/libidn
		jingle? (
			>=media-libs/speex-1.2_rc1
			>=net-libs/ortp-0.13
		)
	)
	meanwhile? ( net-libs/meanwhile )
	msn? ( net-libs/libmsn )
	otr? ( >=net-libs/libotr-3.2.0 )
	statistics? ( dev-db/sqlite:3 )
	webpresence? ( dev-libs/libxml2 dev-libs/libxslt )
	wlm? ( net-libs/libmsn )
"
RDEPEND="${COMMONDEPEND}
	latex? ( virtual/latex-base )
"
#	telepathy? ( net-libs/decibel )"
DEPEND="${COMMONDEPEND}
	x11-proto/scrnsaverproto
"
PDEPEND="
	ssl? ( app-crypt/qca-ossl )
"

src_configure() {
	local x
	# Xmms isn't in portage, thus forcefully disabled.
	mycmakeargs="${mycmakeargs} -DWITH_Xmms=OFF"
	# enable protocols
	for x in ${PROTOCOLS}; do
		mycmakeargs="${mycmakeargs} $(cmake-utils_use_with ${x/+/})"
	done
	# enable plugins
	for x in ${PLUGINS}; do
		mycmakeargs="${mycmakeargs} $(cmake-utils_use_with ${x/+/})"
	done
	# additional defines
	if use jingle && ! use jabber; then
		elog "You enabled jingle but not jabber useflag. Jingle is integral part of"
		elog "jabber protocol."
	fi
	if use jabber; then
		mycmakeargs="${mycmakeargs} -DNO_JINGLE=$(use jingle && echo OFF || echo ON)"
	fi

	kde4-meta_src_configure
}

pkg_postinst() {
	kde4-meta_pkg_postinst

	#if use telepathy; then
	#	elog "To use kopete telepathy plugins, you need to start gabble first:"
	#	elog "GABBLE_PERSIST=1 telepathy-gabble &"
	#	elog "export TELEPATHY_DATA_PATH=/usr/share/telepathy/managers/"
	#fi

	elog "The messenger plugin has been renamed to wlm - adjust your use flags accordingly."

	if ! use ssl; then
		if use jabber || use wlm; then # || use irc; then
			echo
			elog "In order to use ssl in jabber, wlm and irc you'll need to"
			elog "install app-crypt/qca-ossl package."
			echo
		fi
	fi
}
