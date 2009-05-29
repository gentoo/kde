# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kopete/kopete-4.2.2-r1.ebuild,v 1.4 2009/04/17 07:55:28 alexxy Exp $

EAPI="2"

KMNAME="kdenetwork"
inherit kde4-meta

DESCRIPTION="KDE multi-protocol IM client"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug doc ssl"

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
#	msn: libmsn == this is wlm plugin, we disable msn one
#	oscar: NO DEPS
#	qq: NO DEPS
#	sms: NO DEPS
#   telepathy: net-libs/decibel
#   testbed: NO DEPS
#	winpopup: NO DEPS
#	yahoo: NO DEPS
PROTOCOLS="bonjour gadu groupwise +jabber jingle meanwhile msn oscar qq
testbed winpopup yahoo"

# disabled protocols
#   telepathy: net-libs/decibel
#   irc: NO DEPS

IUSE="${IUSE} ${PLUGINS} ${PROTOCOLS}"

# Tests are KDE-ish.
RESTRICT="test"

COMMONDEPEND="
	dev-libs/libpcre
	x11-libs/libXScrnSaver
	>=x11-libs/qt-gui-4.4.0:4[mng]
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
"
RDEPEND="${COMMONDEPEND}
	latex? (
		media-gfx/imagemagick
		virtual/latex-base
	)
"
#	telepathy? ( net-libs/decibel )"
DEPEND="${COMMONDEPEND}
	x11-proto/scrnsaverproto
"
PDEPEND="
	ssl? ( app-crypt/qca-ossl )
"

src_configure() {
	local x x2
	# Disable old msn support.
	mycmakeargs="${mycmakeargs} -DWITH_msn=OFF"
	# enable protocols
	for x in ${PROTOCOLS}; do
		[[ ${x/+/} = msn ]] && x2=wlm || x2=""
		mycmakeargs="${mycmakeargs} $(cmake-utils_use_with ${x/+/} ${x2})"
	done
	# enable plugins
	for x in ${PLUGINS}; do
		mycmakeargs="${mycmakeargs} $(cmake-utils_use_with ${x/+/})"
	done
	# additional defines
	if use jingle && ! use jabber; then
		elog "You enabled jingle but not jabber useflag. Jingle is integral part of"
		elog "jabber protocol so it wont be used."
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

	if ! use ssl; then
		if use jabber || use msn; then # || use irc; then
			echo
			elog "In order to use ssl in jabber, msn and irc you'll need to"
			elog "install app-crypt/qca-ossl package."
			echo
		fi
	fi
}
