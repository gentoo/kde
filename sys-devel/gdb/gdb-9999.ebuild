# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gdb/gdb-6.8.50.20090811.2.12.ebuild,v 1.2 2009/09/08 17:50:05 vapier Exp $

EAPI="2"

# Settings for the upstream cvs server.
ECVS_SERVER="sourceware.org:/cvs/src"
ECVS_MODULE="gdb"
ECVS_LOCALNAME="src" 

inherit flag-o-matic eutils cvs

export CTARGET=${CTARGET:-${CHOST}}
if [[ ${CTARGET} == ${CHOST} ]] ; then
	if [[ ${CATEGORY/cross-} != ${CATEGORY} ]] ; then
		export CTARGET=${CATEGORY/cross-}
	fi
fi

if [[ ${PV} == *.*.*.*.*.* ]] ; then
	inherit versionator rpm
	# fedora version: gdb-6.8.50.20090302-8.fc11.src.rpm
	gvcr() { get_version_component_range "$@"; }
	MY_PV=$(gvcr 1-4)
	RPM="${PN}-${MY_PV}-$(gvcr 5).fc$(gvcr 6).src.rpm"
else
	MY_PV=${PV}
	RPM=
fi

PATCH_VER=""
DESCRIPTION="GNU debugger"
HOMEPAGE="http://sources.redhat.com/gdb/"
#if [[ -n ${RPM} ]] ; then
#	SRC_URI="http://mirrors.kernel.org/fedora/development/source/SRPMS/${RPM}"
#else
#	SRC_URI="http://ftp.gnu.org/gnu/gdb/${P}.tar.bz2
#		ftp://sources.redhat.com/pub/gdb/releases/${P}.tar.bz2"
#fi
#SRC_URI="${SRC_URI} ${PATCH_VER:+mirror://gentoo/${P}-patches-${PATCH_VER}.tar.lzma}"

LICENSE="GPL-2 LGPL-2"
[[ ${CTARGET} != ${CHOST} ]] \
	&& SLOT="${CTARGET}" \
	|| SLOT="0"
KEYWORDS=""
IUSE="expat multitarget nls python test vanilla"

RDEPEND=">=sys-libs/ncurses-5.2-r2
	sys-libs/readline
	expat? ( dev-libs/expat )"
DEPEND="${RDEPEND}
	|| ( app-arch/xz-utils app-arch/lzma-utils )
	test? ( dev-util/dejagnu )
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/src

src_configure() {
	strip-unsupported-flags
	econf \
		--disable-werror \
		$(has_version '=sys-libs/readline-5*' && echo --with-system-readline) \
		$(use_enable nls) \
		$(use multitarget && echo --enable-targets=all) \
		$(use_with expat) \
		$(use_with python) \
		|| die
}

src_compile() {
	emake -j1
}

src_test() {
	emake check || ewarn "tests failed"
}

src_install() {
	emake -j1 \
		DESTDIR="${D}" \
		libdir=/nukeme/pretty/pretty/please includedir=/nukeme/pretty/pretty/please \
		install || die
	rm -r "${D}"/nukeme || die

	# Don't install docs when building a cross-gdb
	if [[ ${CTARGET} != ${CHOST} ]] ; then
		rm -r "${D}"/usr/share
		return 0
	fi

	dodoc README
	docinto gdb
	dodoc gdb/CONTRIBUTE gdb/README gdb/MAINTAINERS \
		gdb/NEWS gdb/ChangeLog gdb/PROBLEMS
	docinto sim
	dodoc sim/ChangeLog sim/MAINTAINERS sim/README-HACKING

	dodoc "${WORKDIR}"/extra/gdbinit.sample

	# Remove shared info pages
	rm -f "${D}"/usr/share/info/{annotate,bfd,configure,standards}.info*
}

pkg_postinst() {
	# portage sucks and doesnt unmerge files in /etc
	rm -vf "${ROOT}"/etc/skel/.gdbinit
}
