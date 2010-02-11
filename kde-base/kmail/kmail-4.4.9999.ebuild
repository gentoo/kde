# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="KMail is the email component of Kontact, the integrated personal information manager of KDE."
KEYWORDS=""
IUSE="ayatana debug +handbook"

DEPEND="
	$(add_kdebase_dep akonadi)
	$(add_kdebase_dep kdelibs 'semantic-desktop')
	$(add_kdebase_dep kdepimlibs 'akonadi')
	$(add_kdebase_dep libkdepim)
	$(add_kdebase_dep libkleo)
	$(add_kdebase_dep libkpgp)
	ayatana? ( >=dev-libs/libindicate-qt-0.2.1 )
"
RDEPEND="${DEPEND}"

add_blocker kmailcvt
add_blocker libksieve
add_blocker messagecore
add_blocker messagelist
add_blocker messageviewer
add_blocker mimelib

KMEXTRACTONLY="
	korganizer/org.kde.Korganizer.Calendar.xml
	libkleo/
	libkpgp/
"
KMEXTRA="
	kmailcvt/
	ksendemail/
	libksieve/
	messagecore/
	messagelist/
	messageviewer/
	mimelib/
	plugins/kmail/
"
KMLOADLIBS="libkdepim"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with ayatana IndicateQt)
	)

	kde4-meta_src_configure
}

src_compile() {
	# Bug #276377: kontact/ can build before kmail/, causing a dependency not to be built
	# Upstream as KDE Bug #198807
	# (setting MAKEOPTS to trigger a repoman warning)
	: || MAKEOPTS="-j1"
	kde4-meta_src_compile kmail_xml
	kde4-meta_src_compile
}

pkg_postinst() {
	kde4-meta_pkg_postinst

	if ! has_version kde-base/kdepim-kresources:${SLOT}; then
		echo
		elog "For groupware functionality, please install kde-base/kdepim-kresources:${SLOT}"
		echo
	fi
}
