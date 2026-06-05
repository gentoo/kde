# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_QTHELP="false" # TODO: Port to ECMGenerateQDoc
ECM_TEST="true"
KFMIN=6.22.0
inherit ecm gear.kde.org

DESCRIPTION="Libary for handling mail messages and newsgroup articles"

LICENSE="GPL-2+"
SLOT="6/$(ver_cut 1-2)"
KEYWORDS=""
IUSE=""

DEPEND=">=kde-frameworks/kcodecs-${KFMIN}:6"
RDEPEND="${DEPEND}
	|| (
		>=kde-frameworks/kmime-6.27.0
		>=kde-apps/kmime-common-${PV}
	)
"

DOCS=( AUTHORS README.md TODO )

CMAKE_SKIP_TESTS=(
	# bug 924507
	kmime-{header,message}test
)

src_prepare() {
	ecm_src_prepare

	sed -e "s/^ecm_install_po_files_as_qm(poqm)/#& # packaged separately/" \
		-i CMakeLists.txt || die
	sed -e "s/^ecm_qt_install_logging_categories.*/#& packaged separately/" \
		-i src/CMakeLists.txt || die
}
