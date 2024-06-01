# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ninja-utils meson

DESCRIPTION="a focus animation plugin for Hyprland inspired by Flashfocus"
HOMEPAGE="https://github.com/WingsZeng/hyprfocus/"
SRC_URI="https://github.com/WingsZeng/hyprfocus/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
HYPRLAND_PV=${PV%.*}

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+flash shrink X"

DEPEND="
	X? ( gui-wm/hyprland[X] )
	!X? ( gui-wm/hyprland[-X] )
"

RDEPEND="${DEPEND}"
BDEPEND="
	~gui-wm/hyprland-${HYPRLAND_PV}
	x11-libs/libdrm
	x11-libs/pixman
"

src_configure() {
	local emesonargs=(
		$(meson_feature X xwayland)
		$(meson_feature flash)
		$(meson_feature shrink)
	)
    meson_src_configure
}

src_compile() {
	eninja -C ${BUILD_DIR}
}
