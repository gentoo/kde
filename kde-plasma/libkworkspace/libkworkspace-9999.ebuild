# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="true"
KDE_ORG_NAME="plasma-workspace"
KFMIN=5.245.0
PVCUT=$(ver_cut 1-3)
QTMIN=6.6.0
inherit ecm plasma.kde.org

DESCRIPTION="Workspace library to interact with the Plasma session manager"
S="${S}/${PN}"

LICENSE="GPL-2" # TODO: CHECK
SLOT="6"
KEYWORDS=""
IUSE=""

RDEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui]
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kwindowsystem-${KFMIN}:6
	>=kde-plasma/kscreenlocker-${PVCUT}:6
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXau
"
DEPEND="${RDEPEND}
	>=kde-plasma/kwin-${PVCUT}:6
"

src_prepare() {
	# delete colliding libkworkspace translations, let ecm_src_prepare do its magic
	find ../po -type f -name "*po" -and -not -name "libkworkspace*" -delete || die
	rm -rf po/*/docs || die
	cp -a ../po ./ || die

	eapply "${FILESDIR}/${PN}-5.27.9-standalone.patch"
	sed -e "/set/s/GENTOO_PV/$(ver_cut 1-3)/" -i CMakeLists.txt || die
	cat >> CMakeLists.txt <<- _EOF_ || die
		ki18n_install(po)
	_EOF_

	ecm_src_prepare
}
