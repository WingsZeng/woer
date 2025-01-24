# Copyright 2018-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit check-reqs go-module shell-completion

DESCRIPTION="Fast static HTML and CSS website generator"
HOMEPAGE="https://gohugo.io https://github.com/gohugoio/hugo"
SRC_URI="
	https://github.com/gohugoio/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/WingsZeng/hugo-go-deps/releases/download/v${PV}/${P}-deps.tar.xz
"

# NOTE: To create the vendor tarball, run:
# `go mod vendor && cd .. && tar -caf ${P}-vendor.tar.xz ${P}/vendor`

LICENSE="Apache-2.0 BSD BSD-2 MIT MPL-2.0 Unlicense"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~loong ~riscv ~x86"
IUSE="doc +extended"

BDEPEND="
	>=dev-lang/go-1.22.2
"
RDEPEND="
	extended? (
		dev-libs/libsass:=
		>=media-libs/libwebp-1.3.2:=
	)
"
DEPEND="${RDEPEND}"

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

_find_package() {
	local package_prefix=$1
	local package_name=$2
	local package_path

	package_path=$(find "${WORKDIR}/go-mod/${package_prefix}" -type d -name "${package_name}*" -print -quit)

	if [[ -z ${package_path} ]]; then
		die "Package not found"
	fi

	package_path=${package_path#${WORKDIR}/}

	echo "${package_path}"
}

pkg_pretend() {
	_check_reqs
}

pkg_setup() {
	_check_reqs
}

src_prepare() {
	local golibsass_path
	local gowebp_path

	golibsass_path=$(_find_package "github.com/bep" "golibsass")
	gowebp_path=$(_find_package "github.com/bep" "gowebp")

	# Apply sed patches
	sed -i 's|// #cgo CFLAGS: -O2 -fPIC|// #cgo CFLAGS: -fPIC|' "${WORKDIR}/${golibsass_path}/internal/libsass/a__cgo.go"
	sed -i 's|// #cgo CPPFLAGS: -I../../libsass_src/include|// #cgo CPPFLAGS: -DUSE_LIBSASS_SRC|' "${WORKDIR}/${golibsass_path}/internal/libsass/a__cgo.go"
	sed -i 's|// #cgo CXXFLAGS: -g -std=c++0x -O2 -fPIC|// #cgo CXXFLAGS: -std=c++0x -fPIC|' "${WORKDIR}/${golibsass_path}/internal/libsass/a__cgo.go"
	sed -i 's|// #cgo LDFLAGS: -lstdc++ -lm|// #cgo LDFLAGS: -lstdc++ -lm -lsass|' "${WORKDIR}/${golibsass_path}/internal/libsass/a__cgo.go"

	sed -i 's|// #cgo unix LDFLAGS: -lm|// #cgo unix LDFLAGS: -lm -lwebp\n// #cgo CFLAGS: -DLIBWEBP_NO_SRC|' "${WORKDIR}/${gowebp_path}/internal/libwebp/a__cgo.go"

	default
}

src_configure() {
	export CGO_ENABLED=1
	export CGO_CFLAGS="${CFLAGS}"
	export CGO_CPPFLAGS="${CPPFLAGS}"
	export CGO_CXXFLAGS="${CXXFLAGS}"
	export CGO_LDFLAGS="${LDFLAGS}"
	export MY_BUILD_FLAGS="$(usev extended "-tags extended")"

	default
}

src_compile() {
	mkdir -pv bin || die
	ego build -ldflags "-X github.com/gohugoio/hugo/common/hugo.vendorInfo=gentoo:${PVR}" \
		${MY_BUILD_FLAGS} -o "${S}/bin/hugo"

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

pkg_postinst() {
	elog "the sass USE-flag was renamed to extended. the functionality is the" \
		"same, except it also toggles the dependency on libwebp (for encoding)"
}
