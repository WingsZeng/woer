# Copyright 2018-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="jjui is a TUI designed for interacting with the Jujutsu version control system
"
HOMEPAGE="https://github.com/idursun/jjui"
SRC_URI="
	https://github.com/idursun/jjui/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/WingsZeng/jjui-go-deps/releases/download/v${PV}/${P}-deps.tar.xz
"

# NOTE: To create the vendor tarball, run:
# `go mod vendor && cd .. && tar -caf ${P}-vendor.tar.xz ${P}/vendor`

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	>=dev-lang/go-1.25.0
"
RDEPEND=""
DEPEND="${RDEPEND}"

src_compile() {
	ego build -ldflags "-X 'main.Version=${PV}'" -o ${PN} cmd/jjui/main.go
}

src_install() {
	dobin ${PN}
}
