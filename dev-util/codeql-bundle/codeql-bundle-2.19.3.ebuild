# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="the libraries and queries that power security researchers around the world, as well as code scanning in GitHub Advanced Security"
HOMEPAGE="https://codeql.github.com/"
SRC_URI="
	amd64? ( https://github.com/github/codeql-action/releases/download/${PN}-v${PV}/${PN}-linux64.tar.gz -> ${P}.tar.gz )
"

LICENSE="CodeQl"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip"

RDEPEND=""
BDEPEND=""

S="${WORKDIR}/codeql"

src_install() {
    local install_dir="/opt/codeql"
    dodir "${install_dir}"
    cp -r * "${D}${install_dir}"
    dosym "${install_dir}/codeql" /usr/bin/codeql
}

