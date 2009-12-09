# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils confutils

DESCRIPTION="Linux Rapidshare downloader"
HOMEPAGE="http://code.google.com/p/slimrat/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.bz2" 

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X"

DEPEND="
	>=dev-lang/perl-5.10.1[ithreads]
	>=dev-perl/WWW-Mechanize-1.52
	virtual/perl-Getopt-Long
	virtual/perl-Term-ANSIColor
	X? (
		dev-perl/gtk2-gladexml
		dev-perl/Spiffy
		x11-misc/xclip
	)
"
# aview: displaying captcha
RDEPEND="${DEPEND}
	media-gfx/aview
	X? ( x11-terms/xterm )
"

src_install() {
	# install binaries

	exeinto "/usr/share/${PN}"

	doexe "src/${PN}" || die "doexe failed"
	dosym "/usr/share/${PN}/${PN}" "${ROOT}usr/bin/${PN}"

	if use X; then
		doexe "src/${PN}-gui" || die "doexe failed"
		dosym "/usr/share/${PN}/${PN}-gui" "/usr/bin/${PN}-gui"
	fi

	# install data
	insinto /etc
	newins "${S}/slimrat.conf" slimrat.conf

	insinto "/usr/share/${PN}"
	doins -r "src/"*.pm "src/Clipboard" "src/plugins/" "src/${PN}.glade" || die "doins failed"
}
