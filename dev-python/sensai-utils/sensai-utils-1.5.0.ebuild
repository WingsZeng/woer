# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Utilities from sensAI, the Python library for sensible AI"
HOMEPAGE="
	https://github.com/opcode81/sensAI-utils
	https://pypi.org/project/sensai-utils/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/typing-extensions-4.6[${PYTHON_USEDEP}]
"

src_prepare() {
	distutils-r1_src_prepare

	# setup.py reads requirements.txt absent from sdist; replace with declarative config
	cat > pyproject.toml <<-EOF
	[build-system]
	requires = ["setuptools"]
	build-backend = "setuptools.build_meta"

	[project]
	name = "sensai-utils"
	version = "${PV}"
	dependencies = ["typing-extensions>=4.6"]

	[tool.setuptools.packages.find]
	where = ["src"]
	EOF
	rm setup.py || die
}
