# Copyright 2007-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# @ECLASS: qt4-build.eclass
# @MAINTAINER:
# Caleb Tennis <caleb@gentoo.org>
# @BLURB: Eclass for Qt4 split ebuilds.
# @DESCRIPTION:
# This eclass contains various functions that are used when building Qt4
#
#
#	draft #2 for qt4-build eclass
# 	6/1/2008
#	Markos Chandras (hwoarang) <hwoarang@silverarrow.gr>
#
# 	NOTES:
# 
#	*.9999 stands for 4.4.9999 live ebuils from kdesvn repository
#	*9999  stands for 9999 live ebuilds from trolltechs git repository
#
#
IUSE="${IUSE} debug pch"

case "${PV}" in
	*.9999)
		inherit eutils multilib toolchain-funcs flag-o-matic subversion
		;;
	*9999)
		inherit eutils multilib toolchain-funcs flag-o-matic git versionator
		;;
	*)
		inherit eutils multilib toolchain-funcs flag-o-matic
		;;
esac

case "${PV}" in
	4.*.*_beta*)
		SRCTYPE="${SRCTYPE:-opensource-src}"
		MY_PV="${PV/_beta/-beta}"
		;;
	4.*.0_rc*)
		SRCTYPE="${SRCTYPE:-opensource-src}"
		MY_PV="${PV/_rc/-rc}"
		;;
	*)
		SRCTYPE="${SRCTYPE:-opensource-src}"
		MY_PV="${PV}"
		;;
esac
MY_P=qt-x11-${SRCTYPE}-${MY_PV}
S=${WORKDIR}/${MY_P}

SRC_URI="ftp://ftp.trolltech.com/qt/source/${MY_P}.tar.bz2"

#fix 2
#removing svn stuff , use git variables instead
case "${PV}" in
	*.9999)
		ESVN_REPO_URI="svn://anonsvn.kde.org/home/trunk/qt-copy"
		ESVN_PROJECT="qt-copy"
		SRC_URI=
		;;
	*9999)
		EGIT_REPO_URI="git://labs.trolltech.com/qt/all"
		SRC_URI=
		;;
	4.4.2|4.4.1|4.4.0|4.4.0_rc*)
		SRC_URI="${SRC_URI} mirror://gentoo/${MY_P}-headers.tar.bz2"
		;;
	*)
		;;
esac

# fix 3
# Removing qt4-build_check_use
# See fix 9 for more informations
# !! AFFECTED EBUILDS !! #
#	4.5 and live fixed but not commited
#

qt4-build_pkg_setup() {
	# Check USE requirements
	#qt4-build_check_use

	# Set up installation directories
	QTBASEDIR=/usr/$(get_libdir)/qt4
	QTPREFIXDIR=/usr
	QTBINDIR=/usr/bin
	QTLIBDIR=/usr/$(get_libdir)/qt4
	QTPCDIR=/usr/$(get_libdir)/pkgconfig
	QTDATADIR=/usr/share/qt4
	QTDOCDIR=/usr/share/doc/qt-${PV}
	QTHEADERDIR=/usr/include/qt4
	QTPLUGINDIR=${QTLIBDIR}/plugins
	QTSYSCONFDIR=/etc/qt4
	QTTRANSDIR=${QTDATADIR}/translations
	QTEXAMPLESDIR=${QTDATADIR}/examples
	QTDEMOSDIR=${QTDATADIR}/demos

	PLATFORM=$(qt_mkspecs_dir)

	PATH="${S}/bin:${PATH}"
	LD_LIBRARY_PATH="${S}/lib:${LD_LIBRARY_PATH}"
}

qt4_unpack() {
	local target targets
	for target in configure LICENSE.{GPL2,GPL3} projects.pro \
		src/{qbase,qt_targets,qt_install}.pri bin config.tests mkspecs qmake \
		${QT4_EXTRACT_DIRECTORIES}; do
			targets="${targets} ${MY_P}/${target}"
	done
	case "${PV}" in
		*.9999)
			ESVN_REPO_FREQ=${ESVN_UP_FREQ:-1}
			subversion_src_unpack
			;;
		*9999)
			git_src_unpack
			;;
		*)
			echo tar xjpf "${DISTDIR}"/${MY_P}.tar.bz2 ${targets}
			tar xjpf "${DISTDIR}"/${MY_P}.tar.bz2 ${targets}
			;;
	esac

	case "${PV}" in
		# this could be moved above while removing ;;, but I'm not sure about consequences of unpacking reorder - yngwin? help :)
		4.4.2|4.4.1|4.4.0|4.4.0_rc*)
			echo tar xjpf "${DISTDIR}"/${MY_P}-headers.tar.bz2
			tar xjpf "${DISTDIR}"/${MY_P}-headers.tar.bz2
			;;
	esac
}

