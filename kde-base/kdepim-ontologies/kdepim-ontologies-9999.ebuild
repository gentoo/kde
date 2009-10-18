# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdepim"
KMMODULE="ontologies"
inherit kde4-meta

DESCRIPTION="KDE PIM examples"
KEYWORDS=""
IUSE="debug"

DEPEND="
	app-misc/strigi[dbus,qt4]
	dev-libs/soprano
	$(add_kdebase_dep messagecore)
	$(add_kdebase_dep messageviewer)
	$(add_kdebase_dep nepomuk)
"
#niefast_apps
RDEPEND="${DEPEND}"

KMEXTRA="
	nepomuk_email_feeder
"
KMEXTRACTONLY="
	libkleo
	messagecore
	messageviewer
"
