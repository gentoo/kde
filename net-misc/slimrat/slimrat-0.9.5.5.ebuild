# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Linux Rapidshare downloader"
HOMEPAGE="http://code.google.com/p/slimrat/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X"

DEPEND="dev-perl/WWW-Mechanize
	virtual/perl-Getopt-Long
	virtual/perl-Term-ANSIColor

	X? (
		dev-perl/gtk2-gladexml
		dev-perl/Spiffy
		x11-misc/xclip
	)"
# aview: displaying captcha
RDEPEND="${DEPEND}
	media-gfx/aview
	X? ( x11-terms/xterm )
	"

src_install() {
	# install binaries

	exeinto "${ROOT}usr/share/${PN}"

	doexe ${PN} || die "doexe failed"
	dosym "${ROOT}usr/share/${PN}/${PN}" "${ROOT}usr/bin/${PN}"

	if use X; then
		doexe ${PN}-gui || die "doexe failed"
		dosym "${ROOT}usr/share/${PN}/${PN}-gui" "${ROOT}usr/bin/${PN}-gui"
	fi

	# install data
	insinto /etc
	newins "${S}/slimrat.config" slimrat.conf

	insinto "${ROOT}usr/share/${PN}"
	doins -r Clipboard.pm Clipboard Configuration.pm Log.pm Plugin.pm plugins Queue.pm slimrat.glade Toolbox.pm || die "doins failed"
}
