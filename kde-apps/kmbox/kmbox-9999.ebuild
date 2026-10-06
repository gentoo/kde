# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_AUTODEPS="base"
ECM_QTHELP="false" # TODO: Port to ECMGenerateQDoc
ECM_TEST="true"
KFMIN=6.29.0
inherit ecm gear.kde.org

DESCRIPTION="Library for accessing MBox format mail storages"

LICENSE="GPL-2+"
SLOT="6/$(ver_cut 1-2)"
KEYWORDS=""
IUSE=""

DEPEND=">=kde-frameworks/kmime-${KFMIN}:6"
RDEPEND="${DEPEND}"
