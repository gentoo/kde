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
SLOT="3"
IUSE="+bwscheduler debug +downloadorder +infowidget +ipfilter +kross +logviewer +mediaplayer plasma rss +scanfolder +search +stats +upnp +webinterface +zeroconf"

DEPEND="
	app-crypt/qca:2
	dev-libs/gmp
	plasma? ( >=kde-base/libtaskmanager-${KDE_MINIMAL} )
	rss? (
		dev-libs/boost
		>=kde-base/kdepimlibs-${KDE_MINIMAL}
	)
"
RDEPEND="${DEPEND}
	ipfilter? ( >=kde-base/kdebase-kioslaves-${KDE_MINIMAL} )
"

src_prepare() {
	if ! use plasma; then
		sed -i -e 's/add_subdirectory([[:space:]]*plasma[[:space:]]*)//' \
			CMakeLists.txt || die "Failed to make plasmoid optional"
	fi

	kde4-base_src_prepare
}

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_enable bwscheduler BWSCHEDULER_PLUGIN)
		-DENABLE_DHT_SUPPORT=ON
		$(cmake-utils_use_enable downloadorder DOWNLOADORDER_PLUGIN)
		$(cmake-utils_use_enable infowidget INFOWIDGET_PLUGIN)
		$(cmake-utils_use_enable ipfilter IPFILTER_PLUGIN)
		$(cmake-utils_use_enable logviewer LOGVIEWER_PLUGIN)
		$(cmake-utils_use_enable mediaplayer MEDIAPLAYER_PLUGIN)
		$(cmake-utils_use_enable scanfolder SCANFOLDER_PLUGIN)
		$(cmake-utils_use_enable kross SCRIPTING_PLUGIN)
		$(cmake-utils_use_enable search SEARCH_PLUGIN)
		$(cmake-utils_use_enable stats STATS_PLUGIN)
		$(cmake-utils_use_enable rss SYNDICATION_PLUGIN)
		$(cmake-utils_use_enable upnp UPNP_PLUGIN)
		$(cmake-utils_use_enable webinterface WEBINTERFACE_PLUGIN)
		$(cmake-utils_use_enable zeroconf ZEROCONF_PLUGIN)
	"

	kde4-base_src_configure
}
