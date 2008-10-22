# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
 
EAPI="1"
 
NEED_KDE="svn"
SLOT="kde-svn"
inherit kde4svn
 
# Install to KDEDIR rather than /usr, to slot properly.
PREFIX="${KDEDIR}"
 
DESCRIPTION="Eigen 2 is a C++ template library for linear algebra"
HOMEPAGE="http://eigen.tuxfamily.org"
ESVN_REPO_URI="svn://anonsvn.kde.org/home/kde/trunk/kdesupport/eigen2"
LICENSE="GPL-2"
 
src_compile() {
        kde4overlay-base_src_compile
}
