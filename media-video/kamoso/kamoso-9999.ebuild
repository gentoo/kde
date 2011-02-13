# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

KDE_SCM="git"
inherit kde4-base

DESCRIPTION="A webcam application to attract sweet girls to kde :)"
HOMEPAGE="http://projects.kde.org/projects/playground/multimedia/kamoso"

LICENSE="GPL-3"
KEYWORDS=""
SLOT="0"
IUSE="debug"

DEPEND="
	>=media-sound/qt-gstreamer-0.10
	$(add_kdebase_dep libkipi)
"
RDEPEND="${DEPEND}"
