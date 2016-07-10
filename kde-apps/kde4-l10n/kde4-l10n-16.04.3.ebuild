# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_HANDBOOK="optional"
KMNAME="kde-l10n"
inherit kde4-base

DESCRIPTION="KDE legacy internationalization package"
HOMEPAGE="http://l10n.kde.org"

KEYWORDS="~amd64 ~arm ~x86"

DEPEND="
	sys-devel/gettext
"
RDEPEND="
	>=kde-apps/kde-l10n-${PV}
"

REMOVE_DIRS="${FILESDIR}/${PN}-16.04.2-remove-dirs"
REMOVE_MSGS="${FILESDIR}/${PN}-16.03.91-remove-messages"

# /usr/portage/distfiles $ ls -1 kde-l10n-*-${PV}.* |sed -e 's:-${PV}.tar.xz::' -e 's:kde-l10n-::' |tr '\n' ' '
# Make this correspond with kde5.eclass; important: L10N, not LINGUAS here!
KDE_L10N=(
	ar ast bg bs ca ca-valencia cs da de el en-GB eo es et eu fa fi fr ga
	gl he hi hr hu ia id is it ja kk km ko lt lv mr nb nds nl nn pa pl pt pt-BR ro
	ru sk sl sr sr-ijekavsk sr-Latn sr-Latn-ijekavsk sv tr ug uk wa zh-CN zh-TW
)

# TODO: Drop no-op +minimal in 16.08.x - necessary kde5.eclass change happened after KF-5.23/Plasma-5.6.5
IUSE="+minimal test $(printf 'l10n_%s ' ${KDE_L10N[@]})"

URI_BASE="${SRC_URI/-${PV}.tar.xz/}"
SRC_URI=""

kde_l10n2lingua() {
	local l
	for l; do
		case ${l} in
			ca-valencia) echo ca@valencia;;
			sr-ijekavsk) echo sr@ijekavian;;
			sr-Latn-ijekavsk) echo sr@ijekavianlatin;;
			sr-Latn) echo sr@latin;;
			uz-Cyrl) echo uz@cyrillic;;
			*) echo "${l/-/_}";;
		esac
	done
}

for my_l10n in ${KDE_L10N[@]} ; do
	case ${my_l10n} in
		sr | sr-ijekavsk | sr-Latn-ijekavsk | sr-Latn)
			SRC_URI="${SRC_URI} l10n_${my_l10n}? ( ${URI_BASE}/${KMNAME}-sr-${PV}.tar.xz )"
			;;
		*)
			SRC_URI="${SRC_URI} l10n_${my_l10n}? ( ${URI_BASE}/${KMNAME}-$(kde_l10n2lingua ${my_l10n})-${PV}.tar.xz )"
			;;
	esac
done

S="${WORKDIR}"

pkg_setup() {
	if [[ -z ${A} ]]; then
		elog
		elog "None of the requested L10N are supported by ${P}."
		elog
		elog "${P} supports these language codes:"
		elog "${KDE_L10N[@]}"
		elog
	fi
	[[ -n ${A} ]] && kde4-base_pkg_setup
}

src_unpack() {
	for my_tar in ${A}; do
		tar -xpf "${DISTDIR}/${my_tar}" --xz \
			"${my_tar/.tar.xz/}/CMakeLists.txt" "${my_tar/.tar.xz/}/4" 2> /dev/null ||
			elog "${my_tar}: tar extract command failed at least partially - continuing"
	done
}

