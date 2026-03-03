# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Open source, compact, and material designed cursor set"
HOMEPAGE="https://github.com/LOSEARDES77/Bibata-Cursor-hyprcursor"
RELEASE_URI="https://github.com/LOSEARDES77/Bibata-Cursor-hyprcursor/releases/download/${PV}/hypr_Bibata-"
SRC_URI="
	modern-style? ( color-amber? ( ${RELEASE_URI}Modern-Amber.tar.gz -> ${P}-Modern-Amber.tar.gz ) )
	modern-style? ( color-black? ( ${RELEASE_URI}Modern-Classic.tar.gz -> ${P}-Modern-Classic.tar.gz ) )
	modern-style? ( color-white? ( ${RELEASE_URI}Modern-Ice.tar.gz -> ${P}-Modern-Ice.tar.gz ) )
	original-style? ( color-amber? ( ${RELEASE_URI}Original-Amber.tar.gz -> ${P}-Original-Amber.tar.gz ) )
	original-style? ( color-black? ( ${RELEASE_URI}Original-Classic.tar.gz -> ${P}-Original-Classic.tar.gz ) )
	original-style? ( color-white? ( ${RELEASE_URI}Original-Ice.tar.gz -> ${P}-Original-Ice.tar.gz ) )
"

S="${WORKDIR}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+modern-style original-style color-amber +color-black color-white"
REQUIRED_USE="
	|| ( modern-style original-style )
	|| ( color-amber color-black color-white )

"

src_install() {
	insinto /usr/share/icons/Bibata-Cursor
	doins -r .
}
