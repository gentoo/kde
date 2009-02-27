# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kontact/kontact-4.2.0.ebuild,v 1.4 2009/02/03 03:22:55 jmbsvicetto Exp $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="KDE personal information manager"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug htmlhandbook"

DEPEND="app-crypt/gnupg
	app-crypt/gpgme
	>=kde-base/kontactinterfaces-${PV}:${SLOT}
	>=kde-base/libkdepim-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

KMLOADLIBS="libkdepim"
KMSAVELIBS="true"

# We remove plugins that are related to external kdepim programs. This way
# kontact doesn't have to depend on all programs it has plugins for.
#
# xml targets from kmail/ are being uncommented by kde4-meta.eclass
KMEXTRACTONLY="libkdepim/
	kmail/
	kontact/plugins/akregator/
	kontact/plugins/kaddressbook/
	kontact/plugins/kjots/
	kontact/plugins/kmail/
	kontact/plugins/kmobiletools
	kontact/plugins/knode/
	kontact/plugins/knotes/
	kontact/plugins/korganizer/
	kontact/plugins/ktimetracker/
	kontact/plugins/planner/
	kontact/plugins/specialdates/
	kontactinterfaces/"
