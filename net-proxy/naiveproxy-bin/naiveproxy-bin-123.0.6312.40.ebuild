# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI=8

MY_PV="v${PV}-1"

DESCRIPTION="Make a fortune quietly"
HOMEPAGE="https://github.com/klzgrad/naiveproxy"
SRC_URI="
	amd64? ( https://github.com/klzgrad/naiveproxy/releases/download/${MY_PV}/naiveproxy-${MY_PV}-linux-x64.tar.xz )
"

LICENSE="BSD-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="
	${DEPEND}
	acct-user/naive
	acct-group/naive
"
BDEPEND=""

S=${WORKDIR}/naiveproxy-${MY_PV}-linux-x64

src_install() {
	dobin naive
	insinto /etc/naive
	doins config.json
	newinitd "${FILESDIR}/naive.initd" naive
}

pkg_postinst() {
    einfo "Creating log file and setting permissions"

    touch /var/log/naive.log

    chown naive:naive /var/log/naive.log
    chmod 644 /var/log/naive.log
}
