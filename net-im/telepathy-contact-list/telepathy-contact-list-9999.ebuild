# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KDE_SCM="git"
inherit kde4-base
#EGIT_REPO_URI="git://anongit.kde.org/clones/telepathy-contact-list/mklapetek/telepathy-contact-list-new"

DESCRIPTION="UI for contaclist"
HOMEPAGE="http://community.kde.org/Real-Time_Communication_and_Collaboration"
KEYWORDS=""

LICENSE="GPL-3"
SLOT="0"
IUSE="debug"

DEPEND="
	>=net-libs/telepathy-qt4-0.7.1
	>=net-im/telepathy-accounts-kcm-9999
"
RDEPEND="${DEPEND}"

src_install() {
	kde4-base_src_install
	# Now we will drop icons colliding with 4.6.80-90
	for x in facebook google-talk icq jabber msn skype yahoo
	do
		rm "${ED}/usr/share/icons/oxygen/48x48/actions/im-${x}.png" || die
	done
	for x in 16 22 32 48 64 128
	do
		rm "${ED}/usr/share/icons/oxygen/${x}x${x}/apps/kde-telepathy.png"
	done
}
