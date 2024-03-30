# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 qmake-utils desktop xdg
EGIT_REPO_URI="https://github.com/ahrm/sioyek.git"
DESCRIPTION="Sioyek is a PDF viewer with a focus on textbooks and research papers"
HOMEPAGE="https://github.com/ahrm/sioyek"

LICENSE="GPL-3"
SLOT="0"
IUSE="qt6 development"
KEYWORDS="~amd64"

RDEPEND="
	media-libs/harfbuzz
	dev-libs/gumbo
	qt6? (
		dev-qt/qtbase[gui,widgets,network,opengl]
		development? (
			dev-qt/qtspeech
		)
	)
	!qt6? (
		dev-qt/qtcore
		dev-qt/qtopengl
		dev-qt/qtgui
		dev-qt/qtwidgets
		dev-qt/qtnetwork
		dev-qt/qtdbus
		development? (
			dev-qt/qtspeech:5
		)
	)
"

DEPEND="
	${RDEPEND}
"

BDEPEND="
	dev-lang/mujs
	virtual/glu
	qt6? (
		dev-qt/qt3d
	)
	!qt6? (
		dev-qt/qt3d:5
	)
"

PATCHES+=( "${FILESDIR}/0001-use-submodule-mupdf-to-build-on-linux.patch" )

src_unpack() {
	if use development; then
		EGIT_BRANCH=development
	fi
	git-r3_src_unpack
}

src_prepare() {
    default
    if ! use development; then
    	PATCHES+=( "${FILESDIR}"/0001-Observe-the-XDG-Base-Directory-Specification.patch )
    fi
}

src_compile() {
	# Make Mupdf specific for build
	pushd mupdf || die
	emake USE_SYSTEM_HARFBUZZ=yes
	popd || die

	if use qt6; then
		eqmake6 pdf_viewer_build_config.pro
	else
		eqmake5 pdf_viewer_build_config.pro
	fi
	emake
}

src_install() {
	dobin sioyek
	domenu resources/sioyek.desktop
	doicon resources/sioyek-icon-linux.png
	insinto /usr/share/sioyek
	doins tutorial.pdf
	insinto /usr/share/sioyek/shaders
	doins pdf_viewer/shaders/*
	insinto /etc/sioyek
	doins pdf_viewer/keys.config pdf_viewer/prefs.config
	doman resources/sioyek.1
}

pkg_postinst() {
	xdg_desktop_database_update
}
