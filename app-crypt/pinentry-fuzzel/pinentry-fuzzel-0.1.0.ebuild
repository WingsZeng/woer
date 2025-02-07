# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Pinentry based on fuzzel"
HOMEPAGE="https://github.com/WingsZeng/pinentry-fuzzel"
SRC_URI="https://github.com/WingsZeng/pinentry-fuzzel/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	app-crypt/gnupg
"
RDEPEND="
	gui-apps/fuzzel
	${DEPEND}
"
BDEPEND=""

src_install() {
	exeinto /usr/bin
	doexe pinentry-fuzzel
}
