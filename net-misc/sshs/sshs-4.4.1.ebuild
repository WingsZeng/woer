# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Auto-Generated by cargo-ebuild 0.5.4-r1

EAPI=8

CRATES="
	ahash@0.8.11
	aho-corasick@1.1.3
	allocator-api2@0.2.18
	anstream@0.6.14
	anstyle@1.0.7
	anstyle-parse@0.2.4
	anstyle-query@1.1.0
	anstyle-wincon@3.0.3
	anyhow@1.0.86
	autocfg@1.3.0
	bitflags@2.6.0
	block-buffer@0.10.4
	cassowary@0.3.0
	castaway@0.2.2
	cfg-if@1.0.0
	clap@4.5.8
	clap_builder@4.5.8
	clap_derive@4.5.8
	clap_lex@0.7.1
	colorchoice@1.0.1
	compact_str@0.7.1
	cpufeatures@0.2.12
	crossterm@0.27.0
	crossterm_winapi@0.9.1
	crypto-common@0.1.6
	digest@0.10.7
	dirs@5.0.1
	dirs-sys@0.4.1
	either@1.13.0
	fuzzy-matcher@0.3.7
	generic-array@0.14.7
	getrandom@0.2.15
	glob@0.3.1
	handlebars@5.1.2
	hashbrown@0.14.5
	heck@0.5.0
	is_terminal_polyfill@1.70.0
	itertools@0.12.1
	itoa@1.0.11
	libc@0.2.155
	libredox@0.1.3
	lock_api@0.4.12
	log@0.4.22
	lru@0.12.3
	memchr@2.7.4
	mio@0.8.11
	once_cell@1.19.0
	option-ext@0.2.0
	parking_lot@0.12.3
	parking_lot_core@0.9.10
	paste@1.0.15
	pest@2.7.10
	pest_derive@2.7.10
	pest_generator@2.7.10
	pest_meta@2.7.10
	proc-macro2@1.0.86
	quote@1.0.36
	ratatui@0.26.3
	redox_syscall@0.5.2
	redox_users@0.4.5
	regex@1.10.5
	regex-automata@0.4.7
	regex-syntax@0.8.4
	rustversion@1.0.17
	ryu@1.0.18
	scopeguard@1.2.0
	serde@1.0.203
	serde_derive@1.0.203
	serde_json@1.0.118
	sha2@0.10.8
	shellexpand@3.1.0
	shlex@1.3.0
	signal-hook@0.3.17
	signal-hook-mio@0.2.3
	signal-hook-registry@1.4.2
	smallvec@1.13.2
	stability@0.2.0
	static_assertions@1.1.0
	strsim@0.11.1
	strum@0.26.3
	strum_macros@0.26.4
	syn@2.0.68
	thiserror@1.0.61
	thiserror-impl@1.0.61
	thread_local@1.1.8
	tui-input@0.8.0
	typenum@1.17.0
	ucd-trie@0.1.6
	unicode-ident@1.0.12
	unicode-segmentation@1.11.0
	unicode-truncate@1.0.0
	unicode-width@0.1.13
	utf8parse@0.2.2
	version_check@0.9.4
	wasi@0.11.0+wasi-snapshot-preview1
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.48.5
	windows-targets@0.52.5
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.5
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.5
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.5
	windows_i686_gnullvm@0.52.5
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.5
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.5
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.5
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.5
	zerocopy@0.7.34
	zerocopy-derive@0.7.34
"

inherit cargo

DESCRIPTION="Terminal user interface for SSH"
HOMEPAGE="https://github.com/quantumsheep/sshs"
SRC_URI="
	${CARGO_CRATE_URIS}
	https://github.com/quantumsheep/sshs/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
"

LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 Boost-1.0 MIT MPL-2.0 Unicode-DFS-2016 Unlicense"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

# rust does not use *FLAGS from make.conf, silence portage warning
# update with proper path to binaries this crate installs, omit leading /
QA_FLAGS_IGNORED="usr/bin/${PN}"