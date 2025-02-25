# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg-utils

DESCRIPTION="IDA Interactive Disasssembler"
HOMEPAGE="https://hex-rays.com/ida-pro/"
MAJOR_MINOR_PATCH="$(ver_cut 1)$(ver_cut 2)sp1"
SRC_URI="https://gentoo.wingszeng.top/${PN}_${MAJOR_MINOR_PATCH}_x64linux.run -> ${P}.run"

LICENSE="EULA"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip splitdebug"

RDEPEND="
	app-crypt/mit-krb5
	dev-libs/glib
	media-libs/fontconfig
	media-libs/freetype
	media-libs/libglvnd
	sys-apps/dbus
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libXau
	x11-libs/libXext
	x11-libs/libdrm
	x11-libs/libxkbcommon[X]
	x11-libs/pango
	x11-libs/xcb-util-image
	x11-libs/xcb-util-keysyms
	x11-libs/xcb-util-renderutil
"
BDEPEND="app-arch/bitrock-unpacker"

S="${WORKDIR}/ida"

src_unpack() {
	cp "${DISTDIR}/${A}" . || die
	bitrock-unpacker "${A}" "${WORKDIR}" || die
	rm "${A}" || die
}

src_install() {
	newicon ./programfiles/appico.png "${PN}.png"
	rm ./programfiles/appico.png || die
	insinto "/opt/${PN}"
	doins -r ./programfiles/*
	doins -r ./programfiles_custom/*
	doins -r ./noarchfiles/*
	doins "${FILESDIR}/IDA Pro 9.0 Keygen & Patch.py"
	fperms 755 "/opt/${PN}/ida"
	fperms 755 "/opt/${PN}/idat"
	fperms 755 "/opt/${PN}/idapyswitch"
	dosym "/opt/${PN}/ida" "/usr/bin/ida"
	dosym "/opt/${PN}/idat" "/usr/bin/idat"
	dosym "/opt/${PN}/idapyswitch" "/usr/bin/idapyswitch"
	make_desktop_entry ida "IDA Pro ${PV}" "${PN}"
}

pkg_postinst() {
	elog "Run the script 'IDA Pro 9.0 Keygen & Patch.py' in /opt/${PN} to generate"
	elog "a key and apply the patch to the IDA Pro installation."
	elog "Run 'idapyswitch' to select the Python version before starting IDA Pro."
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
