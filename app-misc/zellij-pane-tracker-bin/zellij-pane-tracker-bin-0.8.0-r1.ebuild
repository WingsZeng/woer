# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="7d246862359b2b28166a4ac44bf5bd8e2b38cdf5"

DESCRIPTION="Zellij plugin that exports pane names to JSON for shell integration"
HOMEPAGE="https://github.com/theslyprofessor/zellij-pane-tracker"
SRC_URI="
	https://github.com/WingsZeng/zellij-pane-tracker/releases/download/build-$COMMIT/zellij-pane-tracker.wasm -> ${P}.wasm
	https://github.com/WingsZeng/zellij-pane-tracker/releases/download/build-$COMMIT/zellij-pane-tracker-mcp -> ${P}-mcp
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

# bun binary should not be stripped
RESTRICT="strip"

src_unpack() {
	mkdir "${S}"
	cp "${DISTDIR}/${P}.wasm" "${S}/zellij-pane-tracker.wasm"
	cp "${DISTDIR}/${P}-mcp" "${S}/zellij-pane-tracker-mcp"
}

src_install() {
	insinto /usr/share/zellij/plugins/
	doins zellij-pane-tracker.wasm
	exeinto /usr/share/zellij/plugins/
	doexe zellij-pane-tracker-mcp
}
