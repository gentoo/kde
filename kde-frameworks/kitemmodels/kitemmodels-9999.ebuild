# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

VIRTUALX_REQUIRED="test"
inherit kde5

DESCRIPTION="Framework providing data models to help with tasks such as sorting and filtering"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

DEPEND="test? ( $(add_qt_dep qtwidgets) )"
