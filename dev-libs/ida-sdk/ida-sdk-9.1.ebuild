# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="IDA SDK"
HOMEPAGE="https://hex-rays.com/ida-pro/"
MAJOR_MINOR="$(ver_cut 1)$(ver_cut 2)"
SRC_URI="https://gentoo.wingszeng.top/idasdk${MAJOR_MINOR}.zip -> ${P}.zip"

LICENSE="EULA"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip splitdebug"

S="${WORKDIR}/idasdk${MAJOR_MINOR}"

PATCHES=(${FILESDIR}/0001-feat-range-add-getter-for-the-internal-range-vector.patch)

src_compile() {
        # leave empty to not make
        return
}

src_install() {
        insinto "/opt/${PN}"
        doins -r ./*
}
