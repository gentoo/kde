# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit kde4-base

DESCRIPTION="FSRunner give you instant access to any file or directory you need."
HOMEPAGE="http://code.google.com/p/fsrunner/"
SRC_URI="http://fsrunner.googlecode.com/files/${P}.tgz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

DOCS=( changelog README )
