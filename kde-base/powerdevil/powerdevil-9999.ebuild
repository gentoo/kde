# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

KMNAME=kdebase-workspace

inherit kde4svn-meta

DESCRIPTION="PowerDevil is an utility for KDE4 for Laptop Powermanagement."
HOMEPAGE="http://www.kde-apps.org/content/show.php/PowerDevil?content=85078"
LICENSE="GPL-2"

KEYWORDS=""
IUSE=""

DEPEND="!sys-power/powerdevil
	kde-base/libkworkspace:${SLOT}
	kde-base/solid:${SLOT}"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="krunner
	ksmserver/org.kde.KSMServerInterface.xml"
