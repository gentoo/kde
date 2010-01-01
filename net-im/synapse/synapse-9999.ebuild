# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base mono git autotools

DESCRIPTION="XMPP client written in .Net"
HOMEPAGE="http://synapse.im/"
EGIT_REPO_URI="git://github.com/FireRabbit/synapse.git"

LICENSE="GPL-3"
KEYWORDS=""
SLOT="4"
IUSE=""

COMMONDEPEND="
	dev-dotnet/dbus-glib-sharp
	dev-dotnet/glib-sharp
	dev-dotnet/gtk-sharp
	>=dev-dotnet/mono-addins-0.3.1
	>=dev-dotnet/notify-sharp-0.4.0_pre
	>=kde-base/kdebindings-csharp-${KDE_MINIMAL}[webkit]
"
DEPEND="${COMMONDEPEND}
"
RDEPEND="${COMMONDEPEND}
"

EGIT_PATCHES=(
	"${FILESDIR}/${PN}-unbundle-libs.patch"
	"${FILESDIR}/${PN}-fix-libdir.patch"
)

src_prepare() {
	git_src_prepare

	rm -f contrib/Hyena.Gui.dll* contrib/Mono.Addins.* contrib/NDesk.Dbus.dll*

	eautoreconf
}

src_configure() {
	default
}

src_compile() {
	default
}

src_install() {
	emake DESTDIR="${D}" install || die
}
