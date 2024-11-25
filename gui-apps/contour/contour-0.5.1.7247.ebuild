# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Modern C++ Terminal Emulator"
HOMEPAGE="http://contour-terminal.org/"

LIBUNICODE_COMMIT="817cb5900acdf6f60e2344a4c8f1f39262878a4b"
TERMBENCH_COMMIT="f6c37988e6481b48a8b8acaf1575495e018e9747"
BOXED_CPP_VERSION="1.4.3"
REFLECTION_COMMIT="02484cd9ec16d7efc252ab8fd1f85d7264192418"
LIBUNICODE_UCD_VERSION="16.0.0"

SRC_URI="
	https://github.com/contour-terminal/contour/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/contour-terminal/termbench-pro/archive/${TERMBENCH_COMMIT}.tar.gz -> termbench-pro-${TERMBENCH_COMMIT}.tar.gz
	https://github.com/contour-terminal/boxed-cpp/archive/refs/tags/v${BOXED_CPP_VERSION}.tar.gz -> boxed-cpp-${BOXED_CPP_VERSION}.tar.gz
	https://github.com/contour-terminal/libunicode/archive/${LIBUNICODE_COMMIT}.tar.gz -> libunicode-${LIBUNICODE_COMMIT}.tar.gz
	https://github.com/contour-terminal/reflection-cpp/archive/${REFLECTION_COMMIT}.tar.gz -> reflection-cpp-${REFLECTION_COMMIT}.tar.gz
	https://www.unicode.org/Public/${LIBUNICODE_UCD_VERSION}/ucd/UCD.zip -> ucd-${LIBUNICODE_UCD_VERSION}
"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="wayland"
KEYWORDS="~amd64"

QT6_DEPEND="
	dev-qt/qtbase[gui,opengl]
	wayland? ( dev-qt/qtbase[wayland] )
	dev-qt/qtdeclarative
	dev-qt/qt5compat[qml]
	dev-qt/qtmultimedia[qml]
"

DEPEND="
	media-libs/fontconfig
	media-libs/freetype
	media-libs/harfbuzz
	net-libs/libssh2
	sys-libs/libutempter
	x11-libs/libxcb
	dev-cpp/yaml-cpp
	${QT6_DEPEND}
"
RDEPEND="${DEPEND}"
BDEPEND="
	virtual/pkgconfig
    kde-frameworks/extra-cmake-modules
    dev-cpp/catch
    dev-cpp/ms-gsl
	dev-cpp/range-v3
"

src_unpack() {
	default
	mkdir -p "${WORKDIR}/libunicode-${LIBUNICODE_COMMIT}/_ucd"
    cp "${DISTDIR}/ucd-${LIBUNICODE_UCD_VERSION}" "${WORKDIR}/libunicode-${LIBUNICODE_COMMIT}/_ucd/ucd-${LIBUNICODE_UCD_VERSION}.zip" || die
}

src_prepare() {
	if use wayland; then
		PATCHES+=( "${FILESDIR}/no-blur-behind-on-wayland.patch" )
	fi

	cmake_src_prepare

	local sysdeps_src_dir="${S}/_deps/sources"
	mkdir -p "${sysdeps_src_dir}"
	mv "${WORKDIR}/libunicode-${LIBUNICODE_COMMIT}" "${sysdeps_src_dir}" || die
	mv "${WORKDIR}/boxed-cpp-${BOXED_CPP_VERSION}" "${sysdeps_src_dir}" || die
	mv "${WORKDIR}/termbench-pro-${TERMBENCH_COMMIT}" "${sysdeps_src_dir}" || die
	mv "${WORKDIR}/reflection-cpp-${REFLECTION_COMMIT}" "${sysdeps_src_dir}" || die
    cat > "${sysdeps_src_dir}"/CMakeLists.txt <<-EOF
		macro(ContourThirdParties_Embed_libunicode)
    		add_subdirectory(\${ContourThirdParties_SRCDIR}/libunicode-${LIBUNICODE_COMMIT} EXCLUDE_FROM_ALL)
		endmacro()
		macro(ContourThirdParties_Embed_boxed_cpp)
    		add_subdirectory(\${ContourThirdParties_SRCDIR}/boxed-cpp-${BOXED_CPP_VERSION} EXCLUDE_FROM_ALL)
		endmacro()
		macro(ContourThirdParties_Embed_termbench_pro)
    		add_subdirectory(\${ContourThirdParties_SRCDIR}/termbench-pro-${TERMBENCH_COMMIT} EXCLUDE_FROM_ALL)
		endmacro()
	EOF

	sed -i '/install(DIRECTORY "\${terminfo_basedir}" DESTINATION "\${CMAKE_INSTALL_DATADIR}")/d' ${S}/src/contour/CMakeLists.txt
}

src_configure() {
    local mycmakeargs=(
        -DPEDANTIC_COMPILER=ON
        -DPEDANTIC_COMPILER_WERROR=OFF
    )
    cmake_src_configure
}

