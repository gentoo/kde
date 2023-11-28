# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="forceoptional"
KFMIN=5.245.0
PVCUT=$(ver_cut 1-3)
QTMIN=6.6.0
inherit ecm plasma.kde.org systemd

DESCRIPTION="Plasma crash handler, gives the user feedback if a program crashed"
SRC_URI+=" https://dev.gentoo.org/~asturm/distfiles/${PN}-5.27.8-revert-add-sentry-support.patch.xz"

LICENSE="GPL-2" # TODO: CHECK
SLOT="6"
KEYWORDS=""
IUSE="systemd"

COMMON_DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,widgets]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=kde-frameworks/kcompletion-${KFMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kcrash-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kidletime-${KFMIN}:6
	>=kde-frameworks/kio-${KFMIN}:6
	>=kde-frameworks/kjobwidgets-${KFMIN}:6
	>=kde-frameworks/knotifications-${KFMIN}:6
	>=kde-frameworks/kwallet-${KFMIN}:6
	>=kde-frameworks/kwidgetsaddons-${KFMIN}:6
	>=kde-frameworks/kwindowsystem-${KFMIN}:6
	>=kde-frameworks/syntax-highlighting-${KFMIN}:6
	systemd? (
		>=dev-qt/qtbase-${QTMIN}:6[network]
		>=kde-frameworks/kservice-${KFMIN}:6
		sys-apps/systemd:=
	)
"
DEPEND="${COMMON_DEPEND}
	>=dev-qt/qtbase-${QTMIN}:6[concurrent]
	test? ( >=dev-qt/qtbase-${QTMIN}:6[network] )
"
RDEPEND="${COMMON_DEPEND}
	>=kde-frameworks/kirigami-${KFMIN}:6
	>=kde-frameworks/kitemmodels-${KFMIN}:6[qml]
	|| (
		sys-devel/gdb
		dev-util/lldb
	)
"

src_configure() {
	local mycmakeargs=(
		$(cmake_use_find_package systemd Systemd)
	)
	ecm_src_configure
}

src_test() {
	# needs network access, bug #698510
	local myctestargs=(
		-E "(connectiontest)"
	)
	ecm_src_test
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]] && systemd_is_booted ; then
		elog "For systemd, steps are needed for integration with systemd-coredumpd."
		elog "As root, run the following:"
		elog "1. systemctl enable drkonqi-coredump-processor@.service"
		elog "2. systemctl --user enable --now --global drkonqi-coredump-launcher.socket"
	fi
}
