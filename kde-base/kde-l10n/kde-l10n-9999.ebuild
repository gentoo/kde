# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

NEED_KDE="svn"
inherit kde4svn

DESCRIPTION="KDE internationalization package"
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2"

KEYWORDS=""
IUSE="+doc"

DEPEND=">=sys-devel/gettext-0.17"

LANGS="af ar be bg bn bn_IN br ca crh cs csb cy da de el en_GB eo es et eu fa fi fr
	fy ga gl gu ha he hi hr hsb hu hy is it ja ka kk km kn ko ku lb lt lv mk ml
	ms mt nb nds ne nl nn nso oc pa pl pt pt_BR ro ru rw se sk sl sr sv ta te tg
	th tr uk uz vi wa xh zh_CN zh_HK zh_TW"

RESTRICT="test"

for lang in ${LANGS}; do
	IUSE="${IUSE} linguas_${lang}"
done

pkg_setup() {
	if [[ -n ${LINGUAS//[[:space:]]} ]]; then
		for lang in ${LANGS}; do
			use linguas_${lang} && enabled_linguas+=" ${lang}"
		done
	fi
	if [[ -z ${enabled_linguas} ]]; then
		echo
		ewarn "You either have the LINGUAS variable unset, or it only"
		ewarn "contains languages not supported by ${P}."
		ewarn "You won't have any additional language support."
		echo
		ewarn "${P} supports these language codes:"
		while read line; do ewarn "${line}"; done <<< "${LANGS}"
		echo
		die "Nothing to install."
	fi
}

src_unpack() {
	ESVN_PROJECT="KDE/${PN}"
	for lang in ${enabled_linguas}; do
		ESVN_REPO_URI="svn://anonsvn.kde.org/home/kde/trunk/l10n-kde4/${lang}"
		S="${WORKDIR}"/${PN}/${lang}
		subversion_src_unpack
	done

	ESVN_REPO_URI="svn://anonsvn.kde.org/home/kde/trunk/l10n-kde4/scripts"
	S="${WORKDIR}"/${PN}/scripts
	kde4svn_src_unpack
	S="${WORKDIR}"/${PN}
}

src_compile() {
	cat <<-EOF > "${S}"/CMakeLists.txt
	project(kde-l10n)

	find_package(KDE4 REQUIRED)
	include (KDE4Defaults)
	include(MacroOptionalAddSubdirectory)

	find_package(Gettext REQUIRED)

	EOF

	cd "${S}"
	for lang in ${enabled_linguas} ; do
		"${S}"/scripts/autogen.sh ${lang}
		echo "add_subdirectory( ${lang} )" >> "${S}"/CMakeLists.txt
		if ! use doc; then
			sed -e '/docs/ s:^:#DONOTWANT:' \
				-i "${S}"/${lang}/CMakeLists.txt \
				|| die "Disabling docs for ${lang} failed."
		fi
	done
	kde4overlay-base_src_compile
}
