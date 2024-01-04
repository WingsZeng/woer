# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 cargo shell-completion

DESCRIPTION="unofficial bitwarden cli"
HOMEPAGE="https://git.tozt.net/rbw"
EGIT_REPO_URI="https://git.tozt.net/rbw"

LICENSE="MIT"
SLOT="0"
IUSE="uri"

DEPEND="
	app-crypt/pinentry
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_prepare() {
	if use uri; then
		PATCHES+=( "${FILESDIR}/add-URI-matching-for-rbw-get.patch" )
	fi
	default
}

src_compile() {
	export CARGO_PROFILE_RELEASE_LTO=true
	cargo_src_compile

	# generate shell auto-completions
	cargo run --frozen --release --bin rbw -- \
		gen-completions bash > rbw.bash
	cargo run --frozen --release --bin rbw -- \
		gen-completions fish > rbw.fish
	cargo run --frozen --release --bin rbw -- \
		gen-completions zsh > _rbw
}

src_install() {
	cargo_src_install

	dobashcomp rbw.bash
	dofishcomp rbw.fish
	dozshcomp _rbw
}
