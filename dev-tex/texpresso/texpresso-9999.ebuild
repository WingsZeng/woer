# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 cargo
EGIT_REPO_URI="https://github.com/let-def/texpresso.git"
DESCRIPTION="TeXpresso: live rendering and error reporting for LaTeX"
HOMEPAGE="https://github.com/let-def/texpresso"

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	app-text/mupdf
	media-libs/libsdl2
"
DEPEND="${RDEPEND}"
BDEPEND="media-libs/harfbuzz"

src_unpack() {
	git-r3_src_unpack
	local temp=${S}
	S=${S}/tectonic
	cargo_live_src_unpack
	S=${temp}
}

src_compile() {
	emake ${PN}
	pushd tectonic || die
		cargo_src_compile --features external-harfbuzz
	popd || die
}

src_install() {
	dobin build/texpresso
	pushd tectonic || die
		cargo_src_install --features external-harfbuzz
	popd || die
}
