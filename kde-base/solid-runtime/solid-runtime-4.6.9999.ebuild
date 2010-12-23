# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

KMNAME="kdebase-runtime"
KMNOMODULE=true
inherit kde4-meta

DESCRIPTION="KDE SC solid runtime modules (autoeject, automounter and others)"
KEYWORDS=""
IUSE="debug"

# Packages merged around 4.3.77
add_blocker solidautoeject
add_blocker solid-device-automounter
add_blocker solid-hardware
add_blocker soliduiserver
# Moved away from workspace
add_blocker solid '<4.5.69'

KMEXTRA="
	solid-device-automounter/
	solid-hardware/
	solid-networkstatus/
	solidautoeject/
	soliduiserver/
"
