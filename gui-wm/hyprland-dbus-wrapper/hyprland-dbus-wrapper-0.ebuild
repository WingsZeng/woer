# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="a focus animation plugin for Hyprland inspired by Flashfocus"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	gui-wm/hyprland
	sys-apps/dbus
"

RDEPEND="${DEPEND}"
BDEPEND=""

S=${WORKDIR}

src_install() {
    insinto /usr/share/wayland-sessions
    doins "${FILESDIR}/hyprland-dbus.desktop"
}

