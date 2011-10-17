# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
KDE_SCM="git"
inherit kde4-base

DESCRIPTION="A multimedia player for different online platforms."
HOMEPAGE="projects.kde.org/projects/playground/multimedia/kubeplayer"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug gstreamer"

DEPEND="
       kde-base/smokekde
       kde-base/smokegen
       kde-base/smokeqt
       dev-ruby/json
       kde-base/korundum
       gstreamer? (
                               media-plugins/gst-plugins-faad
                               media-plugins/gst-plugins-soup
                               media-plugins/gst-plugins-ffmpeg
       )
"
RDEPEND="${DEPEND}"
