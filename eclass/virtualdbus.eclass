# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Based on virtualx.eclass

# @ECLASS: virtualdbus.eclass
# @MAINTAINER:
#  kde@gentoo.org
# @BLURB: This eclass can be used for packages that needs a working dbus session bus during test phase. UNTESTED SO FAR.

# @ECLASS_VARIABLE: VIRTUALDBUS_REQUIRED
# @DESCRIPTION:
#  Is a dependency on dbus etc needed?
#  Valid values are "always", "optional", and "manual".
#  "tests" is a synonym for "optional".
: ${VIRTUALDBUS_REQUIRED:=optional}

# @ECLASS_VARIABLE: VIRTUALDBUS_USE
# @DESCRIPTION:
#  If VIRTUALDBUS_REQUIRED=optional, what USE flag should control
#  the dependency?
: ${VIRTUALDBUS_USE:=test}

# @ECLASS_VARIABLE: VIRTUALDBUS_DEPEND
# @DESCRIPTION:
#  Dep string available for use outside of eclass, in case a more
#  complicated dep is needed.
VIRTUALDBUS_DEPEND="dev-util/dbus-test-runner"

case ${VIRTUALDBUS_REQUIRED} in
	always)
		DEPEND="${VIRTUALDBUS_DEPEND}"
		RDEPEND=""
		;;
	optional|tests)
		DEPEND="${VIRTUALDBUS_USE}? ( ${VIRTUALDBUS_DEPEND} )"
		RDEPEND=""
		IUSE="${VIRTUALDBUS_USE}"
		;;
	manual)
		;;
	*)
		eerror "Invalid value (${VIRTUALDBUS_REQUIRED}) for VIRTUALDBUS_REQUIRED"
		eerror "Valid values are:"
		eerror "  always"
		eerror "  optional (default if unset)"
		eerror "  manual"
		die "Invalid value (${VIRTUALDBUS_REQUIRED}) for VIRTUALDBUS_REQUIRED"
		;;
esac

# @FUNCTION: virtualdbus_start
# @DESCRIPTION: 
#  Runs its argument with a test dbus session activated
virtualdbus_start() {
	dbus-test-runner "$@"
}