qt4-build_src_unpack() {
	qt4_unpack
	case "${PV}" in
		*.9999)
			# apply KDE patchset
			cd "${S}"
			python apply_patches.py || die "Applying KDE patchset failed"
			;;
	esac

	if [[ ${PN} != qt-core ]]; then
		cd "${S}"
		skip_qmake_build_patch
		skip_project_generation_patch
		symlink_binaries_to_buildtree
	fi

	sed -e "s:QMAKE_CFLAGS_RELEASE.*=.*:QMAKE_CFLAGS_RELEASE=${CFLAGS}:" \
		-e "s:QMAKE_CXXFLAGS_RELEASE.*=.*:QMAKE_CXXFLAGS_RELEASE=${CXXFLAGS}:" \
		-e "s:QMAKE_LFLAGS_RELEASE.*=.*:QMAKE_LFLAGS_RELEASE=${LDFLAGS}:" \
		-e "s:X11R6/::" \
		-i "${S}"/mkspecs/$(qt_mkspecs_dir)/qmake.conf || die "sed ${S}/mkspecs/$(qt_mkspecs_dir)/qmake.conf failed"

	sed -e "s:QMAKE_CFLAGS_RELEASE.*=.*:QMAKE_CFLAGS_RELEASE=${CFLAGS}:" \
		-e "s:QMAKE_CXXFLAGS_RELEASE.*=.*:QMAKE_CXXFLAGS_RELEASE=${CXXFLAGS}:" \
		-e "s:QMAKE_LFLAGS_RELEASE.*=.*:QMAKE_LFLAGS_RELEASE=${LDFLAGS}:" \
		-i "${S}"/mkspecs/common/g++.conf || die "sed ${S}/mkspecs/common/g++.conf failed"
}

#fix 6
#since EAPI 2 is using src_configure and src_compile functions
#we need to split the old src_compile function to src_configure and src_compile
qt4-build_src_configure() {
	# Don't let the user go too overboard with flags.  If you really want to, uncomment
	# out the line below and give 'er a whirl.
	strip-flags
	replace-flags -O3 -O2

	if [[ $(gcc-fullversion) == "3.4.6" && gcc-specs-ssp ]] ; then
		ewarn "Appending -fno-stack-protector to CFLAGS/CXXFLAGS"
		append-flags -fno-stack-protector
	fi

	# Bug 178652
	if [[ "$(gcc-major-version)" == "3" ]] && use amd64; then
		ewarn "Appending -fno-gcse to CFLAGS/CXXFLAGS"
		append-flags -fno-gcse
	fi

	myconf="$(standard_configure_options) ${myconf}"

	echo ./configure ${myconf}
	./configure ${myconf} || die "./configure failed"
}

#fix 7
# src_compile new implementation
qt4-build_src_compile() {
	build_directories "${QT4_TARGET_DIRECTORIES}"
}

qt4-build_src_install() {
	install_directories "${QT4_TARGET_DIRECTORIES}"
	install_qconfigs
	fix_library_files
}

