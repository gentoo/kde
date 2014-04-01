# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VIRTUALDBUS_TEST="true"
inherit kde-frameworks

DESCRIPTION="Framework for registering services and applications according to freedesktop standards"
LICENSE="LGPL-2+"
KEYWORDS=" ~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	dev-qt/qtdbus:5
"
DEPEND="${RDEPEND}"
