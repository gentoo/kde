# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KDE_REQUIRED="optional"
inherit kde4-base qt4

MY_PN="floatstyle"
MY_P="${MY_PN}-${PV/_alpha/a}"

DESCRIPTION="QT4/KDE4 style based on gonx"
HOMEPAGE="http://kde-look.org/content/show.php?content=54477"
SRC_URI="http://kde-look.org/CONTENT/content-files/54477-${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug"

DEPEND="
	x11-libs/qt-gui:4
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_compile() {
	eqmake4 ${MY_PN}.pro || die "qmake failed"
	emake || die "make failed"
}

src_install() {
	insinto /usr/lib/qt4/plugins/styles
	doins libfloatstyle.so || die "libfloatstyle.so install failed"

	if use kde; then
		if use kdeprefix; then
			insinto "${PREFIX}/share/apps/kstyle/themes"
		else
			insinto "/usr/share/apps/kstyle/themes"
		fi
		doins float.themerc || die "float.themerc install failed"
	fi
}
