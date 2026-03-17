# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="A small library that optimizes some niche operations commonly used by debugger extensions"
HOMEPAGE="https://github.com/pwndbg/niche-elf"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

python_prepare_all() {
	cat >> pyproject.toml <<-EOF

	[build-system]
	requires = ["setuptools"]
	build-backend = "setuptools.build_meta"
	EOF

	distutils-r1_python_prepare_all
}
