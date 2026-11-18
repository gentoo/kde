# Copyright 2025-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="true"
KFMIN=9999
QTMIN=6.11.2
inherit ecm plasma.kde.org xdg

DESCRIPTION="Virtual keyboard based on Qt Virtual Keyboard"

LICENSE="|| ( GPL-2 GPL-3 ) LGPL-2.1 LGPL-3 gpl3? ( GPL-3 )"
SLOT="6"
KEYWORDS=""

IUSE="anthy +gpl3 libchewing libhangul libpinyin"

# slot op: Uses Qt6::GuiPrivate for qxkbcommon_p.h
COMMON_DEPEND="
	dev-libs/wayland
	>=dev-qt/qtbase-${QTMIN}:6=[gui,wayland]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=kde-frameworks/kcmutils-${KFMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kcrash-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kpackage-${KFMIN}:6
	>=kde-plasma/libplasma-${KDE_CATV}:6=
	x11-libs/libxkbcommon
	anthy? ( app-i18n/anthy:= )
	libchewing? ( app-i18n/libchewing:= )
	libhangul? ( app-i18n/libhangul:= )
	libpinyin? ( app-i18n/libpinyin:= )
	gpl3? ( >=dev-qt/qtmultimedia-${QTMIN}:6 )
"
RDEPEND="${COMMON_DEPEND}
	dev-libs/kirigami-addons
	>=kde-frameworks/kconfig-${KFMIN}:6[qml]
	>=kde-frameworks/kirigami-${KFMIN}:6
	>=kde-frameworks/kitemmodels-${KFMIN}:6
"
DEPEND="${COMMON_DEPEND}
	dev-libs/plasma-wayland-protocols
	>=dev-libs/wayland-protocols-1.19
	test? ( >=dev-qt/qtwayland-${QTMIN}:6 )
"
BDEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[wayland]
	dev-util/wayland-scanner
	>=kde-frameworks/kcmutils-${KFMIN}:6
	virtual/pkgconfig
"

CMAKE_SKIP_TESTS=(
	# Needs to create a socket, would require setting XDG_RUNTIME_DIR to a path short enough to work
	mockinputmethodcompositor
)

src_configure() {
	local mycmakeargs=(
		-DPLASMA_KEYBOARD_ANTHY_ENABLED=$(usex anthy)
		-DPLASMA_KEYBOARD_LIBCHEWING_ENABLED=$(usex libchewing)
		-DPLASMA_KEYBOARD_LIBHANGUL_ENABLED=$(usex libhangul)
		-DPLASMA_KEYBOARD_LIBPINYIN_ENABLED=$(usex libpinyin)
		-DPLASMA_KEYBOARD_SOUNDS_ENABLED=$(usex gpl3)
		-DPLASMA_KEYBOARD_VIBRATION_ENABLED=$(usex gpl3)
	)
	ecm_src_configure
}
