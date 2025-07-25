# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="forceoff"
KFMIN=6.16.0
QTMIN=6.9.1
inherit ecm flag-o-matic gear.kde.org xdg

DESCRIPTION="Multi-document editor with network transparency, Plasma integration and more"
HOMEPAGE="https://kate-editor.org/ https://apps.kde.org/kate/"

LICENSE="GPL-2" # TODO: CHECK
SLOT="6"
KEYWORDS=""
IUSE=""

# slot op: Uses Qt6::GuiPrivate for qtx11extras_p.h
# kde-frameworks/kwindowsystem[X]: Unconditional use of KX11Extras
# TODO: replace HAVE_X11 and __has_include with explicit WITH_X11 option
DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6=[dbus,gui,network,widgets,X]
	~kde-apps/kate-lib-${PV}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kdbusaddons-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kwindowsystem-${KFMIN}:6[X]
	virtual/libintl
"
RDEPEND="${DEPEND}
	~kde-apps/kate-addons-${PV}:6
	>=kde-apps/kate-common-${PV}
"

src_prepare() {
	ecm_src_prepare
	ecm_punt_po_install

	# these tests are run in kde-apps/kate-lib
	cmake_run_in apps/lib cmake_comment_add_subdirectory autotests
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_addons=FALSE
		-DBUILD_kwrite=FALSE
	)

	# provided by kde-apps/kate-lib
	append-libs -lkateprivate

	ecm_src_configure
}

src_install() {
	ecm_src_install

	# provided by kde-apps/kate-lib
	rm -v "${ED}"/usr/$(get_libdir)/libkateprivate.so.* || die
}
