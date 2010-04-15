# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/youtube-servicemenu/youtube-servicemenu-1.7.ebuild,v 1.1 2009/11/03 10:44:08 ssuominen Exp $

EAPI=2
KDE_MINIMAL=4.3
PYTHON_DEPEND="2"
inherit python rpm

DESCRIPTION="Download YouTube (tm) Videos"
HOMEPAGE="http://www.kde-apps.org/content/show.php/Get+YouTube+Video+(improved)?content=41456"
SRC_URI="http://twoday.tuwien.ac.at/static/pub/files/${PN}-kde4-${PV}-1.noarch.rpm"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

KDE_LINGUAS="de es ru sk uk"

for x in ${KDE_LINGUAS}; do
	IUSE="${IUSE} linguas_${x}"
done

DEPEND=">=kde-base/konqueror-${KDE_MINIMAL}
	>=kde-base/kdelibs-${KDE_MINIMAL}
	dev-lang/python
	!${CATEGORY}/${PN}:0"

S=${WORKDIR}

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
    python_convert_shebangs -r 2 .
}

src_install() {
	dobin usr/bin/get_yt_video-kde4.py || die

	insinto `kde4-config --install services`
	doins usr/share/kde4/services/get_yt_video.desktop || die

	for x in ${KDE_LINGUAS}; do
		if use linguas_${x}; then
			insinto /usr/share/locale/${x}/LC_MESSAGES
			doins usr/share/get_yt_video/${x}/LC_MESSAGES/get_yt_video.mo || die
		fi
	done
}
