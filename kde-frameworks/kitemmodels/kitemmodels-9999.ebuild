# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde-frameworks

DESCRIPTION="Framework providing data models that help with tasks such as sorting and filtering"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

# tests are not enabled upstream due to unconverted dependencies.
# restrict to avoid issues when enabled due to missing dependencies
# etc, and as a personal reminder to check if upstream has properly
# specified all dependencies.
RESTRICT="test"
