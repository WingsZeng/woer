# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
CARGO_OPTIONAL=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

CRATES="
	addr2line@0.24.2
	adler2@2.0.0
	ahash@0.8.12
	anyhow@1.0.98
	arbitrary@1.4.1
	autocfg@1.4.0
	base64@0.21.7
	bitflags@1.3.2
	bitflags@2.9.1
	bstr@1.12.0
	bumpalo@3.17.0
	bytemuck@1.23.0
	cfg-if@1.0.0
	cpp_demangle@0.4.4
	cranelift-bforest@0.113.1
	cranelift-bitset@0.113.1
	cranelift-codegen-meta@0.113.1
	cranelift-codegen-shared@0.113.1
	cranelift-codegen@0.113.1
	cranelift-control@0.113.1
	cranelift-entity@0.113.1
	cranelift-frontend@0.113.1
	cranelift-isle@0.113.1
	cranelift-jit@0.113.1
	cranelift-module@0.113.1
	cranelift-native@0.113.1
	cranelift@0.113.1
	crc32fast@1.4.2
	crunchy@0.2.3
	equivalent@1.0.2
	errno@0.3.12
	fallible-iterator@0.3.0
	flate2@1.1.1
	foldhash@0.1.5
	getrandom@0.3.3
	gimli@0.31.1
	half@2.6.0
	hashbrown@0.14.5
	hashbrown@0.15.3
	heck@0.5.0
	ihex@3.0.0
	indexmap@2.9.0
	indoc@2.0.6
	libc@0.2.172
	linux-raw-sys@0.4.15
	log@0.4.27
	mach2@0.4.2
	memchr@2.7.4
	memmap2@0.9.5
	memoffset@0.9.1
	miniz_oxide@0.8.8
	object@0.36.7
	once_cell@1.21.3
	pin-project-lite@0.2.16
	portable-atomic@1.11.0
	proc-macro2@1.0.95
	pyo3-build-config@0.24.2
	pyo3-ffi@0.24.2
	pyo3-macros-backend@0.24.2
	pyo3-macros@0.24.2
	pyo3@0.24.2
	quote@1.0.40
	r-efi@5.2.0
	rangemap@1.5.1
	regalloc2@0.10.2
	region@3.0.2
	ron@0.8.1
	rustc-demangle@0.1.24
	rustc-hash@2.1.1
	rustix@0.38.44
	ruzstd@0.7.3
	serde-xml-rs@0.6.0
	serde@1.0.219
	serde_derive@1.0.219
	slice-group-by@0.3.1
	smallvec@1.15.0
	stable_deref_trait@1.2.0
	static_assertions@1.1.0
	syn@2.0.100
	target-lexicon@0.12.16
	target-lexicon@0.13.2
	thiserror-impl@1.0.69
	thiserror@1.0.69
	tracing-core@0.1.33
	tracing@0.1.41
	twox-hash@1.6.3
	typed-arena@2.0.2
	unicode-ident@1.0.18
	unindent@0.2.4
	version_check@0.9.5
	wasi@0.14.2+wasi-0.2.4
	wasmtime-jit-debug@26.0.1
	wasmtime-jit-icache-coherence@26.0.1
	wasmtime-versioned-export-macros@26.0.1
	windows-sys@0.52.0
	windows-sys@0.59.0
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.52.6
	wit-bindgen-rt@0.39.0
	xml-rs@0.8.26
	zerocopy-derive@0.8.25
	zerocopy@0.8.25
"

