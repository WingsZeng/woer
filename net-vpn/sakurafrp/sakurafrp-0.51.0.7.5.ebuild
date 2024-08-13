# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI=8

MAJOR=${PV%.*.*}
MINOR=${PV#"$MAJOR."}
MY_PV=${MAJOR}-sakura-${MINOR}

DESCRIPTION="SaKura Frp"
HOMEPAGE="https://www.natfrp.com/"
SRC_URI="
	amd64? ( https://nya.globalslb.net/natfrp/client/frpc/${MY_PV}/frpc_linux_amd64 -> ${P} )
"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"

src_unpack() {
	mkdir -p ${S}
	cp ${DISTDIR}/${P} ${S}/${P}
}

src_install() {
	newbin ${P} sakura-frpc
}
