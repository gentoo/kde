# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KMNAME="kdepim"
KDE_MINIMAL="4.10"
KDE_HANDBOOK=optional
VIRTUALX_REQUIRED=test
inherit flag-o-matic kde4-meta

DESCRIPTION="KMail is the email component of Kontact, the integrated personal information manager of KDE."
HOMEPAGE="http://www.kde.org/applications/internet/kmail/"
KEYWORDS=""
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kdelibs 'semantic-desktop(+)' 4.6)
	$(add_kdebase_dep kdepimlibs 'semantic-desktop(+)' 4.6)
	$(add_kdebase_dep libkdepim '' 4.4.11.1-r1)
	$(add_kdebase_dep libkleo)
	$(add_kdebase_dep libkpgp)
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kdepim-runtime)
"

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
#KMLOADLIBS="libkdepim"

PATCHES=(
	"${FILESDIR}/${PN}-4.4.9-nodbus.patch"
	"${FILESDIR}/4.4/"000{2,4,5}-*.patch
	"${FILESDIR}/${P}-separate.patch"
)

pkg_pretend() {
	[ "${I_KNOW_WHAT_I_AM_DOING}" = "" ] && die "You are trying to do something dangerous. kmail-4.4.11.1-r100 is only for the brave or foolish."
	ewarn "You are trying to do something dangerous. kmail-4.4.11.1-r100 is only for the brave or foolish."
}

src_configure() {
	# Bug 308903
	use ppc64 && append-flags -mminimal-toc

	mycmakeargs=(
		-DWITH_IndicateQt=OFF
	)

	kde4-meta_src_configure
}

src_compile() {
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
	if ! has_version kde-base/kleopatra:${SLOT}; then
		echo
		elog "For certificate management and the gnupg log viewer, please install kde-base/kleopatra:${SLOT}"
		echo
	fi
}
