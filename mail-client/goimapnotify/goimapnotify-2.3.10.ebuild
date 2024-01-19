# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Execute scripts on IMAP mailbox changes (new/deleted/updated messages) using IDLE, golang version."

HOMEPAGE="https://gitlab.com/shackra/goimapnotify"

SRC_URI="
	https://gitlab.com/shackra/${PN}/-/archive/${PV}/${P}.tar.gz
	https://github.com/WingsZeng/goimapnotify-go-deps/releases/download/${PV}/${P}-deps.tar.xz
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="
	${DEPEND}
"
BDEPEND=""

src_compile() {
	ego build
}

src_install() {
	dobin goimapnotify
}

