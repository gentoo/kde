# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_HANDBOOK="true"
KDE_TEST="true"
KMNAME="kdepim"
VIRTUALX_REQUIRED="test"
inherit kde5

DESCRIPTION="KDE X.509 key manager"
HOMEPAGE="https://www.kde.org/applications/office/kontact/"
KEYWORDS=""

IUSE=""

COMMON_DEPEND="
	$(add_frameworks_dep kcmutils)
	$(add_frameworks_dep kcodecs)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep kxmlgui)
	$(add_kdeapps_dep gpgmepp)
	$(add_kdeapps_dep kmime)
	$(add_kdeapps_dep kpimtextedit)
	$(add_kdeapps_dep libkdepim)
	$(add_kdeapps_dep libkleo)
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtnetwork)
	$(add_qt_dep qtwidgets)
	>=app-crypt/gpgme-1.3.2
	dev-libs/boost:=
	dev-libs/libassuan
	dev-libs/libgpg-error
"
DEPEND="${COMMON_DEPEND}
	sys-devel/gettext
"
RDEPEND="${COMMON_DEPEND}
	!kde-apps/kdepim[kdepim_features_kleopatra]
	!<kde-apps/kdepim-15.12.2-r1
	$(add_kdeapps_dep kdepim-runtime)
	>=app-crypt/gnupg-2.1
"

if [[ ${KDE_BUILD_TYPE} = live ]] ; then
	S="${WORKDIR}/${P}/${PN}"
else
	S="${WORKDIR}/${KMNAME}-${PV}/${PN}"
fi

src_prepare() {
	# kleopatra subproject does not contain doc nor searches for DocTools
	# at least until properly split upstream
	echo "add_subdirectory(doc)" >> CMakeLists.txt || die "Failed to add doc dir"

	mkdir doc || die "Failed to create doc dir"
	mv ../doc/${PN} doc || die "Failed to move handbook"
	mv ../doc/kwatchgnupg doc || die "Failed to move handbook"
	cat <<-EOF > doc/CMakeLists.txt
find_package(KF5DocTools)
add_subdirectory(${PN})
add_subdirectory(kwatchgnupg)
EOF

	kde5_src_prepare
}
