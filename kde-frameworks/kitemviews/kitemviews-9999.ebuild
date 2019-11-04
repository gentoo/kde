# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECM_DESIGNERPLUGIN="true"
VIRTUALX_REQUIRED="test"
inherit kde5

DESCRIPTION="Framework providing additional widgets for item models"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE="nls"

# drop qtgui subslot operator when QT_MINIMAL >= 5.14.0
BDEPEND="
	nls? ( $(add_qt_dep linguist-tools) )
"
DEPEND="
	$(add_qt_dep qtgui '' '' '5=')
	$(add_qt_dep qtwidgets)
"
RDEPEND="${DEPEND}"
