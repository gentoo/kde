# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebase-workspace"
inherit kde4-meta

DESCRIPTION="PowerDevil is an utility for KDE4 for Laptop Powermanagement."
HOMEPAGE="http://www.kde-apps.org/content/show.php/PowerDevil?content=85078"
LICENSE="GPL-2"

KEYWORDS="~amd64 ~x86"
IUSE="debug"

COMMONDEPEND="
	>=kde-base/solid-${PV}:${SLOT}[kdeprefix=]
	x11-libs/libXScrnSaver
"
DEPEND="${COMMONDEPEND}
	x11-proto/scrnsaverproto
"
RDEPEND="${COMMONDEPEND}
	!sys-power/powerdevil
"

KMEXTRACTONLY="
	krunner/
	ksmserver/org.kde.KSMServerInterface.xml
"
