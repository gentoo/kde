# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="forceoptional"
ECM_TEST="forceoptional"
PYTHON_COMPAT=( python3_{10..12} )
KFMIN=6.12.0
QTMIN=6.7.2
inherit python-single-r1 ecm gear.kde.org optfeature xdg

DESCRIPTION="Localization tool for KDE software and other free and open source software"
HOMEPAGE="https://apps.kde.org/lokalize/ https://l10n.kde.org/tools/"

LICENSE="GPL-2" # TODO: CHECK
SLOT="6"
KEYWORDS=""
IUSE=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="test" # tests are broken, bug 739734

DEPEND="${PYTHON_DEPS}
	>=app-text/hunspell-1.2.8:=
	>=dev-qt/qtbase-${QTMIN}:6[dbus,gui,sql,widgets,xml]
	>=kde-frameworks/kcompletion-${KFMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kconfigwidgets-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kcrash-${KFMIN}:6
	>=kde-frameworks/kdbusaddons-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kiconthemes-${KFMIN}:6
	>=kde-frameworks/kio-${KFMIN}:6
	>=kde-frameworks/kitemviews-${KFMIN}:6
	>=kde-frameworks/knotifications-${KFMIN}:6
	>=kde-frameworks/kparts-${KFMIN}:6
	>=kde-frameworks/ktextwidgets-${KFMIN}:6
	>=kde-frameworks/kwidgetsaddons-${KFMIN}:6
	>=kde-frameworks/kxmlgui-${KFMIN}:6
	>=kde-frameworks/sonnet-${KFMIN}:6
"
RDEPEND="${DEPEND}
	$(python_gen_cond_dep '
		dev-python/translate-toolkit[${PYTHON_USEDEP}]
	')
"

src_install() {
	ecm_src_install
	rm "${ED}"/usr/share/lokalize/scripts/msgmerge.{py,rc} || die
	python_fix_shebang "${ED}"/usr/share/${PN}
}

pkg_postinst() {
	if [[ -z "${REPLACING_VERSIONS}" ]]; then
		optfeature "autofetch kde.org translations in new project wizard" dev-vcs/subversion
		optfeature "spell and grammar checking" app-text/languagetool
	fi
	xdg_pkg_postinst
}
