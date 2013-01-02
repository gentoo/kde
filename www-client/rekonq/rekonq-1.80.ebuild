# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/rekonq/rekonq-1.2.ebuild,v 1.1 2012/10/13 20:55:09 johu Exp $

EAPI=4

WEBKIT_REQUIRED="always"
QT_MINIMAL="4.8"
KDE_MINIMAL="4.7"
# handbook and linguas not shipped in preview
#KDE_LINGUAS="bg bs ca ca@valencia cs da de el en_GB eo es et eu fa fi fr ga gl
#hu is it ja km ko lt nb nds nl pl pt pt_BR ro ru sk sl sr sr@ijekavian
#sr@ijekavianlatin sr@latin sv th tr ug uk zh_CN zh_TW"
#KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="A browser based on qt-webkit"
HOMEPAGE="http://rekonq.kde.org/"
[[ ${PV} != *9999* ]] && SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug opera semantic-desktop"

DEPEND="
	$(add_kdebase_dep kdelibs 'semantic-desktop=')
	opera? (
		app-crypt/qca:2
		dev-libs/qoauth
	)
"
RDEPEND="${DEPEND}"

# docs are not shipped in preview
#src_prepare() {
	# KDE_LINGUAS is also used to install appropriate handbooks
	# since there is no en_US 'translation', it cannot be added
	# hence making this impossible to install
#	mv doc/en_US doc/en || die "doc move failed"
#	sed -i -e 's/en_US/en/' doc/CMakeLists.txt || die "sed failed"
#	kde4-base_src_prepare
#}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with opera QCA2)
		$(cmake-utils_use_with opera QtOAuth)
		$(cmake-utils_use_with semantic-desktop Nepomuk)
	)

	kde4-base_src_configure
}
