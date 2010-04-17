# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

PYTHON_DEPEND="2"
inherit python rpm

DESCRIPTION="Download YouTube (tm) Videos"
HOMEPAGE="http://www.kde-apps.org/content/show.php/Get+YouTube+Video+(improved)?content=41456"
SRC_URI="http://twoday.tuwien.ac.at/static/pub/files/${PN}-kde4-${PV}-1.noarch.rpm"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE=""

MY_LINGUAS="de es ru sk uk"
for x in ${MY_LINGUAS}; do
	IUSE="${IUSE} linguas_${x}"
done

RDEPEND="
	>=kde-base/konqueror-4.3.1
"

S="${WORKDIR}"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	python_convert_shebangs -r 2 .
}

src_install() {
	dobin usr/bin/get_yt_video-kde4.py || die

	insinto /usr/share/kde4/services
	doins usr/share/kde4/services/get_yt_video.desktop || die

	for x in ${MY_LINGUAS}; do
		if use linguas_${x}; then
			insinto /usr/share/locale/${x}/LC_MESSAGES
			doins usr/share/get_yt_video/${x}/LC_MESSAGES/get_yt_video.mo || die
		fi
	done
}
