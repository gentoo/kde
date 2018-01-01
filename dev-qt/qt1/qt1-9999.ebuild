# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 toolchain-funcs

DESCRIPTION="Historical copy of Qt 1, adapted to compile on modern systems (circa. 2016)"
HOMEPAGE="https://quickgit.kde.org/?p=qt1.git"
EGIT_REPO_URI="git://anongit.kde.org/${PN}.git"

LICENSE="Qt-Free-Edition"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	x11-libs/libX11
	x11-libs/libXext
"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	sed -i configs/linux-g++-shared \
		-e '/SYSCONF_LFLAGS_QT/s/lib/src/' \
		-e "/SYSCONF_CXX/s/g++/$(tc-getCC)/" \
		|| die
}

src_compile() {
	export QTDIR="${S}"
	emake linux-g++-shared
	emake
}

src_install() {
	into /opt/qt1
	dobin bin/moc
	dolib src/libqt.so*

	insinto /opt/qt1/include
	doins include/*
}
