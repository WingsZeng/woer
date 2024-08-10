# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ninja-utils meson

DESCRIPTION="A plugin for the Hyprland compositor, implementing virtual-desktop functionality."
HOMEPAGE="https://github.com/levnikmyskin/hyprland-virtual-desktops/"
SRC_URI="https://github.com/levnikmyskin/hyprland-virtual-desktops/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X"

DEPEND="
	X? ( gui-wm/hyprland[X] )
	!X? ( gui-wm/hyprland[-X] )
	>=gui-wm/hyprland-0.41.1
	x11-libs/libdrm
	x11-libs/pixman
"

RDEPEND="${DEPEND}"
BDEPEND="
	virtual/pkgconfig
"

PATCHES="${FILESDIR}/${PN}-2.2.3-use-hyprutils.patch"

src_prepare() {
	# for meson
	cp ${FILESDIR}/meson.build ${S}/meson.build || die
	cp ${FILESDIR}/meson_options.txt ${S}/meson_options.txt || die
	default
}

src_configure() {
	local emesonargs=(
		$(meson_feature X xwayland)
	)
    meson_src_configure
}

src_compile() {
	eninja -C ${BUILD_DIR}
}

