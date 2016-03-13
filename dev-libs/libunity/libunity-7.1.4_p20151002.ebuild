# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python{2_7,3_3,3_4,3_5} )

VALA_MIN_API_VERSION=0.26
inherit autotools eutils autotools python-r1 vala

MY_PV=${PV/_p/+15.10.}
DESCRIPTION="Library for instrumenting and integrating with all aspects of the Unity shell"
HOMEPAGE="https://launchpad.net/libunity"
SRC_URI="mirror://ubuntu/pool/main/libu/${PN}/${PN}_${MY_PV}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0/9.0.2"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

DEPEND=">=dev-libs/dee-1.2.5:=
	dev-libs/libdbusmenu:=
	dev-libs/libgee:0
	x11-libs/gtk+:3
	${PYTHON_DEPS}
	$(vala_depend)"

S=${WORKDIR}/${PN}-${MY_PV}

src_prepare() {
	vala_src_prepare
	export VALA_API_GEN="$VAPIGEN"
	default
	eautoreconf
}

src_configure() {
	python_copy_sources
	configuration() {
		econf
	}
	python_foreach_impl run_in_build_dir configuration
}

src_compile() {
	compilation() {
		emake
	}
	python_foreach_impl run_in_build_dir compilation
}

src_install() {
	installation() {
		emake DESTDIR="${D}" install
	}
	python_foreach_impl run_in_build_dir installation
	prune_libtool_files --modules
}
