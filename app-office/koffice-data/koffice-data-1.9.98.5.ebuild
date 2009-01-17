# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"


KMNAME="koffice"
KMNOMODULE="true"
inherit kde4-meta

DESCRIPTION="Shared KOffice data files."

KEYWORDS="~amd64 ~x86"
IUSE=""

KMEXTRA="pics/
		servicetypes/
		templates/"
KMEXTRACTONLY="
	doc/CMakeLists.txt
	doc/koffice.desktop"

src_install() {
	kde4-meta_src_install
	# remove duplicate icons
	rm -rf "${D}"/"${KDEDIR}"/share/icons/oxygen/16x16/actions/{\
format-{justify-{center,fill,left,right},text-{bold,italic,underline}},\
object-{group,ungroup,order-{back,front,lower,raise}}}.png
}
