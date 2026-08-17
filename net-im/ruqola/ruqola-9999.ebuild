# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit ecm kde.org

DESCRIPTION="Qt/QML client for Rocket Chat"
HOMEPAGE="https://apps.kde.org/ruqola"

LICENSE="GPL-2+"
SLOT="5"
IUSE="speech telemetry"

DEPEND="
	dev-libs/qtkeychain
	dev-qt/qtgui:${SLOT}
	dev-qt/qtmultimedia:${SLOT}[widgets]
	dev-qt/qtnetworkauth:${SLOT}
	dev-qt/qttest:${SLOT}
	dev-qt/qtwebsockets:${SLOT}[ssl]
	dev-qt/qtwidgets:${SLOT}
	kde-frameworks/kcoreaddons:${SLOT}
	kde-frameworks/kcrash:${SLOT}
	kde-frameworks/kdbusaddons:${SLOT}
	kde-frameworks/kdoctools:${SLOT}
	kde-frameworks/ki18n:${SLOT}
	kde-frameworks/kiconthemes:${SLOT}
	kde-frameworks/kio:${SLOT}
	kde-frameworks/knotifications:${SLOT}
	kde-frameworks/knotifyconfig:${SLOT}
	kde-frameworks/ktextwidgets:${SLOT}
	kde-frameworks/kxmlgui:${SLOT}
	kde-frameworks/sonnet:${SLOT}
	kde-frameworks/syntax-highlighting:${SLOT}
	telemetry? ( dev-libs/kuserfeedback:${SLOT} )
	speech? ( dev-qt/qtspeech:${SLOT} )
"

RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake_use_find_package speech Qt5TextToSpeech)
		$(cmake_use_find_package telemetry KUserFeedback)
	)

	ecm_src_configure
}
