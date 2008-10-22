# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME="extragear/network"
NEED_KDE="svn"
inherit kde4svn-meta

# Install to KDEDIR rather than /usr, to slot properly.
PREFIX="${KDEDIR}"

DESCRIPTION="A BitTorrent program for KDE."
HOMEPAGE="http://ktorrent.org/"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="kde-svn"
IUSE="+bitfinder +bwscheduler +infowidget +ipfilter +logviewer +mediaplayer +scanfolder +search +stats +upnp +webinterface"

DEPEND="dev-libs/gmp
	app-crypt/qca:2"
RDEPEND="${DEPEND}
	ipfilter? ( kde-base/kdebase-kioslaves:kde-svn )"

src_compile() {
	sed -e '/SSH2/ s:^:#DONOTWANT:' \
		-i "${S}"/CMakeLists.txt \
		|| die "Deactivating search for SSH2 failed."
	mycmakeargs="${mycmakeargs}
		-DCMAKE_INSTALL_PREFIX=${PREFIX}
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
	kde4overlay-meta_src_compile
}
