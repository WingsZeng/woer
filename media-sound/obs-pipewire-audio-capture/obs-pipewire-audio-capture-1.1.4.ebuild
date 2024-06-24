# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Audio device and application capture for OBS Studio using PipeWire"
HOMEPAGE="https://github.com/dimtpap/obs-pipewire-audio-capture"
SRC_URI="
	https://github.com/dimtpap/obs-pipewire-audio-capture/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
"
KEYWORDS="~amd64"

LICENSE="GPL-2.0"

SLOT="0"

IUSE=""
BDEPEND=""
DEPEND="
	>=media-video/obs-studio-28.0[pipewire]
	>=media-video/pipewire-0.3.62
"
RDEPEND="
	${DEPENDS}
"

PATCHES="
	${FILESDIR}/${PN}-1.1.4-Use-GNUInstallDirs.patch
"

src_compile(){
	cmake_src_compile
}

