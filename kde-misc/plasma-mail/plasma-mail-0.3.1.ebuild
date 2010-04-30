# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit kde4-base

DESCRIPTION="Just a simple plasmoid that checks your inbox for new mails. Supports both imap and pop3 accounts."
HOMEPAGE="http://www.kde-look.org/content/show.php/mail_plasmoid?content=98952"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/98952-${PN}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=kde-base/plasma-workspace-${KDE_MINIMAL}"

S="${WORKDIR}/${PN}"
