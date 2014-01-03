# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

DESCRIPTION="Library for writing accessibility clients such as screen readers in KDE"
SLOT=4
KEYWORDS=""
IUSE=""
LICENSE="LGPL-2.1"
HOMEPAGE="https://projects.kde.org/projects/playground/accessibility/libkdeaccessibilityclient/repository"

DEPEND=""
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-noqt5.patch" )
