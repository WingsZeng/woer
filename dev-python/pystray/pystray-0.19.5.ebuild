# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Provides system tray integration"
HOMEPAGE="
	https://github.com/moses-palmer/pystray
	https://pypi.org/project/pystray/
"
SRC_URI="
	https://github.com/moses-palmer/${PN}/archive/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/pillow[${PYTHON_USEDEP}]
	>=dev-python/python-xlib-0.17[${PYTHON_USEDEP}]
"
