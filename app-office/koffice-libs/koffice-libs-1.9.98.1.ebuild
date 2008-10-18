# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="koffice"
KMMODULE="libs"
NEED_KDE=":4.1"
inherit kde4-meta

DESCRIPTION="Shared KOffice libraries."
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=app-office/koffice-data-${PV}:${SLOT}
	dev-libs/libxml2
	dev-libs/libxslt
	>=media-libs/lcms-1.15
	>=media-libs/openexr-1.2.2-r2"
DEPEND="${RDEPEND}"
#	doc? ( app-doc/doxygen )"

KMEXTRA="
	doc/koffice/
	doc/thesaurus/
	filters/libkowmf/
	filters/xsltfilter/
	filters/generic_wrapper/
	interfaces/
	kounavail/
	plugins/
	tools/"
#	doc/api/"
KMEXTRACTONLY="
		kchart/kdchart/
		changes-1.4
		changes-1.5
		doc/koffice.desktop"

src_install() {
	dodoc changes-*
	newdoc kounavail/README README.kounavail

	kde4-meta_src_install
}
