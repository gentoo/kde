# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

VIRTUOSO_RELEASE='virtuoso-opensource-5.0.13'
DESCRIPTION="Nepomuk database from Virtuoso V5 to V6 converter"
HOMEPAGE="http://kde-apps.org/content/show.php?action=content&content=119661"
SRC_URI="
http://kde-apps.org/CONTENT/content-files/119661-${P}.tar.bz2
mirror://sourceforge/virtuoso/${VIRTUOSO_RELEASE}.tar.gz
"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug"

COMMON_DEPEND="
	dev-libs/libxml2:2
	>=dev-libs/openssl-0.9.7i:0
	>=dev-libs/soprano-2.3.68[dbus,raptor,virtuoso]
	>=kde-base/kdelibs-${KDE_MINIMAL}[semantic-desktop]
	sys-libs/zlib:0
"
DEPEND="${COMMON_DEPEND}
	>=sys-devel/bison-2.3
	>=sys-devel/flex-2.5.33
"
RDEPEND="${COMMON_DEPEND}"

PATCHES=(
	"${FILESDIR}/${P}-cmake.patch"
)

src_configure() {
	# Configure Virtuoso V5
	pushd "${WORKDIR}/${VIRTUOSO_RELEASE}" > /dev/null || die
	econf \
		--disable-all-vads \
		--disable-hslookup \
		--disable-imagemagick \
		--disable-imsg \
		--disable-openldap \
		--disable-pldebug \
		--disable-ruby \
		--disable-static \
		--disable-wbxml2 \
		--without-internal-zlib \
		--with-pthreads \
		--enable-shared

	popd > /dev/null || die

	kde4-base_src_configure
}

src_compile() {
	pushd "${WORKDIR}/${VIRTUOSO_RELEASE}" > /dev/null || die
	emake || die 'failed to build Virtuoso V5'
	popd /dev/null || die

	kde4-base_src_compile
}

pkg_postinst() {
	kde4-base_pkg_postinst

	echo
	elog "To convert your existing Nepomuk database, run for each user:"
	elog "$ virtuosoconverter --auto"
	echo
}
