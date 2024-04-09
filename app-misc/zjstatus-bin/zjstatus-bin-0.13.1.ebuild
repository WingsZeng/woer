# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A configurable statusbar plugin for zellij"
HOMEPAGE="https://github.com/dj95/zjstatus/"
SRC_URI="https://github.com/dj95/zjstatus/releases/download/v${PV}/zjstatus.wasm"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_unpack() {
	mkdir "${S}"
	cp "${DISTDIR}/zjstatus.wasm" "${S}"/
}

src_install() {
	insinto /usr/share/zellij/plugins/
	doins zjstatus.wasm
}