src_prepare() {
	default
	[[ -n ${A} ]] || return

	# move known variant subdirs to root dir, currently sr@*
	use_if_iuse l10n_sr-ijekavsk && _l10n_variant_subdir2root sr-ijekavsk sr
	use_if_iuse l10n_sr-Latn-ijekavsk && _l10n_variant_subdir2root sr-Latn-ijekavsk sr
	use_if_iuse l10n_sr-Latn && _l10n_variant_subdir2root sr-Latn sr
	if use_if_iuse l10n_sr; then
		rm -rf kde-l10n-sr-${PV}/4/sr/sr@* || die "Failed to cleanup L10N=sr"
		_l10n_variant_subdir_buster sr
	elif [[ -d kde-l10n-sr-${PV} ]]; then
		# having any variant selected means parent lingua will be unpacked as well
		rm -r kde-l10n-sr-${PV} || die "Failed to remove sr parent lingua"
	fi

	# add all l10n to cmake
	cat <<-EOF > CMakeLists.txt || die
project(kde4-l10n)
cmake_minimum_required(VERSION 2.8.12)
$(printf "add_subdirectory( %s )\n" `find . -mindepth 1 -maxdepth 1 -type d -name "*${PV}*"`)
EOF

	# Drop KF5-based part
	find -maxdepth 2 -type f -name CMakeLists.txt -exec \
		sed -i -e "/add_subdirectory(5)/ s/^/#DONT/" {} + || die

	einfo "Removing file collisions with Plasma 5 and Applications"
	[[ -f ${REMOVE_DIRS} ]] || die "Error: ${REMOVE_DIRS} not found!"
	[[ -f ${REMOVE_MSGS} ]] || die "Error: ${REMOVE_MSGS} not found!"

	use test && einfo "Tests enabled: Listing LINGUAS causing file collisions"

	einfo "Directories..."
	while read path; do
		if use test ; then	# build a report w/ L10N="*" to submit @upstream
			local lngs
			for lng in $(kde_l10n2lingua ${KDE_L10N[@]}); do
				SDIR="${S}/${KMNAME}-${lng}-${PV}/4/${lng}"
				if [[ -d "${SDIR}"/${path%\ *}/${path#*\ } ]] ; then
					lngs+=" ${lng}"
				fi
			done
			[[ -n "${lngs}" ]] && einfo "${path%\ *}/${path#*\ }${lngs}"
			unset lngs
		fi
		if ls -U ./*/4/*/${path%\ *}/${path#*\ } > /dev/null 2>&1; then
			sed -e "\:add_subdirectory(\s*${path#*\ }\s*): s:^:#:" \
				-i ./*/4/*/${path%\ *}/CMakeLists.txt || \
				die "Failed to comment out ${path}"
		else
			einfo "F: ${path}"	# run with L10N="*" to cut down list
		fi
	done < <(grep -ve "^$\|^\s*\#" "${REMOVE_DIRS}")
	einfo
	einfo "Messages..."
	while read path; do
		if use test ; then	# build a report w/ L10N="*" to submit @upstream
			local lngs
			for lng in $(kde_l10n2lingua ${KDE_L10N[@]}); do
				SDIR="${S}/${KMNAME}-${lng}-${PV}/4/${lng}"
				if [[ -e "${SDIR}"/messages/${path} ]] ; then
					lngs+=" ${lng}"
				fi
			done
			[[ -n "${lngs}" ]] && einfo "${path}${lngs}"
			unset lngs
		fi
		if ls -U ./*/4/*/messages/${path} > /dev/null 2>&1; then
			rm ./*/4/*/messages/${path} || die "Failed to remove ${path}"
		else
			einfo "F: ${path}"	# run with L10N="*" to cut down list
		fi
	done < <(grep -ve "^$\|^\s*\#" "${REMOVE_MSGS}")
}

src_configure() {
	mycmakeargs=(
		-DBUILD_docs=$(usex handbook)
	)
	[[ -n ${A} ]] && kde4-base_src_configure
}

src_compile() {
	[[ -n ${A} ]] && kde4-base_src_compile
}

src_test() { :; }

src_install() {
	[[ -n ${A} ]] && kde4-base_src_install
}

_l10n_variant_subdir2root() {
	local lingua=$(kde_l10n2lingua ${1})
	local src=kde-l10n-${2}-${PV}
	local dest=kde-l10n-${lingua}-${PV}/4

	# create variant rootdir structure from parent lingua and adapt it
	mkdir -p ${dest} || die "Failed to create ${dest}"
	mv ${src}/4/${2}/${lingua} ${dest}/${lingua} || die "Failed to create ${dest}/${lingua}"
	cp -f ${src}/CMakeLists.txt kde-l10n-${lingua}-${PV} || die "Failed to prepare L10N=${1} subdir"
	echo "add_subdirectory(${lingua})" > ${dest}/CMakeLists.txt ||
		die "Failed to prepare ${dest}/CMakeLists.txt"
	cp -f ${src}/4/${2}/CMakeLists.txt ${dest}/${lingua} ||
		die "Failed to create ${dest}/${lingua}/CMakeLists.txt"
	sed -e "s/${2}/${lingua}/" -i ${dest}/${lingua}/CMakeLists.txt ||
		die "Failed to prepare ${dest}/${lingua}/CMakeLists.txt"

	_l10n_variant_subdir_buster ${1}
}

_l10n_variant_subdir_buster() {
	local dir=kde-l10n-$(kde_l10n2lingua ${1})-${PV}/4/$(kde_l10n2lingua ${1})

	sed -e "/^macro.*subdirectory(/d" -i ${dir}/CMakeLists.txt || die "Failed to cleanup ${dir} subdir"

	for subdir in $(find ${dir} -mindepth 1 -maxdepth 1 -type d | sed -e "s:^\./::"); do
		echo "add_subdirectory(${subdir##*/})" >> ${dir}/CMakeLists.txt
	done
}
