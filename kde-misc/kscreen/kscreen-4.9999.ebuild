# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DISABLE_AUTOFORMATTING="true"
DECLARATIVE_REQUIRED="always"
VIRTUALX_REQUIRED="test"
KDE_LINGUAS="bs cs da de el es et fi fr ga gl hu it lt mr nl pt pt_BR ro ru sk
sl sv tr uk zh_CN zh_TW"
EGIT_BRANCH="kdelibs4"
inherit kde4-base readme.gentoo

DESCRIPTION="Alternative KDE screen management"
HOMEPAGE="https://projects.kde.org/projects/extragear/base/kscreen"

LICENSE="GPL-2 LGPL-2.1"
SLOT="4"
KEYWORDS=""
IUSE="debug"

DEPEND="
	>=dev-libs/qjson-0.8
	>=x11-libs/libkscreen-${PV}:4
"
RDEPEND="${DEPEND}"

DOC_CONTENTS="Disable the old screen management:
# qdbus org.kde.kded /kded org.kde.kded.unloadModule randrmonitor
# qdbus org.kde.kded /kded org.kde.kded.setModuleAutoloading randrmonitor false

Enable the kded module for the kscreen based screen management:
# qdbus org.kde.kded /kded org.kde.kded.loadModule kscreen

Now simply (un-)plugging displays should enable/disable them, while
the last state is remembered.
"

src_install() {
	kde4-base_src_install
	readme.gentoo_create_doc
}

pkg_postinst() {
	kde4-base_pkg_postinst
	readme.gentoo_print_elog
}
