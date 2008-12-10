# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/kde.eclass,v 1.222 2008/10/11 21:31:19 cryos Exp $

# @ECLASS: kde.eclass
# @MAINTAINER:
# kde@gentoo.org
#
# original author Dan Armak <danarmak@gentoo.org>
#
# Revisions Caleb Tennis <caleb@gentoo.org>
# @BLURB: The kde eclass is inherited by all kde-* eclasses.
# @DESCRIPTION:
# This eclass is inherited by all kde-* eclasses. Few ebuilds inherit straight from here.

[[ -z ${WANT_AUTOMAKE} ]] && WANT_AUTOMAKE="1.9"

inherit base eutils kde-functions flag-o-matic libtool autotools

DESCRIPTION="Based on the $ECLASS eclass"
HOMEPAGE="http://www.kde.org/"
IUSE="debug elibc_FreeBSD"


if [[ ${CATEGORY} == "kde-base" ]]; then
	if [[ ${PV##*.} -lt 10 ]] ; then
		# Keep old ebuilds as is
	        IUSE="${IUSE} kdeenablefinal"
	else
		# Don't use --enable-final anymore. Does only cause problems for users and
		# as an unwelcome extra invalid bug reports, without any reasonable benefit.

		# Get the aRts dependencies right - finally.
		case "${PN}" in
			blinken|juk|kalarm|kanagram|kbounce|kcontrol|konq-plugins|kscd|kscreensaver|kttsd|kwifimanager|kdelibs) ARTS_REQUIRED="" ;;
			artsplugin-*|kaboodle|kasteroids|kdemultimedia-arts|kolf|krec|ksayit|noatun*) ARTS_REQUIRED="yes" ;;
			*) ARTS_REQUIRED="never" ;;
		esac
	fi
fi

if [[ ${ARTS_REQUIRED} != "yes" && ${ARTS_REQUIRED} != "never" && ${PN} != "arts" ]]; then
	IUSE="${IUSE} arts"
fi

# @ECLASS-VARIABLE: KDE_S
# @DESCRIPTION:
# Like the 'normal' ${S} this variable takes the path to the temporary build
# directory. If unset ${S} will be used.

# @ECLASS-VARIABLE: USE_KEG_PACKAGING
# @DESCRIPTION:
# Set USE_KEG_PACKAGING=1 before inheriting if the package use extragear-like
# packaging and then supports ${LANGS} and ${LANGS_DOC} variables. By default
# translations are found in the po subdirectory of ${S}. Set KEG_PO_DIR to
# override this default.
if [[ -n ${USE_KEG_PACKAGING} && -n "${LANGS}${LANGS_DOC}" ]]; then
	for lang in ${LANGS} ${LANGS_DOC}; do
		IUSE="${IUSE} linguas_${lang}"
	done
fi

DEPEND="sys-devel/make
	dev-util/pkgconfig
	dev-lang/perl"

