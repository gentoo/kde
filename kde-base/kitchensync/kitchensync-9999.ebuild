# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1

KMNAME=kdepim
inherit kde4svn-meta

DESCRIPTION="Synchronize Data with KDE"
IUSE="debug"
KEYWORDS=""

DEPEND=">=app-pda/libopensync-0.38
	dev-libs/glib:2
	kde-base/libkdepim:${SLOT}"
# kitchensync uses libopensync plugins to sync resources. Install these
# resources to sync with these resources. Install at least one of these.
#PDEPEND="suggested:
#	>=app-pda/libopensync-plugin-evolution2-0.30
#	>=app-pda/libopensync-plugin-file-0.30
#	>=app-pda/libopensync-plugin-gnokii-0.30
#	>=app-pda/libopensync-plugin-google-calendar-0.30
#	>=app-pda/libopensync-plugin-gpe-0.30
#	>=app-pda/libopensync-plugin-irmc-0.30
#	>=app-pda/libopensync-plugin-kdepim-0.30
#	>=app-pda/libopensync-plugin-palm-0.30
#	>=app-pda/libopensync-plugin-python-0.30
#	>=app-pda/libopensync-plugin-syncml-0.30
#	>=app-pda/libopensync-plugin-vformat-0.30"

KMEXTRACTONLY="libkdepim"
