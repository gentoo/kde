# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://git.devuan.org/pkgs-utopia-substitution/loginkit.git"
inherit git-r3

DESCRIPTION="Implementation of logind that does not depend on any specific init system"
HOMEPAGE="https://git.devuan.org/pkgs-utopia-substitution/loginkit"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

BDEPEND="dev-util/gdbus-codegen"
DEPEND="dev-libs/glib:2"
RDEPEND="${DEPEND}"
