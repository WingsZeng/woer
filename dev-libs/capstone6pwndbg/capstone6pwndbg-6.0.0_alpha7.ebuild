# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=(python3_{10..13})

inherit distutils-r1

MY_PV="${PV}"
MY_PV="${MY_PV/_alpha/-Alpha}"
MY_PV="${MY_PV/_beta/-Beta}"
MY_PV="${MY_PV/_rc/-rc}"
MY_P="${PN}-${MY_PV}"

CAPSTONE_PN="capstone"
CAPSTONE_P="${CAPSTONE_PN}-${PV}"
CAPSTONE_MY_P="${CAPSTONE_PN}-${MY_PV}"

DESCRIPTION="Capstone disassembly engine Python bindings (pwndbg fork, renamed to capstone6pwndbg)"
HOMEPAGE="https://github.com/pwndbg/capstone6pwndbg"
SRC_URI="
	https://github.com/pwndbg/capstone6pwndbg/archive/refs/tags/v${MY_PV}.tar.gz -> ${P}.tar.gz
	https://github.com/capstone-engine/capstone/archive/${MY_PV}.tar.gz -> ${CAPSTONE_P}.tar.gz
"

KEYWORDS="~amd64"

LICENSE="BSD"
SLOT="0"

IUSE="+python"
RDEPEND="python? ( ${PYTHON_DEPS} )"
DEPEND="${RDEPEND}
	python? ( dev-python/setuptools[${PYTHON_USEDEP}] )
"
BDEPEND="${DISTUTILS_DEPS}"
REQUIRED_USE="python ${PYTHON_REQUIRED_USE}"

# Build source is capstone/bindings/python after the rename patch is applied
S="${WORKDIR}/${CAPSTONE_MY_P}/bindings/python"

wrap_python() {
	local phase=$1
	shift

	if use python; then
		pushd "${S}" >/dev/null || die
		distutils-r1_${phase} "$@"
		popd >/dev/null || die
	fi
}

src_prepare() {
	tc-export RANLIB
	pushd "${WORKDIR}/${CAPSTONE_MY_P}" || die
	eapply "${WORKDIR}/${MY_P}/python-rename.patch"
	popd || die

	echo "CS_MODE_RISCVC = CS_MODE_RISCV_C" >>"${S}/capstone/__init__.py" || die

	wrap_python ${FUNCNAME}
}

src_configure() {
	wrap_python ${FUNCNAME}
}

src_compile() {
	wrap_python ${FUNCNAME}
}

src_test() {
	wrap_python ${FUNCNAME}
}

src_install() {
	wrap_python ${FUNCNAME}
}

python_test() {
	./tests/test_all.py || die
	./tests/test_iter.py || die
}