standard_configure_options() {
	local myconf=""

	[[ $(get_libdir) != "lib" ]] && myconf="${myconf} -L/usr/$(get_libdir)"

	# Disable visibility explicitly if gcc version isn't 4
	if [[ "$(gcc-major-version)" -lt "4" ]]; then
		myconf="${myconf} -no-reduce-exports"
	fi

	# precompiled headers doesn't work on hardened, where the flag is masked.
	if use pch; then
		myconf="${myconf} -pch"
	else
		myconf="${myconf} -no-pch"
	fi

	if use debug; then
		myconf="${myconf} -debug -no-separate-debug-info"
	else
		myconf="${myconf} -release -no-separate-debug-info"
	fi

	# ARCH is set on Gentoo. QT now falls back to generic on an unsupported
	# ${ARCH}. Therefore we convert it to supported values.
	case "${ARCH}" in
		amd64) myconf="${myconf} -arch x86_64" ;;
		ppc|ppc64) myconf="${myconf} -arch powerpc" ;;
		x86|x86-*) myconf="${myconf} -arch i386" ;;
		alpha|arm|ia64|mips|s390|sparc) myconf="${myconf} -arch ${ARCH}" ;;
		hppa|sh) myconf="${myconf} -arch generic" ;;
		*) die "${ARCH} is unsupported by this eclass. Please file a bug." ;;
	esac

	myconf="${myconf} -stl -verbose -largefile -confirm-license -no-rpath
		-prefix ${QTPREFIXDIR} -bindir ${QTBINDIR} -libdir ${QTLIBDIR}
		-datadir ${QTDATADIR} -docdir ${QTDOCDIR} -headerdir ${QTHEADERDIR}
		-plugindir ${QTPLUGINDIR} -sysconfdir ${QTSYSCONFDIR}
		-translationdir ${QTTRANSDIR} -examplesdir ${QTEXAMPLESDIR}
		-demosdir ${QTDEMOSDIR} -silent -fast -reduce-relocations
		-nomake examples -nomake demos"

	echo "${myconf}"
}

#fix 8
#removing as obsolete. See fix #6
#build_directories is now called through qt4-build_src_compile function
#build_target_directories() {
#	build_directories "${QT4_TARGET_DIRECTORIES}"
#}

build_directories() {
	local dirs="$@"
	for x in ${dirs}; do
		cd "${S}"/${x}
		"${S}"/bin/qmake "LIBS+=-L${QTLIBDIR}" "CONFIG+=nostrip" || die "qmake failed"
		emake || die "emake failed"
	done
}

install_directories() {
	local dirs="$@"
	for x in ${dirs}; do
		pushd "${S}"/${x} >/dev/null || die "Can't pushd ${S}/${x}"
		emake INSTALL_ROOT="${D}" install || die "emake install failed"
		popd >/dev/null || die "Can't popd from ${S}/${x}"
	done
}

# @ECLASS-VARIABLE: QCONFIG_ADD
# @DESCRIPTION:
# List options that need to be added to QT_CONFIG in qconfig.pri
QCONFIG_ADD="${QCONFIG_ADD:-}"

# @ECLASS-VARIABLE: QCONFIG_REMOVE
# @DESCRIPTION:
# List options that need to be removed from QT_CONFIG in qconfig.pri
QCONFIG_REMOVE="${QCONFIG_REMOVE:-}"

# @ECLASS-VARIABLE: QCONFIG_DEFINE
# @DESCRIPTION:
# List variables that should be defined at the top of QtCore/qconfig.h
QCONFIG_DEFINE="${QCONFIG_DEFINE:-}"

install_qconfigs() {
	local x
	if [[ -n ${QCONFIG_ADD} || -n ${QCONFIG_REMOVE} ]]; then
		for x in QCONFIG_ADD QCONFIG_REMOVE; do
			[[ -n ${!x} ]] && echo ${x}=${!x} >> "${T}"/${PN}-qconfig.pri
		done
		insinto ${QTDATADIR}/mkspecs/gentoo
		doins "${T}"/${PN}-qconfig.pri || die "installing ${PN}-qconfig.pri failed"
	fi

	if [[ -n ${QCONFIG_DEFINE} ]]; then
		for x in ${QCONFIG_DEFINE}; do
			echo "#define ${x}" >> "${T}"/gentoo-${PN}-qconfig.h
		done
		insinto ${QTHEADERDIR}/Gentoo
		doins "${T}"/gentoo-${PN}-qconfig.h || die "installing ${PN}-qconfig.h failed"
	fi
}

# Stubs for functions used by the Qt 4.4.0_technical_preview_1.
qconfig_add_option() { : ; }
qconfig_remove_option() { : ; }

