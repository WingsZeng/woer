# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Auto-Generated by cargo-ebuild 0.5.4-r1

EAPI=8

CRATES="
	ab_glyph@0.2.21
	ab_glyph_rasterizer@0.1.8
	addr2line@0.21.0
	adler@1.0.2
	ahash@0.8.3
	aho-corasick@1.1.1
	allocator-api2@0.2.16
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	anstream@0.5.0
	anstyle@1.0.3
	anstyle-parse@0.2.1
	anstyle-query@1.0.0
	anstyle-wincon@2.1.0
	approx@0.5.1
	arrayvec@0.7.4
	ash@0.37.3+1.3.251
	autocfg@1.1.0
	backtrace@0.3.69
	base64@0.21.4
	bit-set@0.5.3
	bit-vec@0.6.3
	bitflags@1.3.2
	bitflags@2.4.0
	block@0.1.6
	bumpalo@3.14.0
	bytemuck@1.14.0
	bytemuck_derive@1.5.0
	byteorder@1.4.3
	bytes@1.5.0
	calloop@0.10.6
	cc@1.0.83
	cfg-if@1.0.0
	chrono@0.4.31
	clap@4.4.5
	clap_builder@4.4.5
	clap_derive@4.4.2
	clap_lex@0.5.1
	codespan-reporting@0.11.1
	color_quant@1.1.0
	colorchoice@1.0.0
	com-rs@0.2.1
	const-cstr@0.3.0
	core-foundation@0.9.3
	core-foundation-sys@0.8.4
	core-graphics-types@0.1.2
	crc32fast@1.3.2
	crossbeam-channel@0.5.8
	crossbeam-deque@0.8.3
	crossbeam-epoch@0.9.15
	crossbeam-utils@0.8.16
	d3d12@0.7.0
	derive_more@0.99.17
	dlib@0.5.2
	downcast-rs@1.2.0
	either@1.9.0
	env_logger@0.10.0
	equivalent@1.0.1
	errno@0.3.9
	fastrand@2.0.1
	fdeflate@0.3.0
	fixedbitset@0.4.2
	flate2@1.0.27
	fnv@1.0.7
	fontconfig@0.6.0
	foreign-types@0.5.0
	foreign-types-macros@0.2.3
	foreign-types-shared@0.3.1
	getrandom@0.2.10
	gimli@0.28.0
	glob@0.3.1
	glow@0.12.3
	glyph_brush@0.7.7
	glyph_brush_draw_cache@0.1.5
	glyph_brush_layout@0.2.3
	gpu-alloc@0.6.0
	gpu-alloc-types@0.3.0
	gpu-allocator@0.22.0
	gpu-descriptor@0.2.4
	gpu-descriptor-types@0.1.2
	hashbrown@0.12.3
	hashbrown@0.14.0
	hassle-rs@0.10.0
	heck@0.4.1
	hermit-abi@0.3.3
	hexf-parse@0.2.1
	home@0.5.9
	hyprland@0.4.0-alpha.2
	hyprland-macros@0.4.0-alpha.1
	iana-time-zone@0.1.57
	iana-time-zone-haiku@0.1.2
	image@0.24.7
	indexmap@1.9.3
	indexmap@2.0.0
	io-lifetimes@1.0.11
	is-terminal@0.4.9
	itoa@1.0.9
	jobserver@0.1.26
	jpeg-decoder@0.3.0
	js-sys@0.3.64
	khronos-egl@4.1.0
	lazy_static@1.4.0
	libc@0.2.155
	libloading@0.7.4
	libloading@0.8.0
	libwebp-sys@0.9.4
	linked-hash-map@0.5.6
	linux-raw-sys@0.4.14
	lock_api@0.4.10
	log@0.4.22
	malloc_buf@0.0.6
	memchr@2.6.3
	memmap2@0.5.10
	memmap2@0.7.1
	memoffset@0.6.5
	memoffset@0.7.1
	memoffset@0.9.0
	metal@0.26.0
	minimal-lexical@0.2.1
	miniz_oxide@0.7.1
	mio@0.8.8
	naga@0.13.0
	nix@0.25.1
	nix@0.26.4
	nom@7.1.3
	num-integer@0.1.45
	num-rational@0.4.1
	num-traits@0.2.19
	objc@0.2.7
	objc_exception@0.1.2
	object@0.32.1
	once_cell@1.19.0
	ordered-float@3.9.1
	os_pipe@1.2.0
	owned_ttf_parser@0.19.0
	parking_lot@0.12.1
	parking_lot_core@0.9.8
	paste@1.0.14
	petgraph@0.6.4
	pin-project-lite@0.2.13
	pkg-config@0.3.27
	png@0.17.10
	pollster@0.3.0
	ppv-lite86@0.2.17
	proc-macro2@1.0.67
	profiling@1.0.11
	quick-xml@0.28.2
	quick-xml@0.31.0
	quote@1.0.33
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	range-alloc@0.1.3
	raw-window-handle@0.5.2
	rayon@1.8.0
	rayon-core@1.12.0
	redox_syscall@0.3.5
	regex@1.10.5
	regex-automata@0.4.7
	regex-syntax@0.8.4
	renderdoc-sys@1.0.0
	ron@0.8.1
	rustc-demangle@0.1.23
	rustc-hash@1.1.0
	rustix@0.38.34
	rustversion@1.0.14
	ryu@1.0.15
	scoped-tls@1.0.1
	scopeguard@1.2.0
	serde@1.0.188
	serde_derive@1.0.188
	serde_json@1.0.107
	serde_repr@0.1.16
	simd-adler32@0.3.7
	slotmap@1.0.6
	smallvec@1.11.1
	smithay-client-toolkit@0.17.0
	socket2@0.5.4
	spirv@0.2.0+1.5.4
	static_assertions@1.1.0
	strsim@0.10.0
	strum@0.25.0
	strum_macros@0.25.2
	syn@1.0.109
	syn@2.0.37
	tempfile@3.10.1
	termcolor@1.3.0
	thiserror@1.0.48
	thiserror-impl@1.0.48
	tokio@1.32.0
	tree_magic_mini@3.1.5
	ttf-parser@0.19.2
	twox-hash@1.6.3
	unicode-ident@1.0.12
	unicode-width@0.1.11
	unicode-xid@0.2.4
	utf8parse@0.2.1
	vec_map@0.8.2
	version_check@0.9.4
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen@0.2.87
	wasm-bindgen-backend@0.2.87
	wasm-bindgen-futures@0.4.37
	wasm-bindgen-macro@0.2.87
	wasm-bindgen-macro-support@0.2.87
	wasm-bindgen-shared@0.2.87
	wayland-backend@0.1.2
	wayland-backend@0.3.4
	wayland-client@0.30.2
	wayland-client@0.31.3
	wayland-cursor@0.30.0
	wayland-protocols@0.30.1
	wayland-protocols@0.32.1
	wayland-protocols-wlr@0.1.0
	wayland-protocols-wlr@0.3.1
	wayland-scanner@0.30.1
	wayland-scanner@0.31.2
	wayland-sys@0.30.1
	wayland-sys@0.31.2
	web-sys@0.3.64
	webp@0.2.6
	wgpu@0.17.0
	wgpu-core@0.17.0
	wgpu-hal@0.17.0
	wgpu-types@0.17.0
	wgpu_text@0.8.3
	widestring@1.0.2
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.6
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows@0.44.0
	windows@0.48.0
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.42.2
	windows-targets@0.48.5
	windows-targets@0.52.5
	windows_aarch64_gnullvm@0.42.2
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.5
	windows_aarch64_msvc@0.42.2
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.5
	windows_i686_gnu@0.42.2
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.5
	windows_i686_gnullvm@0.52.5
	windows_i686_msvc@0.42.2
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.5
	windows_x86_64_gnu@0.42.2
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.5
	windows_x86_64_gnullvm@0.42.2
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.5
	windows_x86_64_msvc@0.42.2
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.5
	wl-clipboard-rs@0.9.0
	xcursor@0.3.4
	xi-unicode@0.3.0
	xkbcommon@0.5.1
	yeslogic-fontconfig-sys@4.0.1
