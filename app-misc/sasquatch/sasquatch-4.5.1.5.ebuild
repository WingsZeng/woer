# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A set of patches to the standard unsquashfs utility (part of squashfs-tools) that attempts to add support for as many hacked-up vendor-specific SquashFS implementations as possible."
HOMEPAGE="https://github.com/onekey-sec/sasquatch/"
MY_PV="${PV%.*}-${PV##*.}"
SRC_URI="https://github.com/onekey-sec/sasquatch/archive/refs/tags/sasquatch-v${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+gzip +xz +lzo +lz4 +zstd +default_gzip default_lzma default_xz default_lzo default_lz4 default_zstd +xattr"
REQUIRED_USE="
	default_gzip? ( gzip )
	default_xz? ( xz )
	default_lzo? ( lzo )
	default_lz4? ( lz4 )
	default_zstd? ( zstd )
	^^ ( default_gzip default_lzma default_xz default_lzo default_lz4 default_zstd )
"

DEPEND="
	gzip? ( app-arch/gzip )
	xz? ( app-arch/xz-utils )
	lzo? ( dev-libs/lzo:2 )
	lz4? ( app-arch/lz4 )
	zstd? ( app-arch/zstd )
"

S=${WORKDIR}/${PN}-${PN}-v${MY_PV}

src_compile() {
	comp_default=""
	if use default_gzip; then
		comp_default=gzip
	elif use default_lzma; then
		comp_default=lzma
	elif use default_xz; then
		comp_default=xz
	elif use default_lzo; then
		comp_default=lzo
	elif use default_lz4; then
		comp_default=lz4
	elif use default_zstd; then
		comp_default=zstd
	fi

	emake -C squashfs-tools \
		GZIP_SUPPORT=$(usev gzip 1) \
		XZ_SUPPORT=$(usev xz 1) \
		LZO_SUPPORT=$(usev lzo 1) \
		LZ4_SUPPORT=$(usev lz4 1) \
		ZSTD_SUPPORT=$(usev zstd 1) \
		COMP_DEFAULT=$comp_default \
		XATTR_SUPPORT=$(usev xattr 1)
}

src_install() {
	dobin squashfs-tools/sasquatch
}
