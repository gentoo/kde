# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdenetwork"
inherit kde4-meta

DESCRIPTION="KDE multi-protocol IM client"
KEYWORDS=""
IUSE="debug +handbook ssl v4l2"

# tests hang, last checked for 4.2.96
RESTRICT=test

# Available plugins
#
#	addbookmarks: NO DEPS
#	alias: NO DEPS (disabled upstream)
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
PLUGINS="+addbookmarks +autoreplace +contactnotes +highlight +history latex
+nowlistening otr +pipes +privacy +statistics +texteffect +translator
+urlpicpreview webpresence"

# Available protocols
#
#	bonjour: NO DEPS
#	gadu: net-libs/libgadu @since 4.3
#	groupwise: app-crypt/qca:2
#	irc: NO DEPS, probably will fail so inform user about it
#	jabber: net-dns/libidn app-crypt/qca:2 ENABLED BY DEFAULT NETWORK
#	jingle: media-libs/speex net-libs/ortp DISABLED BY UPSTREAM
#	meanwhile: net-libs/meanwhile
#	msn: libmsn == this is wlm plugin, we disable msn one
#	oscar: NO DEPS
#	qq: NO DEPS
#	sms: NO DEPS
#   telepathy: net-libs/decibel
#   testbed: NO DEPS
#	winpopup: NO DEPS
#	yahoo: NO DEPS
PROTOCOLS="bonjour gadu groupwise +jabber meanwhile msn oscar qq skype
testbed winpopup yahoo"

# disabled protocols
#   telepathy: net-libs/decibel
#   irc: NO DEPS

IUSE="${IUSE} ${PLUGINS} ${PROTOCOLS}"

COMMONDEPEND="
	dev-libs/libpcre
	x11-libs/libXScrnSaver
	>=x11-libs/qt-gui-4.4.0:4[mng]
	gadu? ( >=net-libs/libgadu-1.8.0 )
	groupwise? ( app-crypt/qca:2 )
	jabber? (
		app-crypt/qca:2
		net-dns/libidn
	)
	meanwhile? ( net-libs/meanwhile )
	msn? ( net-libs/libmsn )
	otr? ( net-libs/libotr )
	statistics? ( dev-db/sqlite:3 )
	webpresence? ( dev-libs/libxml2 dev-libs/libxslt )
	v4l2? ( media-libs/libv4l )
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
