# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit distutils qt4-edge

MY_PV=${PV/_pre/-snapshot-}
MY_P=PyQt-x11-gpl-${MY_PV}

DESCRIPTION="A set of Python bindings for the Qt toolkit"
HOMEPAGE="http://www.riverbankcomputing.co.uk/software/pyqt/intro/"
SRC_URI="http://dev.gentooexperimental.org/~hwoarang/distfiles/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="dbus debug doc examples opengl qt3support svg webkit X"

RDEPEND=">=dev-python/sip-4.8_pre20090430
	>=x11-libs/qt-core-4.5.1:4[qt3support=]
	>=x11-libs/qt-xmlpatterns-4.5.1:4
	dbus? (
		dev-python/dbus-python
		>=x11-libs/qt-dbus-4.5.1:4
	)
	opengl? ( >=x11-libs/qt-opengl-4.5.1:4[qt3support=] )
	svg? ( >=x11-libs/qt-svg-4.5.1:4 )
	qt3support? ( >=x11-libs/qt-qt3support-4.5.1:4 )
	webkit? ( >=x11-libs/qt-webkit-4.5.1:4 )
	X? ( >=x11-libs/qt-gui-4.5.1:4[dbus=,qt3support=] )"
DEPEND="${RDEPEND}
	sys-devel/libtool"

S="${WORKDIR}/${MY_P}"

PATCHES=(
	"${FILESDIR}/configure.py.patch"
)

src_prepare() {
	sed -i -e "s:^[ \t]*check_license():# check_license():" "${S}"/configure.py
	sed -i -e "s:join(qt_dir, \"mkspecs\":join(\"/usr/share/qt4\",	\"mkspecs\":g" "${S}"/configure.py
	sed -i -e "s:\"QT_INSTALL_HEADERS\"\:   os.path.join(qt_dir, \"include\":\"QT_INSTALL_HEADERS\"\:   os.path.join(qt_dir, \"include/qt4\":g" "${S}"/configure.py
	sed -i -e "s:\"QT_INSTALL_LIBS\"\:      os.path.join(qt_dir, \"lib\":\"QT_INSTALL_LIBS\"\:      os.path.join(qt_dir, \"lib/qt4\":g" "${S}"/configure.py
	qt4-edge_src_prepare
}

src_configure() {
	distutils_python_version
	addpredict ${QTDIR}/etc/settings

	myconf="-d /usr/$(get_libdir)/python${PYVER}/site-packages -b /usr/bin -v /usr/share/sip"
	use debug && myconf="${myconf} -u"

	"${python}" configure.py ${myconf}
}

src_install() {
	emake DESTDIR="${D}" INSTALL_ROOT="${D}" install || die "install failed"
	dodoc ChangeLog NEWS README THANKS
	use doc && dohtml -r doc/html/*
	if use examples ; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
