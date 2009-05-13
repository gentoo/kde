# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit confutils

DESCRIPTION="Linux Rapidshare downloader"
HOMEPAGE="http://code.google.com/p/slimrat/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X +cli"

DEPEND="dev-perl/WWW-Mechanize
	cli? (
		virtual/perl-Getopt-Long
		virtual/perl-Term-ANSIColor
	)
	X? (
		dev-perl/gtk2-gladexml
		dev-perl/Spiffy
	)"
RDEPEND="${DEPEND}"

pkg_setup() {
	confutils_require_any X cli
}

src_prepare() {
	esvn_clean
}

src_install() {
	# install binaries
	exeinto ${ROOT}usr/share/${PN}
	if use cli; then
		doexe ${PN} || die "doexe failed"
		dosym ${ROOT}usr/share/${PN}/${PN} ${ROOT}usr/bin/${PN}
	fi
	if use X; then
		doexe ${PN}-gui || die "doexe failed"
		dosym ${ROOT}usr/share/${PN}/${PN}-gui ${ROOT}usr/bin/${PN}-gui
	fi
	# install data
	insinto ${ROOT}usr/share/${PN}
	doins -r Clipboard.pm Clipboard Plugin.pm plugins slimrat.glade Toolbox.pm || die "doins failed"
}
