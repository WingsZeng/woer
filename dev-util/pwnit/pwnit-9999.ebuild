# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 cargo

DESCRIPTION="automate starting binary exploit challenges"
HOMEPAGE="https://github.com/WingsZeng/pwnit"
EGIT_REPO_URI="https://github.com/WingsZeng/pwnit.git"
EGIT_BRANCH="dev"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

DEPEND="
	dev-util/patchelf
"
RDEPEND="${DEPEND}"
BDEPEND=""

# rust does not use *FLAGS from make.conf, silence portage warning
# update with proper path to binaries this crate installs, omit leading /
QA_FLAGS_IGNORED="usr/bin/${PN}"

src_unpack() {
	git-r3_src_unpack
    cargo_live_src_unpack
}

src_compile() {
	# project set strip=true in [profile.release]
	# portage complains: QA Notice: Pre-stripped files found
	# let portage do the strip
	export CARGO_PROFILE_RELEASE_STRIP=false
	export CARGO_PROFILE_RELEASE_LTO=true
	cargo_src_compile
}
