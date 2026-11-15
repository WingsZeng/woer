# Copyright 2024-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Execute scripts on IMAP mailbox changes using IDLE"

HOMEPAGE="https://gitlab.com/shackra/goimapnotify"

SRC_URI="
	https://gitlab.com/shackra/${PN}/-/archive/${PV}/${P}.tar.bz2
	https://github.com/WingsZeng/goimapnotify-go-deps/releases/download/v${PV}/${P}-deps.tar.xz
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	ego build ./cmd/goimapnotify
}

src_install() {
	dobin goimapnotify
}
