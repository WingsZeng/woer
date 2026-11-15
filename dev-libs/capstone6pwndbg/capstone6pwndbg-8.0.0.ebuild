# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Capstone disassembly engine Python bindings for pwndbg"
HOMEPAGE="https://github.com/pwndbg/capstone6pwndbg"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

BDEPEND="dev-build/cmake"

python_prepare_all() {
	sed -e '/^add_executable(fuzz_disasm /,+1d' \
		-i src/CMakeLists.txt || die
	distutils-r1_python_prepare_all
}

python_test() {
	"${EPYTHON}" tests/test_all.py || die
	"${EPYTHON}" tests/test_iter.py || die
}