"

inherit cargo

DESCRIPTION="A simple wayland native screenshot tool inspired by Flameshot."
# Double check the homepage as the cargo_metadata crate
# does not provide this value so instead repository is used
HOMEPAGE="https://github.com/Kirottu/watershot"
SRC_URI="
	${CARGO_CRATE_URIS}
	https://github.com/Kirottu/watershot/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
"

# License set may be more restrictive as OR is not respected
# use cargo-license for a more accurate license picture
LICENSE="0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions Boost-1.0 CC0-1.0 GPL-3+ ISC MIT Unicode-DFS-2016 Unlicense ZLIB"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	media-libs/fontconfig
	x11-libs/libxkbcommon[wayland]
	gui-apps/grim
	media-libs/vulkan-loader
	>=gui-wm/hyprland-0.40.0
"
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=(
	"${FILESDIR}/${PN}-0.2.2-update-for-hyprland-0.40.0.patch"
	"${FILESDIR}/${PN}-0.2.2-update-hyprland-lock.patch"
	"${FILESDIR}/${PN}-0.2.2-update-wl-clipboard-rs-to-0.9.0.patch"
)

# rust does not use *FLAGS from make.conf, silence portage warning
# update with proper path to binaries this crate installs, omit leading /
QA_FLAGS_IGNORED="usr/bin/${PN}"

src_compile() {
	export CARGO_PROFILE_RELEASE_LTO=true
	cargo_src_compile
}