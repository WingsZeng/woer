# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="xdg-desktop-portal backend for wlroots"
HOMEPAGE="https://github.com/hunkyburrito/xdg-desktop-portal-termfilechooser"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/hunkyburrito/${PN}.git"
	inherit git-r3
else
	SRC_URI="https://github.com/hunkyburrito/${PN}/releases/download/v${PV}/${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="elogind systemd doc +wrapper fzf lf nnn ranger vifm +yazi"
REQUIRED_USE="
	?? ( elogind systemd )
	wrapper? ( ?? ( fzf lf nnn ranger vifm yazi ) )
"

DEPEND="
	dev-libs/inih
	sys-libs/libcap
	|| (
		systemd? ( >=sys-apps/systemd-237 )
		elogind? ( >=sys-auth/elogind-237 )
		sys-libs/basu
	)
"
# mesa is needed for gbm dep (which it hards sets to 'on')
RDEPEND="
	${DEPEND}
	sys-apps/xdg-desktop-portal
	fzf? ( app-shells/fzf )
	lf? ( app-misc/lf )
	nnn? ( app-misc/nnn )
	ranger? ( app-misc/ranger )
	vifm? ( app-misc/vifm )
	yazi? ( app-misc/yazi )
"
BDEPEND="
	virtual/pkgconfig
"

src_prepare() {
	default

	if use wrapper; then
		local wrapper_cmd=""
		if use fzf; then
			wrapper_cmd="fzf"
		elif use lf; then
			wrapper_cmd="lf"
		elif use nnn; then
			wrapper_cmd="nnn"
		elif use ranger; then
			wrapper_cmd="ranger"
		elif use vifm; then
			wrapper_cmd="vifm"
		elif use yazi; then
			wrapper_cmd="yazi"
		fi
		sed -i 's/cmd=yazi-wrapper.sh/cmd='"${wrapper_cmd}"'-wrapper.sh/' contrib/config
	fi
}

src_configure() {
	local emesonargs=()

	if use systemd; then
		emesonargs+=(-Dsd-bus-provider=libsystemd)
	elif use elogind; then
		emesonargs+=(-Dsd-bus-provider=libelogind)
	else
		emesonargs+=(-Dsd-bus-provider=basu)
	fi

	emesonargs+=(-Dman-pages=$(usex doc enabled disabled))
	emesonargs+=(-Dsystemd=$(usex systemd enabled disabled))

	meson_src_configure
}

src_install() {
	exeinto /usr/libexec
	doexe ${WORKDIR}/${P}-build/xdg-desktop-portal-termfilechooser
	insinto /usr/share/dbus-1/services
	doins ${WORKDIR}/${P}-build/org.freedesktop.impl.portal.desktop.termfilechooser.service
	insinto /usr/share/xdg-desktop-portal/portals
	doins termfilechooser.portal

	if use systemd; then
		insinto /usr/share/xdg-desktop-portal-termfilechooser/systemd
		doins /contrib/systemd/xdg-desktop-portal-termfilechooser.service.in
	fi

	if use doc; then
		doman xdg-desktop-portal-termfilechooser.5
		dodoc README.md
	fi

	insinto /usr/share/xdg-desktop-portal-termfilechooser
	doins contrib/config
	exeinto /usr/share/xdg-desktop-portal-termfilechooser
	use fzf && doexe contrib/fzf-wrapper.sh
	use lf && doexe contrib/lf-wrapper.sh
	use nnn && doexe contrib/nnn-wrapper.sh
	use ranger && doexe contrib/ranger-wrapper.sh
	use vifm && doexe contrib/vifm-wrapper.sh
	use yazi && doexe contrib/yazi-wrapper.sh
}
