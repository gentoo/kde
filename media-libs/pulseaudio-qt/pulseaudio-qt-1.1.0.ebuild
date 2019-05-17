# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_HANDBOOK="forceoptional"
KDE_QTHELP="true"
KDE_TEST="optional"
inherit kde5

DESCRIPTION="Qt bindings for libpulse"
HOMEPAGE="https://cgit.kde.org/pulseaudio-qt.git/"

if [[ ${KDE_BUILD_TYPE} = release ]]; then
	SRC_URI="mirror://kde/stable/${PN}/${P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

RDEPEND="
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtgui)
	dev-libs/glib:2
	media-sound/pulseaudio
"
DEPEND="${RDEPEND}
	test? (
		$(add_qt_dep qtdeclarative)
		$(add_qt_dep qtquickcontrols2)
	)
"
