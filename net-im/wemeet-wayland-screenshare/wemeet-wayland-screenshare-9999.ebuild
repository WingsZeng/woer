# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Hook library that enables screenshare with Tencent Wemeet on Linux Wayland, without the need of using virtual cameras."
HOMEPAGE="https://github.com/xuwd1/wemeet-wayland-screenshare"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/xuwd1/${PN}.git"
	inherit git-r3
else
	SRC_URI="https://github.com/xuwd1/${PN}/releases/download/v${PV}/${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND="
	>=dev-libs/libportal-0.9.0
"
RDEPEND="
	${DEPEND}
	sys-apps/xdg-desktop-portal
	sys-apps/dbus
"
BDEPEND="
	media-libs/opencv
"

src_install() {
	exeinto /opt/wemeet/lib/
	doexe "$BUILD_DIR"/libhook.so
}
