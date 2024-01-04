# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="qutebrowser userscript for Bitwarden integration with rbw"
HOMEPAGE="https://github.com/WingsZeng/qute-rbw/tree/master"
SRC_URI="https://github.com/WingsZeng/qute-rbw/archive/refs/tags/v${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	www-client/qutebrowser
	app-admin/rbw[uri]
	dev-python/tldextract
"
RDEPEND="
	${DEPEND}
"
BDEPEND=""

src_install() {
	exeinto /usr/share/qutebrowser/userscripts
	doexe qute-rbw
}
