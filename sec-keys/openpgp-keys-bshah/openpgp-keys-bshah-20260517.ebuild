# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

SEC_KEYS_VALIDPGPKEYS=(
	"0AAC775BB6437A8D9AF7A3ACFE0784117FBCE11D:bshah:ubuntu"
)

inherit sec-keys

DESCRIPTION="OpenPGP keys used by Bhushan Shah"
HOMEPAGE="https://wiki.gentoo.org/wiki/No_homepage"

KEYWORDS="~amd64 ~arm ~arm64 ~loong ~ppc64 ~riscv ~x86"
