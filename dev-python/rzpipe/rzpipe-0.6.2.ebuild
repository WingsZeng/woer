# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Pipe interface for rizin"
HOMEPAGE="https://rizin.re/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

RDEPEND="dev-util/rizin"

# Tests are not included in the sdist.
RESTRICT="test"

DOCS=( README.md )

python_prepare_all() {
	cat > pyproject.toml <<-EOF || die
	[build-system]
	requires = ["setuptools"]
	build-backend = "setuptools.build_meta"
	EOF

	distutils-r1_python_prepare_all
}
