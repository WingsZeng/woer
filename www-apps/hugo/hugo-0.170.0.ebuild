# Copyright 2018-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit check-reqs go-module shell-completion

DESCRIPTION="Fast static HTML and CSS website generator"
HOMEPAGE="https://gohugo.io https://github.com/gohugoio/hugo"
SRC_URI="
	https://github.com/gohugoio/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/WingsZeng/hugo-go-deps/releases/download/v${PV}/${P}-deps.tar.xz
"

LICENSE="Apache-2.0 BSD BSD-2 MIT MPL-2.0 Unlicense"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~loong ~riscv ~x86"
IUSE="doc"

BDEPEND="
	>=dev-lang/go-1.27.0
"

_check_reqs() {
	if [[ ${MERGE_TYPE} == binary ]] ; then
		return 0
	fi

	if has test ${FEATURES}; then
		CHECKREQS_DISK_BUILD="4G"
	else
		CHECKREQS_DISK_BUILD="1500M"
	fi
	check-reqs_${EBUILD_PHASE_FUNC}
}

pkg_pretend() {
	_check_reqs
}

pkg_setup() {
	_check_reqs
}

src_configure() {
	export CGO_ENABLED=0
	default
}

src_compile() {
	mkdir -pv bin || die
	ego build -ldflags "-X github.com/gohugoio/hugo/common/hugo.vendorInfo=gentoo:${PVR}" \
		-o "${S}/bin/hugo"

	bin/hugo gen man --dir man || die

	mkdir -pv completions || die
	bin/hugo completion bash > completions/hugo || die
	bin/hugo completion fish > completions/hugo.fish || die
	bin/hugo completion zsh > completions/_hugo || die

	if use doc ; then
		bin/hugo gen doc --dir doc || die
	fi
}

src_install() {
	dobin bin/*
	doman man/*

	dobashcomp completions/${PN}
	dofishcomp completions/${PN}.fish
	dozshcomp completions/_${PN}

	if use doc ; then
		dodoc -r doc/*
	fi
}
