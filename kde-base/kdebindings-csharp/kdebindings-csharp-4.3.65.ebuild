# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebindings-csharp/kdebindings-csharp-4.3.1.ebuild,v 1.2 2009/09/02 10:41:46 wired Exp $

EAPI="2"

KMNAME="kdebindings"
KMMODULE="csharp"
WEBKIT_REQUIRED="optional"
inherit kde4-meta mono

DESCRIPTION="C# bindings for KDE and Qt"
KEYWORDS="~amd64 ~x86"
IUSE="akonadi +phonon plasma qscintilla"

COMMON_DEPEND="
	dev-lang/mono
	>=kde-base/smoke-${PV}:${SLOT}[akonadi?,kdeprefix=,phonon?,qscintilla?,webkit?]
"

DEPEND="${COMMON_DEPEND}"
RDEPEND="${COMMON_DEPEND}"

KMEXTRACTONLY="smoke/"

PATCHES=( "${FILESDIR}"/${PN}-build-fixes.patch )

pkg_setup() {
	kde4-meta_pkg_setup

	if use plasma && ! use webkit; then
		eerror
		eerror "The plasma USE flag requires the webkit USE flag to be enabled."
		eerror
		eerror "Please enable webkit or disable plasma."
		die "plasma requires webkit"
	fi
}

src_prepare() {
	kde4-meta_src_prepare

	sed -i "/add_subdirectory( examples )/ s:^:#:" csharp/plasma/CMakeLists.txt
}

src_configure() {
	local mycmakeargs="
		$(cmake-utils_use_enable webkit QTWEBKIT_SHARP)
		$(cmake-utils_use_enable plasma PLASMA_SHARP)
		$(cmake-utils_use_enable phonon PHONON_SHARP)
		$(cmake-utils_use_enable qscintilla QSCINTILLA_SHARP)
		$(cmake-utils_use_enable akonadi KdepimLibs)
		$(cmake-utils_use_enable akonadi)
	"
	kde4-meta_src_configure
}

src_compile() {
	# Parallel builds seem broken, check later
	MAKEOPTS=-j1
	kde4-meta_src_compile
}
