# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

KMNAME="kdenetwork"
inherit kde4-meta

DESCRIPTION="KDE multi-protocol IM client"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
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
#   telepathy: net-libs/decibel
#   testbed: NO DEPS
#	winpopup: NO DEPS
#	yahoo: NO DEPS
PROTOCOLS="bonjour gadu groupwise +jabber jingle meanwhile msn oscar qq
skype sms testbed winpopup yahoo"

# disabled protocols
#   telepathy: net-libs/decibel
#   irc: NO DEPS

IUSE="${IUSE} ${PLUGINS} ${PROTOCOLS}"

COMMONDEPEND="
	dev-libs/libpcre
	$(add_kdebase_dep kdepimlibs)
	>=x11-libs/qt-gui-4.4.0:4[mng]
	!aqua? ( x11-libs/libXScrnSaver )
	gadu? ( >=net-libs/libgadu-1.8.0[threads] )
	groupwise? ( app-crypt/qca:2 )
	jabber? (
		app-crypt/qca:2
		net-dns/libidn
	)
	jingle? (
		>=media-libs/mediastreamer-2.3.0
		media-libs/speex
		net-libs/ortp
	)
	meanwhile? ( net-libs/meanwhile )
	msn? ( >=net-libs/libmsn-4.0 )
	otr? ( >=net-libs/libotr-3.2.0 )
	statistics? ( dev-db/sqlite:3 )
	webpresence? ( dev-libs/libxml2 dev-libs/libxslt )
	v4l2? ( media-libs/libv4l )
"
RDEPEND="${COMMONDEPEND}
	latex? (
		media-gfx/imagemagick
		virtual/latex-base
	)
	sms? ( app-mobilephone/smssend )
	ssl? ( app-crypt/qca-ossl )
"
#	telepathy? ( net-libs/decibel )"
DEPEND="${COMMONDEPEND}
	!aqua? ( x11-proto/scrnsaverproto )
"

src_prepare() {
	sed -e "s:lib/mozilla:$(get_libdir)/mozilla:" \
		-i kopete/protocols/skype/skypebuttons/CMakeLists.txt || die "sed failed"
	sed -e '/set (LIBV4L2_REQUIRED TRUE)/s/TRUE/FALSE/' \
		-i kopete/CMakeLists.txt || die 'failed to make v4l2 optional'

	kde4-meta_src_prepare
}

src_configure() {
	local x x2
	# Handle common stuff
	mycmakeargs=(
		$(cmake-utils_use_with jingle GOOGLETALK)
		$(cmake-utils_use_with jingle LiboRTP)
		$(cmake-utils_use_with jingle Mediastreamer)
		$(cmake-utils_use_with jingle Speex)
		$(cmake-utils_use_with v4l2 LibV4L2)
	)
	# enable protocols
	for x in ${PROTOCOLS}; do
		[[ ${x/+/} = msn ]] && x2=Libmsn || x2=""
		mycmakeargs+=($(cmake-utils_use_with ${x/+/} ${x2}))
	done

	# enable plugins
	for x in ${PLUGINS}; do
		mycmakeargs+=($(cmake-utils_use_with ${x/+/}))
	done

	kde4-meta_src_configure
}

pkg_postinst() {
	kde4-meta_pkg_postinst

	#if use telepathy; then
	#	elog "To use kopete telepathy plugins, you need to start gabble first:"
	#	elog "GABBLE_PERSIST=1 telepathy-gabble &"
	#	elog "export TELEPATHY_DATA_PATH='${EPREFIX}/usr/share/telepathy/managers/'"
	#fi

	if ! use ssl; then
		if use jabber || use msn; then # || use irc; then
			echo
			#elog "In order to use ssl in jabber, msn and irc you'll need to"
			elog "In order to use ssl in jabber and msn you'll need to"
			elog "install app-crypt/qca-ossl package."
			echo
		fi
	fi
}
