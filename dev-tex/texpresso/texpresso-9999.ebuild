# Copyright 2024-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 toolchain-funcs

DESCRIPTION="TeXpresso: live rendering and error reporting for LaTeX"
HOMEPAGE="https://github.com/let-def/texpresso"
EGIT_REPO_URI="https://github.com/let-def/texpresso.git"

LICENSE="MIT"
SLOT="0"

DEPEND="
	app-text/mupdf:=
	dev-libs/icu:=
	media-gfx/graphite2
	media-libs/fontconfig
	media-libs/freetype:2
	media-libs/harfbuzz:=
	media-libs/libpng:=
	media-libs/libsdl2
	virtual/zlib:=
"
RDEPEND="
	${DEPEND}
	virtual/latex-base
"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	default
	sed -i -e 's/^\tar cr /\t$(AR) cr /' src/common/Makefile src/dvi/Makefile || die
	sed -i -e 's/$(shell pkg-config /$(shell $(PKG_CONFIG) /' src/dvi/Makefile || die
}

src_configure() {
	touch Makefile.config || die
}

src_compile() {
	local pc=$(tc-getPKG_CONFIG)

	emake texpresso \
		CC="$(tc-getCC) \$(CPPFLAGS) \$(CFLAGS)" \
		LDCC="$(tc-getCXX) \$(CFLAGS) \$(LDFLAGS)" \
		AR="$(tc-getAR)" \
		PKG_CONFIG="${pc}" \
		CPPFLAGS="${CPPFLAGS}" \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		LIBS="-lmupdf -lm $(${pc} --libs freetype2 sdl2)"

	emake texpresso-xetex \
		_CC="$(tc-getCC)" \
		_CXX="$(tc-getCXX)" \
		_LD="$(tc-getCXX)" \
		_CFLAGS="${CPPFLAGS} ${CFLAGS}" \
		_CXXFLAGS="${CXXFLAGS}" \
		_LDFLAGS="${LDFLAGS}" \
		PKG_CONFIG="${pc}"
}

src_install() {
	dobin build/texpresso build/texpresso-xetex
	dodoc README.md INSTALL.md CHANGELOG.md EDITOR-PROTOCOL.md
}
