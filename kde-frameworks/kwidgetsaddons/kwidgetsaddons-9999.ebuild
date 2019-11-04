# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECM_DESIGNERPLUGIN="true"
VIRTUALX_REQUIRED="test"
inherit kde5

DESCRIPTION="An assortment of high-level widgets for common tasks"
LICENSE="LGPL-2.1+"
KEYWORDS=""
IUSE="nls"

# drop qtwidgets subslot operator when QT_MINIMAL >= 5.14.0
BDEPEND="
	nls? ( $(add_qt_dep linguist-tools) )
"
DEPEND="
	$(add_qt_dep qtgui '' '' '5=')
	$(add_qt_dep qtwidgets)
"
RDEPEND="${DEPEND}"

src_test() {
	# bug 650216, 653186
	local myctestargs=( -E "(kdatecomboboxtest|ktooltipwidgettest)" )
	kde5_src_test
}
