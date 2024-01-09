# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ninja-utils meson

DESCRIPTION="hyprland overview mode plugin,a new tile window workflow"
HOMEPAGE="https://github.com/DreamMaoMao/hycov"
SRC_URI="https://github.com/DreamMaoMao/hycov/archive/refs/tags/${PV}.tar.gz"
HYPRLAND_PV=${PV%.*}

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X"

DEPEND="
	X? ( gui-wm/hyprland[X] )
	!X? ( gui-wm/hyprland[-X] )
"

RDEPEND="${DEPEND}"
BDEPEND="
	~gui-wm/hyprland-${HYPRLAND_PV}
	x11-libs/libdrm
	x11-libs/pixman
	x11-libs/pango
"

PATCHES=( "${FILESDIR}"/add-xwayland-option.patch )

src_configure() {
	local emesonargs=(
		$(meson_feature X xwayland)
	)
    meson_src_configure
}

src_compile() {
	eninja -C ${BUILD_DIR}
}
