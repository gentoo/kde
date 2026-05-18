# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

SEC_KEYS_VALIDPGPKEYS=(
	"D81C0CB38EB725EF6691C385BB463350D6EF31EF:heikobecker:manual,openpgp,ubuntu"
)

inherit eapi9-pipestatus sec-keys

DESCRIPTION="OpenPGP keys used by Heiko Becker"
HOMEPAGE="https://invent.kde.org/heikobecker"
SRC_URI+=" https://invent.kde.org/heikobecker.gpg -> ${P}-inventkde.gpg"

KEYWORDS="~amd64 ~arm ~arm64 ~loong ~ppc64 ~riscv ~x86"

src_test() {
	# manually check
	wget -qO- https://invent.kde.org/heikobecker.gpg | gpg --import
	pipestatus || die

	sec-keys_src_test
}
