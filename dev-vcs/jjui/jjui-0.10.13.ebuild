# Copyright 2018-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="A TUI for interacting with the Jujutsu version control system"
HOMEPAGE="https://github.com/idursun/jjui"
SRC_URI="
	https://github.com/idursun/jjui/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/WingsZeng/jjui-go-deps/releases/download/v${PV}/${P}-deps.tar.xz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	>=dev-lang/go-1.27.0
"

RDEPEND="
	>=dev-vcs/jj-0.39
"

src_compile() {
	ego build -ldflags "-X 'main.Version=${PV}'" -o ${PN} ./cmd/jjui
}

src_install() {
	dobin ${PN}
}
