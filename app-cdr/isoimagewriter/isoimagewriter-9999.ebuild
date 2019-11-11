# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KFMIN=5.60.0
QTMIN=5.12.3
inherit ecm kde.org

DESCRIPTION="Write hybrid ISO files onto a USB disk"
HOMEPAGE="http://wiki.rosalab.com/en/index.php/Blog:ROSA_Planet/ROSA_Image_Writer"

if [[ ${KDE_BUILD_TYPE} == release ]]; then
	SRC_URI="mirror://kde/unstable/${PN}/${PV}/${P}.tar.xz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="5"
IUSE=""

DEPEND="
	app-crypt/gpgme[cxx,qt5]
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtwidgets-${QTMIN}:5
	>=kde-frameworks/kauth-${KFMIN}:5
	>=kde-frameworks/kcoreaddons-${KFMIN}:5
	>=kde-frameworks/ki18n-${KFMIN}:5
	virtual/libudev:=
"
RDEPEND="${DEPEND}"
