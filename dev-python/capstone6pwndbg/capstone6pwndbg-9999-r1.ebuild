# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=(python3_{10..13})

inherit distutils-r1 git-r3

DESCRIPTION="Capstone disassembly engine Python bindings (pwndbg fork, renamed to capstone6pwndbg)"
HOMEPAGE="https://github.com/pwndbg/capstone6pwndbg"
EGIT_REPO_URI="https://github.com/pwndbg/capstone6pwndbg"
EGIT_SUBMODULES=("*")
EGIT_CHECKOUT_DIR="${WORKDIR}/${PN}"

LICENSE="BSD"
SLOT="0"

# Build source is capstone/bindings/python after the rename patch is applied
S="${WORKDIR}/${PN}/capstone/bindings/python"

src_prepare() {
	pushd "${WORKDIR}/${PN}/capstone" || die
	eapply "${WORKDIR}/${PN}/python-rename.patch"
	popd || die

	echo "CS_MODE_RISCVC = CS_MODE_RISCV_C" >>"${S}/capstone/__init__.py" || die

	distutils-r1_src_prepare
}
