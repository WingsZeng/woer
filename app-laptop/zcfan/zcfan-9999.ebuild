# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 systemd
EGIT_REPO_URI="https://github.com/cdown/zcfan.git"
DESCRIPTION="A zero-configuration fan daemon for ThinkPads."
HOMEPAGE="https://github.com/cdown/zcfan"

LICENSE="MIT"
SLOT="0"
IUSE="doc systemd"

RDEPEND="
	!app-laptop/thinkfan
"

src_unpack() {
	git-r3_src_unpack
}

src_compile() {
	emake
}

src_install() {
	dobin zcfan
	use doc && doman zcfan.1
	insinto /etc/modprobe.d
	doins "${FILESDIR}"/thinkpad.conf
	if use systemd; then
		systemd_dounit zcfan.service
	else
		newinitd "${FILESDIR}"/zcfan.initd zcfan
	fi
}