if [[ ${CATEGORY} != "kde-base" ]] || [[ ${CATEGORY} == "kde-base" &&  ${PV##*.} -lt 10 ]] ; then
	DEPEND="${DEPEND}
		x11-libs/libXt
		x11-proto/xf86vidmodeproto
		xinerama? ( x11-proto/xineramaproto )"
	RDEPEND="xinerama? ( x11-libs/libXinerama )"
	IUSE="${IUSE} xinerama"
else
	RDEPEND=""
fi

if [[ ${ARTS_REQUIRED} == "yes" ]]; then
	DEPEND="${DEPEND} kde-base/arts"
	RDEPEND="${RDEPEND} kde-base/arts"
elif [[ ${ARTS_REQUIRED} != "never" && ${PN} != "arts" ]]; then
	DEPEND="${DEPEND} arts? ( kde-base/arts )"
	RDEPEND="${RDEPEND} arts? ( kde-base/arts )"
fi

# overridden in other places like kde-dist, kde-source and some individual ebuilds
SLOT="0"

# @ECLASS-VARIABLE: ARTS_REQUIRED
# @DESCRIPTION:
# Is aRTs-support required or not? Possible values are 'yes', 'never'. Otherwise
# leave this variable unset. This results in an arts USE flag.

# @FUNCTION: kde_pkg_setup
# @DESCRIPTION:
# Some basic test about arts-support. It also filters some compiler flags
kde_pkg_setup() {
	if [[ ${PN} != "arts" ]] && [[ ${PN} != "kdelibs" ]] ; then
		if [[ ${ARTS_REQUIRED} == 'yes' ]] || \
			( [[ ${ARTS_REQUIRED} != "never" ]] && use arts )  ; then
			if ! built_with_use =kde-base/kdelibs-3.5* arts ; then
				if has arts ${IUSE} && use arts; then
					eerror "You are trying to compile ${CATEGORY}/${PF} with the \"arts\" USE flag enabled."
				else
					eerror "The package ${CATEGORY}/${PF} you're trying to merge requires aRTs."
				fi
				eerror "However, $(best_version =kde-base/kdelibs-3.5*) was compiled with the arts USE flag disabled."
				eerror
				if has arts ${IUSE} && use arts; then
					eerror "You must either disable this USE flag, or recompile"
				else
					eerror "To build this package you have to recompile"
				fi
				eerror "$(best_version =kde-base/kdelibs-3.5*) with the arts USE flag enabled."
				die "kdelibs missing arts"
			fi
		fi
	fi

	if [[ "${PN}" = "kdelibs" ]]; then
		use doc && if ! built_with_use =x11-libs/qt-3* doc ; then
			eerror "Building kdelibs with the doc USE flag requires qt to be built with the doc USE flag."
			eerror "Please re-emerge qt-3 with this USE flag enabled."
		fi
	fi

	# Let filter visibility flags that will *really* hurt your KDE
	# _experimental_ support for this is enabled by kdehiddenvisibility useflag
	filter-flags -fvisibility=hidden -fvisibility-inlines-hidden
}

# @FUNCTION: kde_src_unpack
# @DESCRIPTION:
# This function unpacks the sources and patches it. The patches need to be named
# $PN-$PV-*{diff,patch}
#
# This function also handles the linguas if extragear-like packaging is enabled.
# (See USE_KEG_PACKAGING)
kde_src_unpack() {
	debug-print-function $FUNCNAME "$@"

	[[ -z "${KDE_S}" ]] && KDE_S="${S}"

	local PATCHDIR="${WORKDIR}/patches/"
	if [[ -z "$@" ]] ; then
		# Unpack first and deal with KDE patches after examing possible patch sets.
		# To be picked up, patches need to be named $PN-$PV-*{diff,patch} and be
		# placed in $PATCHDIR. Monolithic ebuilds will use the split ebuild patches.
		[[ -d "${KDE_S}" ]] || base_src_unpack unpack
		if [[ -d "${PATCHDIR}" ]] ; then
			local packages p f
			if is-parent-package ${CATEGORY}/${PN} ; then
				packages="$(get-child-packages ${CATEGORY}/${PN})"
				packages="${packages//${CATEGORY}\//} ${PN}"
			else
				packages="${PN}"
			fi
			if [[ -n ${PATCHES[@]} && $(declare -p PATCHES) != 'declare -a '* ]]; then
				PATCHES=(${PATCHES})
			fi
			for p in ${packages}; do
				for f in "${PATCHDIR}"/${p}-${PV}-*{diff,patch}; do
					[[ -e ${f} ]] && PATCHES+=("${f}")
				done
				if [[ -n "${KDEBASE}" ]]; then
					for f in "${PATCHDIR}"/${p}-${SLOT}-*{diff,patch}; do
						[[ -e ${f} ]] && PATCHES+=("${f}")
					done
				fi
			done
		fi
		[[ -n ${PATCHES[@]} ]] && base_src_unpack autopatch
	else
		# Call base_src_unpack, which has sections, to do unpacking and patching
		# step by step transparently as defined in the ebuild.
		base_src_unpack "$@"
	fi

	# if extragear-like packaging is enabled, set the translations and the
	# documentation depending on LINGUAS settings
	if [[ -n ${USE_KEG_PACKAGING} ]]; then
		if [[ -z ${LINGUAS} ]]; then
			einfo "You can drop some of the translations of the interface and"
			einfo "documentation by setting the \${LINGUAS} variable to the"
			einfo "languages you want installed."
			einfo
			einfo "Enabling all languages"
		else
			# we sanitise LINGUAS to avoid issues when a user specifies the same
			# linguas twice. bug #215016.
			local sanitised_linguas=$(echo "${LINGUAS}" | tr '[[:space:]]' '\n' | sort | uniq)
			if [[ -n ${LANGS} ]]; then
				MAKE_PO=$(echo "${sanitised_linguas} ${LANGS}" | tr '[[:space:]]' '\n' | sort | uniq -d | tr '\n' ' ')
				einfo "Enabling translations for: ${MAKE_PO}"
				sed -i -e "s:^SUBDIRS[ \t]*=.*:SUBDIRS = ${MAKE_PO}:" "${KDE_S}/${KEG_PO_DIR:-po}/Makefile.am" \
					|| die "sed for locale failed"
				rm -f "${KDE_S}/configure"
			fi

			if [[ -n ${LANGS_DOC} ]]; then
				MAKE_DOC=$(echo "${sanitised_linguas} ${LANGS_DOC}" | tr '[[:space:]]' '\n' | sort | uniq -d | tr '\n' ' ')
				einfo "Enabling documentation for: ${MAKE_DOC}"
				[[ -n ${MAKE_DOC} ]] && [[ -n ${DOC_DIR_SUFFIX} ]] && MAKE_DOC=$(echo "${MAKE_DOC}" | tr '\n' ' ') && MAKE_DOC="${MAKE_DOC// /${DOC_DIR_SUFFIX} }"
				sed -i -e "s:^SUBDIRS[ \t]*=.*:SUBDIRS = ${MAKE_DOC} ${PN}:" \
					"${KDE_S}/doc/Makefile.am" || die "sed for locale failed"
				rm -f "${KDE_S}/configure"
			fi
		fi
	fi

	# fix the 'languageChange undeclared' bug group: touch all .ui files, so that the
	# makefile regenerate any .cpp and .h files depending on them.
	cd "${KDE_S}"
	debug-print "$FUNCNAME: Searching for .ui files in ${PWD}"
	UIFILES="$(find . -name '*.ui' -print)"
	debug-print "$FUNCNAME: .ui files found:"
	debug-print "$UIFILES"
	# done in two stages, because touch doens't have a silent/force mode
	if [[ -n "$UIFILES" ]]; then
		debug-print "$FUNCNAME: touching .ui files..."
		touch $UIFILES
	fi

	if [[ -d "${WORKDIR}/admin" ]] && [[ -d "${KDE_S}/admin" ]]; then
		ebegin "Updating admin/ directory..."
		rm -rf "${KDE_S}/admin" "${KDE_S}/configure" || die "Unable to remove old admin/ directory"
		ln -s "${WORKDIR}/admin" "${KDE_S}/admin" || die "Unable to symlink the new admin/ directory"
		eend 0
	fi
}

# @FUNCTION: kde_src_compile
# @USAGE: [ myconf ] [ configure ] [ make ] [ all ]
# @DESCRIPTION:
# This function compiles the sources. It takes care of "cannot write to .kde
# or .qt"-problem due to sandbox and some other sandbox issues.
#
# If no argument is given, all is assumed.
kde_src_compile() {
	debug-print-function $FUNCNAME "$@"

	[[ -z "$1" ]] && kde_src_compile all

	[[ -z "${KDE_S}" ]] && KDE_S="${S}"
	cd "${KDE_S}"

	export kde_widgetdir="$KDEDIR/$(get_libdir)/kde3/plugins/designer"

	# fix the sandbox errors "can't writ to .kde or .qt" problems.
	# this is a fake homedir that is writeable under the sandbox, so that the build process
	# can do anything it wants with it.
	REALHOME="$HOME"
	mkdir -p "${T}"/fakehome/.kde
	mkdir -p "${T}"/fakehome/.qt
	export HOME="${T}"/fakehome
	addwrite "${QTDIR}/etc/settings"

	# Fix bug 96177: if KDEROOTHOME is defined, the ebuild accesses the real homedir via it, and not our exported $HOME
	unset KDEHOME
	unset KDEROOTHOME

	# things that should access the real homedir
	[[ -d "$REALHOME/.ccache" ]] && ln -sf "$REALHOME/.ccache" "$HOME/"

	while [[ "$1" ]]; do

		case $1 in
			myconf)
				debug-print-section myconf
				if [[ ${CATEGORY} != "kde-base" ]] || [[ ${CATEGORY} == "kde-base" &&  ${PV##*.} -lt 10 ]] ; then
					myconf+=" --with-x --enable-mitshm $(use_with xinerama) --with-qt-dir=${QTDIR} --enable-mt --with-qt-libraries=${QTDIR}/$(get_libdir)"
				else
					myconf+=" --with-qt-dir=${QTDIR} --enable-mt --with-qt-libraries=${QTDIR}/$(get_libdir)"
				fi
				# calculate dependencies separately from compiling, enables ccache to work on kde compiles
				myconf="$myconf --disable-dependency-tracking"
				if use debug ; then
					myconf="$myconf --enable-debug=full --with-debug"
				else
					myconf="$myconf --disable-debug --without-debug"
				fi
				if hasq kdeenablefinal ${IUSE}; then
					myconf="$myconf $(use_enable kdeenablefinal final)"
				fi
				if [[ ${ARTS_REQUIRED} == "never" ]]; then
					myconf="$myconf --without-arts"
				elif [[ ${ARTS_REQUIRED} != 'yes' && ${PN} != "arts" ]]; then
					# This might break some external package until
					# ARTS_REQUIRED="yes" is set on them, KDE 3.2 is no more
					# supported anyway.
					myconf="$myconf $(use_with arts)"
				fi
				debug-print "$FUNCNAME: myconf: set to ${myconf}"
				;;
			configure)
				debug-print-section configure
				debug-print "$FUNCNAME::configure: myconf=$myconf"

				export WANT_AUTOMAKE

				# rebuild configure script, etc
				# This can happen with e.g. a cvs snapshot
				if [[ ! -f "./configure" ]]; then
					# This is needed to fix building with autoconf 2.60.
					# Many thanks to who preferred such a stupid check rather
					# than a working arithmetic comparison.
					if [[ -f admin/cvs.sh ]]; then
						sed -i -e '/case $AUTO\(CONF\|HEADER\)_VERSION in/,+1 s/2\.5/2.[56]/g' \
							admin/cvs.sh
					fi

					# Replace the detection script with a dummy, let our wrappers do the work
					if [[ -f admin/detect-autoconf.sh ]]; then
						cat - > admin/detect-autoconf.sh <<EOF
#!/bin/sh
export AUTOCONF="autoconf"
export AUTOHEADER="autoheader"
export AUTOM4TE="autom4te"
export AUTOMAKE="automake"
export ACLOCAL="aclocal"
export WHICH="which"
EOF
					fi

					for x in Makefile.cvs admin/Makefile.common; do
						if [[ -f "$x" && -z "$makefile" ]]; then makefile="$x"; fi
					done
					if [[ -f "$makefile" ]]; then
						debug-print "$FUNCNAME: configure: generating configure script, running make -f $makefile"
						emake -j1 -f $makefile
					fi
					[[ -f "./configure" ]] || die "no configure script found, generation unsuccessful"
				fi

				export PATH="${KDEDIR}/bin:${PATH}"

				# configure doesn't need to know about the other KDEs installed.
				# in fact, if it does, it sometimes tries to use the wrong dcopidl, etc.
				# due to the messed up way configure searches for things
				export KDEDIRS="${PREFIX}:${KDEDIR}"

				# Visiblity stuff is broken. Just disable it when it's present.
				export kde_cv_prog_cxx_fvisibility_hidden=no

				if hasq kdehiddenvisibility ${IUSE} && use kdehiddenvisibility; then
					if [[ $(gcc-major-version)$(gcc-minor-version) -ge 41 ]]; then
						if [[ ${PN} != "kdelibs" && ${PN} != "arts" ]] && \
							! fgrep -q "#define __KDE_HAVE_GCC_VISIBILITY" "${KDEDIR}/include/kdemacros.h"; then

							eerror "You asked to enable hidden visibility, but your kdelibs was"
							eerror "built without its support. Please rebuild kdelibs with the"
							eerror "kdehiddenvisibility useflag enabled."
							die "kdelibs without hidden visibility"
						else
							unset kde_cv_prog_cxx_fvisibility_hidden
							myconf="$myconf $(use_enable kdehiddenvisibility gcc-hidden-visibility)"
						fi
					else
						eerror "You're trying to enable hidden visibility, but"
						eerror "you are using an old GCC version. Hidden visibility"
						eerror "can be enabled only with GCC 4.1 and later."
					fi
				fi

				# If we're in a kde-base ebuild, set the prefixed directories to
				# override the ones set by econf.
				if [[ -n ${PREFIX} && ${PREFIX} != "/usr" ]]; then
					myconf="${myconf} --prefix=${PREFIX}
						--mandir=${PREFIX}/share/man
						--infodir=${PREFIX}/share/info
						--datadir=${PREFIX}/share
						--sysconfdir=${PREFIX}/etc"
				fi

				# Use libsuffix to keep KDE happy, the --libdir parameter get
				# still honored.
				if [[ $(get_libdir) != "lib" ]] ; then
					myconf="${myconf} --enable-libsuffix=$(get_libdir | sed s/lib//)"
				fi

				export PATH="${KDEDIR}/bin:${PATH}"

				# The configure checks for kconfig_compiler do not respect PATH
				export KCONFIG_COMPILER="${KDEDIR}/bin/kconfig_compiler"

				# Sometimes it doesn't get the include and library paths right,
				# so hints them.
				if [[ -z ${PREFIX} || ${PREFIX} != ${KDEDIR} ]]; then
					myconf="${myconf} --with-extra-includes=${KDEDIR}/include
						--with-extra-libs=${KDEDIR}/$(get_libdir)"
				fi

				if grep "cope with newer libtools" "${KDE_S}/admin/ltconfig" &> /dev/null; then
					einfo "Removing the dummy ltconfig file."
					rm "${KDE_S}/admin/ltconfig"
				fi

				use elibc_FreeBSD && myconf="${myconf} --disable-pie"

				elibtoolize
				econf ${myconf} || die "died running ./configure, $FUNCNAME:configure"

				# Seems ./configure add -O2 by default but hppa don't want that but we need -ffunction-sections
				if [[ "${ARCH}" = "hppa" ]]
				then
					einfo "Fixing Makefiles"
					find "${KDE_S}" -name Makefile -print0 | xargs -0 sed -i -e \
						's:-O2:-ffunction-sections:g'
				fi
				;;
			make)
				debug-print-section make
				emake || die "died running emake, $FUNCNAME:make"
				;;
			all)
				debug-print-section all
				kde_src_compile myconf configure make
				;;
		esac

	shift
	done

}

# @FUNCTION: kde_src_install
# @USAGE: [ make ] [ dodoc ] [ all ]
# @DESCRIPTION:
# This installs the software, including the right handling of the
# "/usr/share/doc/kde"-dir, but it only installs AUTHORS, ChangeLog*, README*,
# NEWS, and TODO (if available) as docs.
#
# If no argument is given, all is assumed
kde_src_install() {
	debug-print-function $FUNCNAME "$@"

	[[ -z "$1" ]] && kde_src_install all

	[[ -z ${KDE_S} ]] && KDE_S="${S}"
	cd "${KDE_S}"

	# Ensure that KDE binaries take precedence
	export PATH="${KDEDIR}/bin:${PATH}"

	while [[ "$1" ]]; do

		case $1 in
			make)
				debug-print-section make
				emake install DESTDIR="${D}" destdir="${D}" || die "died running make install, $FUNCNAME:make"
				;;
			dodoc)
				debug-print-section dodoc
				for doc in AUTHORS ChangeLog* README* NEWS TODO; do
					[[ -s "$doc" ]] && dodoc $doc
				done
				;;
			all)
				debug-print-section all
				kde_src_install make dodoc
				;;
		esac

	shift
	done

	if [[ -n ${KDEBASE} && "${PN}" != "arts" && -d "${D}"/usr/share/doc/${PF} ]]; then
		# work around bug #97196
		dodir /usr/share/doc/kde && \
			mv "${D}"/usr/share/doc/${PF} "${D}"/usr/share/doc/kde/ || \
			die "Failed to move docs to kde/ failed."
	fi
}

# @FUNCTION: slot_rebuild
# @USAGE: [ list_of_packages_to_check ]
# @RETURN: False, if no rebuild is required
# @DESCRIPTION:
# Unneeded and therefore deprecated for a long, long time now. Ebuilds are still
# referencing it, so replacing with a stub.
# Looks for packages in the supplied list of packages which have not been linked
# against this kde SLOT. It does this by looking for lib*.la files that doesn't
# contain the current ${KDEDIR}. If it finds any thus broken packages it prints
# eerrors and return True.
#
# Thanks to Carsten Lohrke in bug 98425.
slot_rebuild() {
	:
}

# @FUNCTION: kde_pkg_preinst
# @DESCRIPTION:
# Calls postprocess_desktop_entries
kde_pkg_preinst() {
	postprocess_desktop_entries
}

# @FUNCTION: kde_pkg_postinst
# @DESCRIPTION:
# Calls buildsycoca
kde_pkg_postinst() {
	buildsycoca
}

# @FUNCTION: kde_pkg_postrm
# @DESCRIPTION:
# Calls buildsycoca
kde_pkg_postrm() {
	buildsycoca
}

EXPORT_FUNCTIONS pkg_setup src_unpack src_compile src_install pkg_postinst pkg_postrm pkg_preinst
