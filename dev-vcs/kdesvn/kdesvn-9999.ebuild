# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="forceoptional"
KFMIN=6.0.0
QTMIN=6.6.2
inherit ecm kde.org

DESCRIPTION="Frontend to the subversion vcs"
HOMEPAGE="https://apps.kde.org/kdesvn/"

if [[ ${PV} != 9999* ]]; then
	SRC_URI="mirror://kde/stable/${PN}/${PV}/${P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="+man"

DEPEND="
	dev-libs/apr:1
	dev-libs/apr-util:1
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,sql,sqlite,widgets,xml]
	dev-vcs/subversion
	>=kde-frameworks/kbookmarks-${KFMIN}:6
	>=kde-frameworks/kcodecs-${KFMIN}:6
	>=kde-frameworks/kcompletion-${KFMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kconfigwidgets-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kdbusaddons-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kiconthemes-${KFMIN}:6
	>=kde-frameworks/kio-${KFMIN}:6
	>=kde-frameworks/kitemviews-${KFMIN}:6
	>=kde-frameworks/kjobwidgets-${KFMIN}:6
	>=kde-frameworks/knotifications-${KFMIN}:6
	>=kde-frameworks/kparts-${KFMIN}:6
	>=kde-frameworks/kservice-${KFMIN}:6
	>=kde-frameworks/ktextwidgets-${KFMIN}:6
	>=kde-frameworks/kwallet-${KFMIN}:6
	>=kde-frameworks/kwidgetsaddons-${KFMIN}:6
	>=kde-frameworks/kxmlgui-${KFMIN}:6
"
RDEPEND="${DEPEND}
	!${CATEGORY}/${PN}:5
"
BDEPEND="man? ( >=kde-frameworks/kdoctools-${KFMIN}:6 )"

src_prepare(){
	ecm_src_prepare

	if ! use man ; then
		sed -i -e "/kdoctools_create_manpage/ s/^/#/" doc/CMakeLists.txt || die
	fi
}