declare -A GIT_CRATES=(
	[icicle-cpu]='https://github.com/icicle-emu/icicle-emu;4d7ed93254a20b7e5c16bd7b0c6b46db49e1c72e;icicle-emu-%commit%/icicle-cpu'
	[icicle-jit]='https://github.com/icicle-emu/icicle-emu;4d7ed93254a20b7e5c16bd7b0c6b46db49e1c72e;icicle-emu-%commit%/icicle-jit'
	[icicle-linux]='https://github.com/icicle-emu/icicle-emu;4d7ed93254a20b7e5c16bd7b0c6b46db49e1c72e;icicle-emu-%commit%/icicle-linux'
	[icicle-mem]='https://github.com/icicle-emu/icicle-emu;4d7ed93254a20b7e5c16bd7b0c6b46db49e1c72e;icicle-emu-%commit%/icicle-mem'
	[icicle-vm]='https://github.com/icicle-emu/icicle-emu;4d7ed93254a20b7e5c16bd7b0c6b46db49e1c72e;icicle-emu-%commit%/icicle-vm'
	[pcode]='https://github.com/icicle-emu/icicle-emu;4d7ed93254a20b7e5c16bd7b0c6b46db49e1c72e;icicle-emu-%commit%/sleigh/pcode'
	[sleigh-compile]='https://github.com/icicle-emu/icicle-emu;4d7ed93254a20b7e5c16bd7b0c6b46db49e1c72e;icicle-emu-%commit%/sleigh/sleigh-compile'
	[sleigh-parse]='https://github.com/icicle-emu/icicle-emu;4d7ed93254a20b7e5c16bd7b0c6b46db49e1c72e;icicle-emu-%commit%/sleigh/sleigh-parse'
	[sleigh-runtime]='https://github.com/icicle-emu/icicle-emu;4d7ed93254a20b7e5c16bd7b0c6b46db49e1c72e;icicle-emu-%commit%/sleigh/sleigh-runtime'
)

inherit cargo distutils-r1 pypi

DESCRIPTION="A multi-architecture binary analysis toolkit, with the ability to perform dynamic symbolic execution and various static analyses on binaries"
HOMEPAGE="https://angr.io"
SRC_URI+="
	${CARGO_CRATE_URIS}
"

LICENSE="BSD-2-Clause"
LICENSE+=" Apache-2.0-with-LLVM-exceptions MIT Unicode-3.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/pytoolconfig-1.2.2[${PYTHON_USEDEP}]
	dev-python/cxxheaderparser[${PYTHON_USEDEP}]
	dev-python/gitpython[${PYTHON_USEDEP}]
	=dev-python/ailment-${PV}[${PYTHON_USEDEP}]
	=dev-python/archinfo-${PV}[${PYTHON_USEDEP}]
	dev-python/cachetools[${PYTHON_USEDEP}]
	>=dev-libs/capstone-5.0.3[${PYTHON_USEDEP}]
	>=dev-python/cffi-1.14.0[${PYTHON_USEDEP}]
	=dev-python/claripy-${PV}[${PYTHON_USEDEP}]
	=dev-python/cle-${PV}[${PYTHON_USEDEP}]
	dev-python/mulpyplexer[${PYTHON_USEDEP}]
	>=dev-python/networkx-3.0[${PYTHON_USEDEP}]
	>=dev-python/protobuf-5.28.2[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	dev-python/pycparser[${PYTHON_USEDEP}]
	dev-python/pydemumble[${PYTHON_USEDEP}]
    dev-python/pyformlang[${PYTHON_USEDEP}]
	=dev-python/pyvex-${PV}[${PYTHON_USEDEP}]
    >=dev-python/rich-13.1.0[${PYTHON_USEDEP}]
    dev-python/sortedcontainers[${PYTHON_USEDEP}]
    dev-python/sympy[${PYTHON_USEDEP}]
    dev-python/unique-log-filter[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/build[${PYTHON_USEDEP}]
		dev-python/pip[${PYTHON_USEDEP}]
		dev-python/pytest-timeout[${PYTHON_USEDEP}]
	)
    dev-python/setuptools-rust[${PYTHON_USEDEP}]
"

QA_FLAGS_IGNORED=".*/_rust.*"

# src_configure() {
# 	cargo_src_configure --frozen
# }

src_unpack() {
    cargo_src_unpack
}

python_test_all() {
    cd src/angr || die
    cargo_src_test
}

distutils_enable_tests pytest
