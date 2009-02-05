# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="extragear/network"
inherit kde4-base

DESCRIPTION="A BitTorrent program for KDE."
HOMEPAGE="http://ktorrent.org/"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="live"
IUSE="+bitfinder +bwscheduler +infowidget +ipfilter +logviewer +mediaplayer +scanfolder +search +stats +upnp +webinterface"

DEPEND="
	app-crypt/qca:2
	dev-libs/gmp
"
RDEPEND="${DEPEND}
	ipfilter? ( >=kde-base/kdebase-kioslaves-${KDE_MINIMAL}[kdeprefix=] )
"

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DENABLE_DHT_SUPPORT=ON
		$(cmake-utils_use_enable logviewer LOGVIEWER_PLUGIN)
		$(cmake-utils_use_enable infowidget INFOWIDGET_PLUGIN)
		$(cmake-utils_use_enable upnp UPNP_PLUGIN)
		$(cmake-utils_use_enable search SEARCH_PLUGIN)
		$(cmake-utils_use_enable webinterface WEBINTERFACE_PLUGIN)
		$(cmake-utils_use_enable scanfolder SCANFOLDER_PLUGIN)
		$(cmake-utils_use_enable ipfilter IPFILTER_PLUGIN)
		$(cmake-utils_use_enable stats STATS_PLUGIN)
		$(cmake-utils_use_enable bwscheduler BWSCHEDULER_PLUGIN)
		$(cmake-utils_use_enable mediaplayer MEDIAPLAYER_PLUGIN)
		$(cmake-utils_use_enable bitfinder BITFINDER_PLUGIN)"

	kde4-base_src_configure
}
