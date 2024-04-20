# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A eselect tool for pwntools-gdb symlink, simplifying debugger changes in pwntools."
HOMEPAGE="https://wiki.gentoo.org/wiki/Project:Java"

if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/WingsZeng/${PN}.git"
else
	SRC_URI="https://github.com/WingsZeng/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 x86"
fi
LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND="app-admin/eselect"

src_install() {
	insinto /usr/share/eselect/modules
	doins pwntools-gdb.eselect
}
