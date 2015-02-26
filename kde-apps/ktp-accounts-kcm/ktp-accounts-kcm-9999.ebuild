# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5

DESCRIPTION="KDE Telepathy account management kcm"
HOMEPAGE="http://community.kde.org/Real-Time_Communication_and_Collaboration"

LICENSE="LGPL-2.1"
KEYWORDS=""
IUSE="experimental gadu haze icq meanwhile steam yahoo xmpp"

DEPEND="
	$(add_frameworks_dep kcodecs)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kitemviews)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_kdeapps_dep kaccounts-integration)
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	net-libs/telepathy-qt[qt5]
"

# for now we depend on all services we want to use, later we could remove some depending on USE flags.
#  haze is used for multiple services like steam, sametime, yahoo and not just only for icq, so we list it explicitly
#  we also have to enable some services inside pidgin directly
#    gadu:      used for gadugadu
#    meanwhile: used for IBM sametime
RDEPEND="${DEPEND}
	$(add_kdeapps_dep kaccounts-providers)
	net-im/telepathy-connection-managers[icq?,xmpp?,yahoo?]
	gadu? ( net-im/pidgin[gadu] )
	haze? ( net-voip/telepathy-haze )
	meanwhile? ( net-im/pidgin[meanwhile] )
	steam? ( x11-plugins/pidgin-opensteamworks )
	!net-im/ktp-accounts-kcm
"

REQUIRED_USE="
	gadu? ( haze )
	meanwhile? ( haze )
	steam? ( experimental haze )
"

src_prepare() {
	if use experimental ; then
		mv "${S}"/data/kaccounts/disabled/*.in "${S}"/data/kaccounts/ || die "couldn't enable experimental services"

		ewarn "Experimental providers are enabled. Most of them aren't integrated nicely and may require additional steps for account creation." \
			"Use at your own risk!"
	fi
	kde5_src_prepare
}
