# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

DESCRIPTION="This is kdm plugin for Pluggable Authentication Module for Face based Authentication"
HOMEPAGE="http://code.google.com/p/pam-face-authentication/"
SRC_URI="http://pam-face-authentication.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	>=sys-auth/pam-face-authentication-0.3
"
RDEPEND="${DEPEND}"