generate_qconfigs() {
	if [[ -n ${QCONFIG_ADD} || -n ${QCONFIG_REMOVE} || -n ${QCONFIG_DEFINE} || ${CATEGORY}/${PN} == x11-libs/qt-core ]]; then
		local x qconfig_add qconfig_remove qconfig_new
		for x in "${ROOT}${QTDATADIR}"/mkspecs/gentoo/*-qconfig.pri; do
			[[ -f ${x} ]] || continue
			qconfig_add="${qconfig_add} $(sed -n 's/^QCONFIG_ADD=//p' "${x}")"
			qconfig_remove="${qconfig_remove} $(sed -n 's/^QCONFIG_REMOVE=//p' "${x}")"
		done

		# these error checks do not use die because dying in pkg_post{inst,rm}
		# just makes things worse.
		if [[ -e "${ROOT}${QTDATADIR}"/mkspecs/gentoo/qconfig.pri ]]; then
			# start with the qconfig.pri that qt-core installed
			if ! cp "${ROOT}${QTDATADIR}"/mkspecs/gentoo/qconfig.pri \
				"${ROOT}${QTDATADIR}"/mkspecs/qconfig.pri; then
				eerror "cp qconfig failed."
				return 1
			fi

			# generate list of QT_CONFIG entries from the existing list
			# including qconfig_add and excluding qconfig_remove
			for x in $(sed -n 's/^QT_CONFIG +=//p' \
				"${ROOT}${QTDATADIR}"/mkspecs/qconfig.pri) ${qconfig_add}; do
					hasq ${x} ${qconfig_remove} || qconfig_new="${qconfig_new} ${x}"
			done

			# replace the existing QT_CONFIG list with qconfig_new
			if ! sed -i -e "s/QT_CONFIG +=.*/QT_CONFIG += ${qconfig_new}/" \
				"${ROOT}${QTDATADIR}"/mkspecs/qconfig.pri; then
				eerror "Sed for QT_CONFIG failed"
				return 1
			fi

			# create Gentoo/qconfig.h
			if [[ ! -e ${ROOT}${QTHEADERDIR}/Gentoo ]]; then
				if ! mkdir -p "${ROOT}${QTHEADERDIR}"/Gentoo; then
					eerror "mkdir ${QTHEADERDIR}/Gentoo failed"
					return 1
				fi
			fi
			: > "${ROOT}${QTHEADERDIR}"/Gentoo/gentoo-qconfig.h
			for x in "${ROOT}${QTHEADERDIR}"/Gentoo/gentoo-*-qconfig.h; do
				[[ -f ${x} ]] || continue
				cat "${x}" >> "${ROOT}${QTHEADERDIR}"/Gentoo/gentoo-qconfig.h
			done
		else
			rm -f "${ROOT}${QTDATADIR}"/mkspecs/qconfig.pri
			rm -f "${ROOT}${QTHEADERDIR}"/Gentoo/gentoo-qconfig.h
			rmdir "${ROOT}${QTDATADIR}"/mkspecs \
				"${ROOT}${QTDATADIR}" \
				"${ROOT}${QTHEADERDIR}"/Gentoo \
				"${ROOT}${QTHEADERDIR}" 2>/dev/null
		fi
	fi
}

qt4-build_pkg_postrm() {
	generate_qconfigs
}

qt4-build_pkg_postinst() {
	generate_qconfigs
	#since we have two 9999 packages , it is wise to let the user know , which
	#live ebuild is the one he installed. Feel free to change the messages. They
	# just examples
	case "${PN}" in
		*.9999)
			elog "Qt live version from kdesvn repository";;
		*9999)
			elog "Qt live version from trolltechs' git repository" ;;
	esac
}

skip_qmake_build_patch() {
	# Don't need to build qmake, as it's already installed from qt-core
	sed -i -e "s:if true:if false:g" "${S}"/configure || die "Sed failed"
}

skip_project_generation_patch() {
	# Exit the script early by throwing in an exit before all of the .pro files are scanned
	sed -e "s:echo \"Finding:exit 0\n\necho \"Finding:g" \
		-i "${S}"/configure || die "Sed failed"
}

symlink_binaries_to_buildtree() {
	for bin in qmake moc uic rcc; do
		ln -s ${QTBINDIR}/${bin} "${S}"/bin/ || die "Symlinking ${bin} to ${S}/bin failed."
	done
}

