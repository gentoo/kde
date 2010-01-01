# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="KMail is the email component of Kontact, the integrated personal information manager of KDE."
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="ayatana debug +handbook +semantic-desktop"

DEPEND="
	$(add_kdebase_dep kdelibs 'semantic-desktop?')
	$(add_kdebase_dep kdepimlibs 'akonadi')
	$(add_kdebase_dep libkdepim)
	$(add_kdebase_dep libkleo)
	$(add_kdebase_dep libkpgp)
	$(add_kdebase_dep libksieve)
	$(add_kdebase_dep mimelib)
	ayatana? ( >=dev-libs/libindicate-qt-0.2.1 )
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kmailcvt)
"

add_blocker messagecore
add_blocker messagelist
add_blocker messageviewer

KMEXTRACTONLY="
	korganizer/org.kde.Korganizer.Calendar.xml
	libkleo
	libkpgp
	libksieve
	mimelib
"
KMEXTRA="
	ksendemail/
	messagecore/
	messagelist/
	messageviewer/
	plugins/kmail/
"
KMLOADLIBS="libkdepim"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with ayatana IndicateQt)
		$(cmake-utils_use semantic-desktop KDEPIM_BUILD_NEPOMUK_AGENTS)
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
