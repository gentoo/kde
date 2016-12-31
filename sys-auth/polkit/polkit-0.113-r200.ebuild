# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
inherit eutils multilib pam pax-utils systemd user xdg

DESCRIPTION="Policy framework for controlling privileges for system-wide services"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/polkit"
SRC_URI="https://www.freedesktop.org/software/${PN}/releases/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="elogind examples gtk +introspection jit kde nls pam selinux systemd test"

CDEPEND="
	dev-lang/spidermonkey:0/mozjs185[-debug]
	>=dev-libs/glib-2.32:2
	>=dev-libs/expat-2:=
	elogind? ( sys-auth/elogind )
	introspection? ( >=dev-libs/gobject-introspection-1:= )
	pam? (
		sys-auth/pambase
		virtual/pam
		)
	systemd? ( sys-apps/systemd:0= )
"
DEPEND="${CDEPEND}
	app-text/docbook-xml-dtd:4.1.2
	app-text/docbook-xsl-stylesheets
	dev-libs/libxslt
	dev-util/gtk-doc-am
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig
"
RDEPEND="${CDEPEND}
	selinux? ( sec-policy/selinux-policykit )
"
PDEPEND="
	gtk? ( >=gnome-extra/polkit-gnome-0.105 )
	kde? ( || (
		kde-plasma/polkit-kde-agent
		sys-auth/polkit-kde-agent
		) )
	!systemd? ( sys-auth/consolekit[policykit] )
"

QA_MULTILIB_PATHS="
	usr/lib/polkit-1/polkit-agent-helper-1
	usr/lib/polkit-1/polkitd"

pkg_setup() {
	local u=polkitd
	local g=polkitd
	local h=/var/lib/polkit-1

	enewgroup ${g}
	enewuser ${u} -1 -1 ${h} ${g}
	esethome ${u} ${h}
}

src_prepare() {
	sed -i -e 's|unix-group:wheel|unix-user:0|' src/polkitbackend/*-default.rules || die #401513

	# Workaround upstream hack around standard gtk-doc behavior, bug #552170
	sed -i -e 's/@ENABLE_GTK_DOC_TRUE@\(TARGET_DIR\)/\1/' \
		-e '/install-data-local:/,/uninstall-local:/ s/@ENABLE_GTK_DOC_TRUE@//' \
		-e 's/@ENABLE_GTK_DOC_FALSE@install-data-local://' \
		docs/polkit/Makefile.in || die

	if use elogind; then
		sed -i -e "s/libsystemd-login/libelogind/" -e "s|test ! -d /sys/fs/cgroup/systemd/|false|" configure || die
		sed -i -e "s/systemd/elogind/" src/polkit/polkitunixsession-systemd.c src/polkitbackend/polkitbackendsessionmonitor-systemd.c src/polkitbackend/polkitbackendjsauthority.c || die
	fi
}

src_configure() {
	xdg_environment_reset

	econf \
		--localstatedir="${EPREFIX}"/var \
		--disable-static \
		--enable-man-pages \
		--disable-gtk-doc \
		$(use_enable systemd libsystemd-login) \
		$(use_enable elogind) \
		$(use_enable introspection) \
		--disable-examples \
		$(use_enable nls) \
		--with-mozjs=mozjs185 \
		"$(systemd_with_unitdir)" \
		--with-authfw=$(usex pam pam shadow) \
		$(use pam && echo --with-pam-module-dir="$(getpam_mod_dir)") \
		$(use_enable test) \
		--with-os-type=gentoo
}

src_compile() {
	default

	# Required for polkitd on hardened/PaX due to spidermonkey's JIT
	pax-mark mr src/polkitbackend/.libs/polkitd test/polkitbackend/.libs/polkitbackendjsauthoritytest
}

src_install() {
	emake DESTDIR="${D}" install

	dodoc docs/TODO HACKING NEWS README

	fowners -R polkitd:root /{etc,usr/share}/polkit-1/rules.d

	diropts -m0700 -o polkitd -g polkitd
	keepdir /var/lib/polkit-1

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins src/examples/{*.c,*.policy*}
	fi

	prune_libtool_files
}

pkg_postinst() {
	chown -R polkitd:root "${EROOT}"/{etc,usr/share}/polkit-1/rules.d
	chown -R polkitd:polkitd "${EROOT}"/var/lib/polkit-1
}
