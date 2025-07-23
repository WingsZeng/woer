# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=(python3_{11..13})
inherit desktop xdg-utils python-single-r1

DESCRIPTION="IDA Interactive Disasssembler"
HOMEPAGE="https://hex-rays.com/ida-pro/"
MAJOR_MINOR="$(ver_cut 1)$(ver_cut 2)"
SRC_URI="
        https://gentoo.wingszeng.top/${PN}_${MAJOR_MINOR}_x64linux.run -> ${P}.run
        https://gentoo.wingszeng.top/ida-signatures-bundles-${PV}.zip
"

LICENSE="EULA"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+crack"
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
        cp "${DISTDIR}/${P}.run" . || die
        bitrock-unpacker "${P}.run" "${WORKDIR}" || die
        rm "${P}.run" || die
        unpack "${DISTDIR}/ida-signatures-bundles-${PV}.zip" || die
}

src_install() {
        newicon ./programfiles/appico.png "${PN}.png"
        rm ./programfiles/appico.png || die
        insinto "/opt/${PN}"
        if use crack; then
                elog "Applying crack patch..."
                cp ./programfiles/libida.so .
                cp ./programfiles/libida32.so .
                python "${FILESDIR}/patch.py"
                mv ./libida.so.patched ./programfiles/libida.so
                mv ./libida32.so.patched ./programfiles/libida32.so
                doins idapro.hexlic
        fi
        doins -r ./programfiles/*
        doins -r ./programfiles_custom/*
        doins -r ./noarchfiles/*

        insinto "/opt/${PN}/sig"
        doins -r "${WORKDIR}"/golang
        doins -r "${WORKDIR}"/rust
        doins -r "${WORKDIR}"/linux
        doins -r "${WORKDIR}"/windows

        fperms 755 "/opt/${PN}/ida"
        fperms 755 "/opt/${PN}/idat"
        fperms 755 "/opt/${PN}/idapyswitch"
        dosym "/opt/${PN}/ida" "/usr/bin/ida"
        dosym "/opt/${PN}/idat" "/usr/bin/idat"
        dosym "/opt/${PN}/idapyswitch" "/usr/bin/idapyswitch"
        make_desktop_entry ida "IDA Pro ${PV}" "${PN}"
}

pkg_postrm() {
        xdg_desktop_database_update
        xdg_icon_cache_update
}
