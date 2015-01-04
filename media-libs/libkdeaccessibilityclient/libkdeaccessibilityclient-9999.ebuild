# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

DESCRIPTION="Library for writing accessibility clients such as screen readers in KDE"
HOMEPAGE="https://projects.kde.org/projects/playground/accessibility/libkdeaccessibilityclient/repository"

LICENSE="LGPL-2.1"
SLOT="4"
KEYWORDS=""
IUSE=""

src_configure() {
	local mycmakeargs=(
		-DQT4_BUILD=true
	)

	kde4-base_src_configure
}
