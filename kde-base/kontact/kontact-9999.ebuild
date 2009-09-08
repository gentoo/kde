# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="KDE personal information manager"
KEYWORDS=""
IUSE="debug +handbook"

DEPEND="
	app-crypt/gpgme
	>=kde-base/kontactinterfaces-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/libkdepim-${PV}:${SLOT}[kdeprefix=]
"
RDEPEND="${DEPEND}
	app-crypt/gnupg
"

KMLOADLIBS="libkdepim"
KMSAVELIBS="true"

# We remove plugins that are related to external kdepim programs. This way
# kontact doesn't have to depend on all programs it has plugins for.
# kcontactmanager gone from kdesvn
#
# xml targets from kmail/ are being uncommented by kde4-meta.eclass
KMEXTRACTONLY="
	kmail/
	kontact/plugins/akregator/
	kontact/plugins/kaddressbook/
	kontact/plugins/kjots/
	kontact/plugins/kmail/
	kontact/plugins/knode/
	kontact/plugins/knotes/
	kontact/plugins/korganizer/
	kontact/plugins/ktimetracker/
	kontact/plugins/planner/
	kontact/plugins/specialdates/
	kontactinterfaces/
"

src_unpack() {
	if use handbook; then
		KMEXTRA+="
			doc/kontact-admin/
		"
	fi

	kde4-meta_src_unpack
}
