# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="OS-independent wrapper for shlex and mslex"
HOMEPAGE="
	https://github.com/petamas/oslex
	https://pypi.org/project/oslex/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/mslex-1.3.0[${PYTHON_USEDEP}]
"
