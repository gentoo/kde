# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebindings"
KMMODULE="csharp"
WEBKIT_REQUIRED="optional"
inherit kde4-meta mono

DESCRIPTION="C# bindings for KDE and Qt"
KEYWORDS="~amd64 ~x86"
IUSE="akonadi +phonon qscintilla"

COMMON_DEPEND="
	dev-lang/mono
	>=kde-base/smoke-${PV}:${SLOT}[akonadi?,kdeprefix=,phonon?,qscintilla?,webkit?]
"

DEPEND="${COMMON_DEPEND}"
RDEPEND="${COMMON_DEPEND}"

KMEXTRACTONLY="smoke/"

PATCHES=( "${FILESDIR}"/${PN}-build-fixes.patch )

src_prepare() {
	kde4-meta_src_prepare

	sed -i "/add_subdirectory( examples )/ s:^:#:" csharp/plasma/CMakeLists.txt
}

src_configure() {
	local mycmakeargs="
		$(cmake-utils_use_enable webkit WEBKIT_SHARP)
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
