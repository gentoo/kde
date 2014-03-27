# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="optional"
KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="A viewer for TNEF attachments."
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="LGPL-2.1"
IUSE="debug"

DEPEND="
	>=app-office/akonadi-server-1.10.45
	$(add_kdebase_dep kdepimlibs)
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	akonadi/
"
