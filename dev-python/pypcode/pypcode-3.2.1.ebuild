# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Python bindings to Ghidra's SLEIGH library for disassembly and lifting to P-Code IR"
HOMEPAGE="https://github.com/angr/pypcode"

LICENSE="BSD-2-Clause"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/pytoolconfig-1.2.2[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/build[${PYTHON_USEDEP}]
		dev-python/pip[${PYTHON_USEDEP}]
		dev-python/pytest-timeout[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
