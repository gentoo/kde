# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

SEC_KEYS_VALIDPGPKEYS=(
	"90A968ACA84537CC27B99EAF2C8DF587A6D4AAC1:nicolasfella:ubuntu"
)

inherit sec-keys

DESCRIPTION="OpenPGP keys used by Nicolas Fella"
HOMEPAGE="https://nicolasfella.de"

KEYWORDS="~amd64 ~arm ~arm64 ~loong ~ppc64 ~riscv ~x86"
