# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit kde4-base

DESCRIPTION="This is kdm plugin for Pluggable Authentication Module for Face based Authentication"
HOMEPAGE="http://code.google.com/p/pam-face-authentication/"
SRC_URI="http://pam-face-authentication.googlecode.com/files/kdm-plugin-pam-face-authentication-0.2.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=sys-auth/pam-face-authentication-0.3"
RDEPEND="${DEPEND}"
