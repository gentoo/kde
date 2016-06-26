# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_HANDBOOK="optional"
inherit kde5

DESCRIPTION="KDE PIM internationalization package"
HOMEPAGE="http://l10n.kde.org"

KEYWORDS="~amd64 ~x86"

DEPEND="
	$(add_frameworks_dep ki18n)
	$(add_qt_dep linguist-tools)
	sys-devel/gettext
"
RDEPEND="
	!<kde-apps/kde-l10n-15.08.0-r1
	!<kde-apps/kde4-l10n-4.14.3-r1
"

# /usr/portage/distfiles $ ls -1 kde-l10n-*-${PV}.* |sed -e 's:-${PV}.tar.xz::' -e 's:kde-l10n-::' |tr '\n' ' '
MY_LANGS="ar ast bg bs ca ca@valencia cs da de el en_GB eo es et eu fa fi fr ga
gl he hi hr hu ia id is it ja kk km ko lt lv mr nb nds nl nn pa pl pt pt_BR ro
ru sk sl sr sv tr ug uk wa zh_CN zh_TW"

IUSE="$(printf 'linguas_%s ' ${MY_LANGS})"

PIM_L10N="kdepim kdepimlibs kdepim-runtime pim"

URI_BASE="${SRC_URI/-${PV}.tar.xz/}"
SRC_URI=""
for my_lang in ${MY_LANGS} ; do
	SRC_URI="${SRC_URI} linguas_${my_lang}? ( ${URI_BASE/kdepim/kde}/kde-l10n-${my_lang}-${PV}.tar.xz )"
done

S="${WORKDIR}"

pkg_setup() {
	if [[ -z ${A} ]]; then
		elog
		elog "You either have the LINGUAS variable unset, or it only"
		elog "contains languages not supported by ${P}."
		elog "You won't have any additional language support."
		elog
		elog "${P} supports these language codes:"
		elog "${MY_LANGS}"
		elog
	fi
	[[ -n ${A} ]] && kde5_pkg_setup
}

src_unpack() {
	for my_tar in ${A}; do
		tar -xpf "${DISTDIR}/${my_tar}" --xz \
			"${my_tar/.tar.xz/}/CMakeLists.txt" "${my_tar/.tar.xz/}/5" 2> /dev/null ||
			elog "${my_tar}: tar extract command failed at least partially - continuing"
	done
}

src_prepare() {
	default
	[[ -n ${A} ]] || return

	# add all linguas to cmake
	cat <<-EOF > CMakeLists.txt || die
project(kdepim-l10n)
cmake_minimum_required(VERSION 2.8.12)
$(printf "add_subdirectory( %s )\n" \
	`find . -mindepth 1 -maxdepth 1 -type d | sed -e "s:^\./::"`)
EOF

	# Drop KDE4-based part
	find -maxdepth 2 -type f -name CMakeLists.txt -exec \
		sed -i -e "/add_subdirectory(4)/ s/^/#DONT/" {} + || die

	# Handbook optional
	find -type f -name CMakeLists.txt -exec \
		sed -i -e "/find_package.*KF5DocTools/ s/ REQUIRED//" {} + || die
	if ! use handbook ; then
		find -mindepth 4 -maxdepth 4 -type f -name CMakeLists.txt -exec \
			sed -i -e '/add_subdirectory(docs)/ s/^/#DONT/' {} + || die
	fi

	# Remove everything except kdepim, kdepimlibs, kdepim-runtime and pim
	local LNG DIR
	for LNG in ${LINGUAS}; do
		DIR="kde-l10n-${LNG}-${PV}"
		SDIR="${S}/${DIR}/5/${LNG}"
		if [[ -d "${DIR}" ]] ; then

			for SUBDIR in data docs messages scripts ; do
				if [[ -d "${SDIR}/${SUBDIR}" ]] ; then
					einfo "   ${SUBDIR} subdirectory"
					echo > "${SDIR}/${SUBDIR}/CMakeLists.txt"
					for pim in ${PIM_L10N}; do
						[[ -d "${SDIR}/${SUBDIR}/${pim}" ]] && \
							( echo "add_subdirectory(${pim})" >> "${SDIR}/${SUBDIR}/CMakeLists.txt" )
					done
				fi
			done

			# In some cases we may have sub-lingua subdirs, e.g. sr :(
			for XSUBDIR in "${SDIR}/${LNG}"@* ; do
				XLNG=$(echo ${XSUBDIR}|sed -e 's:^.*/::')
				if [[ -d "${XSUBDIR}" ]] ; then
					einfo "   ${XLNG} variant"
					# remove everything except kdepim and kdepim-runtime
					for SUBDIR in data docs messages scripts ; do
						if [[ -d "${XSUBDIR}/${SUBDIR}" ]] ; then
							einfo "      ${SUBDIR} subdirectory"
							echo > "${XSUBDIR}/${SUBDIR}/CMakeLists.txt"
							for pim in ${PIM_L10N}; do
								[[ -d "${XSUBDIR}/${SUBDIR}/${pim}" ]] && \
									( echo "add_subdirectory(${pim})" >> "${XSUBDIR}/${SUBDIR}/CMakeLists.txt" )
							done
						fi
					done
				fi
			done
		fi
	done
}

src_configure() {
	[[ -n ${A} ]] && kde5_src_configure
}

src_compile() {
	[[ -n ${A} ]] && kde5_src_compile
}

src_test() {
	[[ -n ${A} ]] && kde5_src_test
}

src_install() {
	[[ -n ${A} ]] && kde5_src_install
}
