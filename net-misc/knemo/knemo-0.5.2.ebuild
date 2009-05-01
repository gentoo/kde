# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KDE_MINIMAL="4.2"
KDE_LINGUAS_DIR="${S}/translations"
KDE_LINGUAS="ar bg br cs cy da de el en_GB es et fr ga gl hu it ja ka lt nl
			pl pt pt_BR ru rw sk sr sr@Latn sv tr"
inherit kde4-base

DESCRIPTION="KNemo - the KDE Network Monitor"
HOMEPAGE="http://kde-apps.org/content/show.php?content=12956"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/12956-${P}.tar.gz"

SLOT="4"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	>=kde-base/systemsettings-${KDE_MINIMAL}
	net-wireless/wireless-tools
"
RDEPEND="${DEPEND}"
