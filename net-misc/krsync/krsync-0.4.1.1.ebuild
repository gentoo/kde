# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

DESCRIPTION="KDE 4 Archiving/Backup"
HOMEPAGE="http://www.kde-apps.org/content/show.php/Krsync?content=68586"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/68586-${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
LANGS="de it"

for X in ${LANGS};do
	IUSE="${IUSE} linguas_${X}"
done

RDEPEND="
	net-misc/rsync
	>=kde-base/kommander-${KDE_MINIMAL}
"

src_prepare() {
	# fix desktop files
	sed -i "s:kmdr-executor:kommander:" kde4/*.desktop ||
		die "binary name fix (sed) failed"
}

src_configure() {
	einfo "no configuration required"
}

src_compile() {
	einfo "no compilation required"
}

src_install() {
	insinto "${KDEDIR}"/bin
	doins src/*.kmdr || die "*.kmdr install failed"

	for LANG in ${LINGUAS};
	do
		if has ${LANG} ${LANGS}; then
			insinto "${KDEDIR}"/share/locale/${LANG}/LC_MESSAGES
			doins po/${LANG}/*.mo
		fi
	done

	for i in `ls icons/`
	do
		insinto "${KDEDIR}"/share/icons/default.kde4/"${i}"/apps
		doins icons/"${i}"/*.png || die "${i} icons installation failed"
	done

	insinto "${KDEDIR}"/share/applications/kde4
	doins kde4/krsync.desktop || die "desktop file installation failed"
	doins kde4/krsync-root.desktop || "root desktop file installation failed"
}
