# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )
CMAKE_REQUIRED="never"
inherit python-single-r1 kde4-base

DESCRIPTION="Plasmoid mixer for the Pulseaudio sound server"
HOMEPAGE="http://kde-look.org/content/show.php?content=116676"
SRC_URI="http://kde-look.org/CONTENT/content-files/116676-2012-04-25_${PV}_${PN}.plasmoid -> ${P}.zip"

LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64"
IUSE="debug"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	${PYTHON_DEPS}
	app-arch/unzip
"
RDEPEND="
	$(add_kdebase_dep plasma-workspace python)
	dev-python/PyQt4[dbus]
	dev-python/pyxdg
	media-libs/ladspa-sdk
	media-plugins/swh-plugins
	media-sound/pulseaudio
"

S=${WORKDIR}

DOCS=( Changelog )

pkg_setup() {
	python-single-r1_pkg_setup
	kde4-base_pkg_setup
}

src_prepare() {
	python_fix_shebang "${S}"
	sed -e '/^all:/s/build//' -i Makefile || die
	sed -e 's|/usr/share/kde4/apps/|/usr/share/apps/|' -i Makefile \
		-i org.veromix.pulseaudio.service || die
}

src_install() {
	default
	insinto /usr/share/apps/${PN}-plasmoid/
	doins -r presets
	insinto /usr/share/kde4/services/
	newins metadata.desktop plasma-widget-veromix.desktop
}
