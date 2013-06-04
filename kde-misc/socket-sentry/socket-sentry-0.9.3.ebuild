# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

RESTRICT="$RESTRICT mirror"

DESCRIPTION="Socket Sentry is a KDE Plasma widget that displays real-time network traffic on your Linux computer."
HOMEPAGE="http://code.google.com/p/socket-sentry"
SRC_URI="http://socket-sentry.googlecode.com/files/socketsentry-${PV}.tar.gz"

S="${WORKDIR}/socketsentry-${PV}"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

RDEPEND="
	>=net-libs/libpcap-0.9
"
