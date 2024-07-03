# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A zellij plugin that automatically switches between normal mode and locked mode"
HOMEPAGE="https://github.com/WingsZeng/zjswitcher"
SRC_URI="https://github.com/WingsZeng/zjswitcher/releases/download/v${PV}/zjswitcher.wasm -> ${P}.wasm"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_unpack() {
	mkdir "${S}"
	cp "${DISTDIR}/${P}.wasm" "${S}/zjswitcher.wasm"
}

src_install() {
	insinto /usr/share/zellij/plugins/
	doins zjswitcher.wasm
}
