# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Auto-Generated by cargo-ebuild 0.5.4-r1

EAPI=8

CRATES="
	aho-corasick@1.1.3
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	anstream@0.6.14
	anstyle@1.0.7
	anstyle-parse@0.2.4
	anstyle-query@1.1.0
	anstyle-wincon@3.0.3
	autocfg@1.3.0
	bumpalo@3.16.0
	cc@1.0.99
	cfg-if@1.0.0
	chrono@0.4.38
	clap@4.5.7
	clap_builder@4.5.7
	clap_lex@0.7.1
	colorchoice@1.0.1
	colored@2.1.0
	core-foundation-sys@0.8.6
	heck@0.5.0
	iana-time-zone@0.1.60
	iana-time-zone-haiku@0.1.2
	is_terminal_polyfill@1.70.0
	js-sys@0.3.69
	lazy_static@1.4.0
	libc@0.2.155
	log@0.4.21
	memchr@2.7.2
	num-traits@0.2.19
	once_cell@1.19.0
	proc-macro2@1.0.85
	quote@1.0.36
	regex@1.10.5
	regex-automata@0.4.7
	regex-syntax@0.8.4
	rustversion@1.0.17
	strsim@0.11.1
	strum@0.26.2
	strum_macros@0.26.4
	syn@2.0.66
	unicode-ident@1.0.12
	utf8parse@0.2.2
	wasm-bindgen@0.2.92
	wasm-bindgen-backend@0.2.92
	wasm-bindgen-macro@0.2.92
	wasm-bindgen-macro-support@0.2.92
	wasm-bindgen-shared@0.2.92
	windows-core@0.52.0
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
	${PN}@${PV}
"

inherit cargo

DESCRIPTION="A CLI tool to view Unix shell history statistics, with support for zsh, bash, fish, and atuin."
# Double check the homepage as the cargo_metadata crate
# does not provide this value so instead repository is used
HOMEPAGE="https://github.com/YiNNx/cmd-wrapped"
SRC_URI="${CARGO_CRATE_URIS}"

# License set may be more restrictive as OR is not respected
# use cargo-license for a more accurate license picture
LICENSE="Apache-2.0 MIT MPL-2.0 Unicode-DFS-2016 Unlicense"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

# rust does not use *FLAGS from make.conf, silence portage warning
# update with proper path to binaries this crate installs, omit leading /
QA_FLAGS_IGNORED="usr/bin/${PN}"