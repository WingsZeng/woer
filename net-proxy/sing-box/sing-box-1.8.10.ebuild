# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="The universal proxy platform"
HOMEPAGE="https://sing-box.sagernet.org"

SRC_URI="
	https://github.com/SagerNet/${PN}/archive/refs/tags/v${PV}.tar.gz
	https://github.com/WingsZeng/sing-box-go-deps/releases/download/v${PV}/${P}-deps.tar.xz
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm64"
IUSE="+quic grpc +dhcp +wireguard +ech +utls +reality_server +acme +clash_api v2ray_api +gvisor embedded_tor"

DEPEND=""
RDEPEND="
	${DEPEND}
"
BDEPEND="
	>=dev-lang/go-1.18.5
	virtual/pkgconfig
	quic? (
		>=dev-lang/go-1.20.0
	)
	ech? (
		>=dev-lang/go-1.20.0
	)
	utls? (
		>=dev-lang/go-1.20.0
	)
"

src_configure() {
	local tags=""
	use quic && tags+="with_quic,"
	use grpc && tags+="with_grpc,"
	use dhcp && tags+="with_dhcp,"
	use wireguard && tags+="with_wireguard,"
	use ech && tags+="with_ech,"
	use utls && tags+="with_utls,"
	use reality_server && tags+="with_reality_server,"
	use acme && tags+="with_acme,"
	use clash_api && tags+="with_clash_api,"
	use v2ray_api && tags+="with_v2ray_api,"
	use gvisor && tags+="with_gvisor,"
	use embedded_tor && tags+="with_embedded_tor,"

	if [ -z "$tags" ]; then
		export TAGS="''"
	else
		export TAGS="${tags%,}"
	fi

	export GOHOSTOS=$(go env GOHOSTOS)
	export GOHOSTARCH=$(go env GOHOSTARCH)
	export VERSION=$(CGO_ENABLED=0 GOOS=${GOHOSTOS} GOARCH=${GOHOSTARCH} go run ./cmd/internal/read_tag)

	default
}

src_compile() {
	ego build -o ./bin/sing-box -v -trimpath -ldflags \
		"-X 'github.com/sagernet/sing-box/constant.Version=${VERSION}' -s -w -buildid=" \
		-tags ${TAGS} ./cmd/sing-box
}

src_install() {
	dobin bin/sing-box
	insinto /etc/sing-box
        doins release/config/config.json
	newinitd "${FILESDIR}/sing-box.initd" sing-box
}

pkg_postinst() {
	local data_dir="/usr/share/sing-box"
	if [[ ! -d ${data_dir} ]]; then
		mkdir -p ${data_dir}
		echo "Created ${data_dir} directory"
	fi
}

pkg_postrm() {
	local data_dir="/usr/share/sing-box"
        if [[ ! -d ${data_dir} ]]; then
                rm -rf ${data_dir}
                echo "Removed ${data_dir} directory"
        fi
}