fix_library_files() {
	for libfile in "${D}"/${QTLIBDIR}/{*.la,*.prl,pkgconfig/*.pc}; do
		if [[ -e ${libfile} ]]; then
			sed -i -e "s:${S}/lib:${QTLIBDIR}:g" ${libfile} || die "Sed on ${libfile} failed."
		fi
	done

	# pkgconfig files refer to WORKDIR/bin as the moc and uic locations.  Fix:
	for libfile in "${D}"/${QTLIBDIR}/pkgconfig/*.pc; do
		if [[ -e ${libfile} ]]; then
			sed -i -e "s:${S}/bin:${QTBINDIR}:g" ${libfile} || die "Sed failed"

	# Move .pc files into the pkgconfig directory

		dodir ${QTPCDIR}
		mv ${libfile} "${D}"/${QTPCDIR}/ \
			|| die "Moving ${libfile} to ${D}/${QTPCDIR}/ failed."
		fi
	done

	# Don't install an empty directory
	rmdir "${D}"/${QTLIBDIR}/pkgconfig
}

qt_use() {
	local flag="${1}"
	local feature="${1}"
	local enableval=

	[[ -n ${2} ]] && feature=${2}
	[[ -n ${3} ]] && enableval="-${3}"

	if use ${flag}; then
		echo "${enableval}-${feature}"
	else
		echo "-no-${feature}"
	fi
}

# Fix 9
# removing obsolete stuff here
# Using EAPI Use dependencies indead


# @ECLASS-VARIABLE: QT4_BUILT_WITH_USE_CHECK
# @DESCRIPTION:
# The contents of $QT4_BUILT_WITH_USE_CHECK gets fed to built_with_use
# (eutils.eclass), line per line.
#
# Example:
# @CODE
# pkg_setup() {
# 	use qt3support && QT4_BUILT_WITH_USE_CHECK="${QT4_BUILT_WITH_USE_CHECK}
# 		~x11-libs/qt-gui-${PV} qt3support"
# 	qt4-build_check_use
# }
# @CODE

# Run built_with_use on each flag and print appropriate error messages if any
# flags are missing
#_qt_built_with_use() {
#	local missing opt pkg flag flags
#
#	if [[ ${1} = "--missing" ]]; then
#		missing="${1} ${2}" && shift 2
#	fi
#	if [[ ${1:0:1} = "-" ]]; then
#		opt=${1} && shift
#	fi
#
#	pkg=${1} && shift
#
#	for flag in "${@}"; do
#		flags="${flags} ${flag}"
#		if ! built_with_use ${missing} ${opt} ${pkg} ${flag}; then
#			flags="${flags}*"
#		else
#			[[ ${opt} = "-o" ]] && return 0
#		fi
#	done
#	if [[ "${flags# }" = "${@}" ]]; then
#		return 0
#	fi
#	if [[ ${opt} = "-o" ]]; then
#		eerror "This package requires '${pkg}' to be built with any of the following USE flags: '$*'."
#	else
#		eerror "This package requires '${pkg}' to be built with the following USE flags: '${flags# }'."
#	fi
#	return 1
#}
#
## @FUNCTION: qt4-build_check_use
# @DESCRIPTION:
# Check if the listed packages in $QT4_BUILT_WITH_USE_CHECK are built with the
# USE flags listed.
#
# If any of the required USE flags are missing, an eerror will be printed for
# each package with missing USE flags.
#qt4-build_check_use() {
#	local line missing
#	while read line; do
#		[[ -z ${line} ]] && continue
#		if ! _qt_built_with_use ${line}; then
#			missing=true
#		fi
#	done <<< "${QT4_BUILT_WITH_USE_CHECK}"
#	if [[ -n ${missing} ]]; then
#		echo
#		eerror "Flags marked with an * are missing."
#		die "Missing USE flags found"
#	fi
#}

qt_mkspecs_dir() {
	# Allows us to define which mkspecs dir we want to use.
	local spec

	case ${CHOST} in
		*-freebsd*|*-dragonfly*)
			spec="freebsd" ;;
		*-openbsd*)
			spec="openbsd" ;;
		*-netbsd*)
			spec="netbsd" ;;
		*-darwin*)
			spec="darwin" ;;
		*-linux-*|*-linux)
			spec="linux" ;;
		*)
			die "Unknown CHOST, no platform choosen."
	esac

	CXX=$(tc-getCXX)
	if [[ ${CXX/g++/} != ${CXX} ]]; then
		spec="${spec}-g++"
	elif [[ ${CXX/icpc/} != ${CXX} ]]; then
		spec="${spec}-icc"
	else
		die "Unknown compiler ${CXX}."
	fi

	echo "${spec}"
}
#fix 10
#exporting src_configure function
EXPORT_FUNCTIONS pkg_setup src_unpack src_configure src_compile src_install pkg_postrm pkg_postinst
