# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# @ECLASS: freedesktop
# @MAINTAINER:
# freedesktop-bugs@gentoo.org
# @BLURB: Useful functions for working with freedesktop-compliant applications
# @DESCRIPTION:
# Set up directories according to the XDG Base Directory Specification.
# Also provides functions for updating desktop, mime, and icon caches.
# @EXAMPLE:
# @CODE
# inherit freedesktop
#
# pkg_setup() {
# 	freedesktop_setup
# }
# pkg_postinst() {
# 	freedesktop_desktop_database_update
# 	freedesktop_mime_database_update
# }
# @CODE

# Unset these globally to avoid leaking values from the calling environment.
unset XDG_DATA_HOME XDG_CONFIG_HOME XDG_CACHE_HOME XDG_RUNTIME_DIR

# @FUNCTION: freedesktop_setup
# @DESCRIPTION:
# Creates sensible locations for the following environment variables:
# XDG_DATA_HOME
# XDG_CONFIG_HOME
# XDG_CACHE_HOME
# XDG_RUNTIME_DIR
freedesktop_setup() {
	export XDG_DATA_HOME="${HOME}/.local/share"
	export XDG_CONFIG_HOME="${HOME}/.config"
	export XDG_CACHE_HOME="${HOME}/.cache"
	export XDG_RUNTIME_DIR="${T}/run"
	mkdir -p "${XDG_DATA_HOME}" "${XDG_CONFIG_HOME}" "${XDG_CACHE_HOME}" || die
	mkdir -p -m 0700 "${XDG_RUNTIME_DIR}" || die
}

# @FUNCTION: freedesktop_desktop_database_update
# @DESCRIPTION:
# Updates the desktop database.
# Generates a list of mimetypes linked to applications that can handle them
fdo-mime_desktop_database_update() {
	has "${EAPI:-0}" 0 1 2 && ! use prefix && EPREFIX=
	has "${EAPI:-0}" 0 1 2 && ! use prefix && EROOT="${ROOT}"
	if [ -x "${EPREFIX}/usr/bin/update-desktop-database" ]
	then
		einfo "Updating desktop mime database ..."
		"${EPREFIX}/usr/bin/update-desktop-database" -q "${EROOT}usr/share/applications"
	fi
}

# @FUNCTION: freedesktop_mime_database_update
# @DESCRIPTION:
# Update the mime database.
# Creates a general list of mime types from several sources
freedesktop_mime_database_update() {
	has "${EAPI:-0}" 0 1 2 && ! use prefix && EPREFIX=
	has "${EAPI:-0}" 0 1 2 && ! use prefix && EROOT="${ROOT}"
	if [ -x "${EPREFIX}/usr/bin/update-mime-database" ]
	then
		einfo "Updating shared mime info database ..."
		"${EPREFIX}/usr/bin/update-mime-database" "${EROOT}usr/share/mime"
	fi
}
