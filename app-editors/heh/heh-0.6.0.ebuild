# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Auto-Generated by cargo-ebuild 0.5.4-r1

EAPI=8

CRATES="
	ahash@0.8.11
	allocator-api2@0.2.16
	anstream@0.6.13
	anstyle@1.0.6
	anstyle-parse@0.2.3
	anstyle-query@1.0.2
	anstyle-wincon@3.0.2
	arboard@3.4.0
	autocfg@1.2.0
	bitflags@1.3.2
	bitflags@2.5.0
	block2@0.5.0
	cassowary@0.3.0
	castaway@0.2.2
	cfg-if@1.0.0
	clap@4.5.11
	clap_builder@4.5.11
	clap_derive@4.5.11
	clap_lex@0.7.0
	clipboard-win@5.3.1
	colorchoice@1.0.0
	compact_str@0.7.1
	crossbeam@0.8.4
	crossbeam-channel@0.5.12
	crossbeam-deque@0.8.5
	crossbeam-epoch@0.9.18
	crossbeam-queue@0.3.11
	crossbeam-utils@0.8.19
	crossterm@0.27.0
	crossterm_winapi@0.9.1
	either@1.10.0
	errno@0.3.8
	error-code@3.2.0
	gethostname@0.4.3
	hashbrown@0.14.3
	heck@0.5.0
	hex@0.4.3
	itertools@0.12.1
	itertools@0.13.0
	itoa@1.0.11
	libc@0.2.153
	linux-raw-sys@0.4.13
	lock_api@0.4.11
	log@0.4.21
	lru@0.12.3
	memmap2@0.9.4
	mio@0.8.11
	objc-sys@0.3.3
	objc2@0.5.1
	objc2-app-kit@0.2.0
	objc2-core-data@0.2.0
	objc2-encode@4.0.1
	objc2-foundation@0.2.0
	once_cell@1.19.0
	parking_lot@0.12.1
	parking_lot_core@0.9.9
	paste@1.0.14
	proc-macro2@1.0.79
	quote@1.0.35
	ratatui@0.27.0
	redox_syscall@0.4.1
	rustix@0.38.32
	rustversion@1.0.14
	ryu@1.0.17
	scopeguard@1.2.0
	signal-hook@0.3.17
	signal-hook-mio@0.2.3
	signal-hook-registry@1.4.1
	smallvec@1.13.2
	stability@0.2.0
	static_assertions@1.1.0
	strsim@0.11.0
	strum@0.26.2
	strum_macros@0.26.4
	syn@2.0.57
	unicode-ident@1.0.12
	unicode-segmentation@1.11.0
	unicode-truncate@1.0.0
	unicode-width@0.1.13
	utf8parse@0.2.1
	version_check@0.9.4
	wasi@0.11.0+wasi-snapshot-preview1
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.48.5
	windows-targets@0.52.4
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.4
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.4
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.4
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.4
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.4
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.4
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.4
	x11rb@0.13.0
	x11rb-protocol@0.13.0
	zerocopy@0.7.32
	zerocopy-derive@0.7.32
"

inherit cargo

DESCRIPTION="A cross-platform terminal UI used for modifying file data in hex or ASCII."
# Double check the homepage as the cargo_metadata crate
# does not provide this value so instead repository is used
HOMEPAGE="https://github.com/ndd7xv/heh"
SRC_URI="
	${CARGO_CRATE_URIS}
	https://github.com/ndd7xv/heh/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
"

# License set may be more restrictive as OR is not respected
# use cargo-license for a more accurate license picture
LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 Boost-1.0 MIT Unicode-DFS-2016"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

# rust does not use *FLAGS from make.conf, silence portage warning
# update with proper path to binaries this crate installs, omit leading /
QA_FLAGS_IGNORED="usr/bin/${PN}"