# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Bubblewrap wrapper for dev-util/claude-code"
HOMEPAGE=""
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="
	dev-util/claude-code
	sys-apps/bubblewrap
"
BDEPEND=""

S=$WORKDIR

src_install() {
	dobin "${FILESDIR}/claude"
}
