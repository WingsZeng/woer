# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 qmake-utils desktop xdg
EGIT_REPO_URI="https://github.com/ahrm/sioyek.git"
DESCRIPTION="Sioyek is a PDF viewer with a focus on textbooks and research papers"
HOMEPAGE="https://github.com/ahrm/sioyek"

LICENSE="GPL-3"
SLOT="0"
IUSE="qt6"
KEYWORDS="~amd64"

RDEPEND="
	media-libs/harfbuzz
	qt6? (
		dev-qt/qtbase[gui,widgets,network]
	)
	!qt6? (
		dev-qt/qtcore
		dev-qt/qtgui
		dev-qt/qtwidgets
		dev-qt/qtnetwork
	)
"

DEPEND="
	${RDEPEND}
"

BDEPEND="
	qt6? (
		dev-qt/qtbase[opengl]
		dev-qt/qt3d
	)
	!qt6? (
		dev-qt/qtopengl
		=dev-qt/qt3d-5.15.11
	)
"

PATCHES=(
	"${FILESDIR}"/0001-Observe-the-XDG-Base-Directory-Specification.patch
)

src_compile() {
	# Make Mupdf specific for build
	pushd mupdf || die
	emake USE_SYSTEM_HARFBUZZ=yes
	popd || die

	if use qt6; then
		eqmake6 "CONFIG+=linux_app_image" pdf_viewer_build_config.pro
	else
		eqmake5 "CONFIG+=linux_app_image" pdf_viewer_build_config.pro
	fi
	emake
}
src_install() {
	# intall bin, default config files and shaders
	insinto /opt/sioyek
	doins sioyek tutorial.pdf pdf_viewer/keys.config pdf_viewer/prefs.config
	fperms +x /opt/sioyek/sioyek
	insinto /opt/sioyek/shaders
	doins pdf_viewer/shaders/*

	# symlink to /usr/bin
	dosym /opt/sioyek/sioyek /usr/bin/sioyek

	domenu "${FILESDIR}/sioyek.desktop"
	doicon resources/sioyek-icon-linux.png
	doman resources/sioyek.1
}

pkg_postinst() {
	xdg_desktop_database_update
}
