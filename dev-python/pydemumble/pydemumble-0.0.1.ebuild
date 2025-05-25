# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=scikit-build-core
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="A Python wrapper library for demumble; demumble is a tool to demangle C++, Rust, and Swift symbol names."
HOMEPAGE="https://github.com/angr/pydemumble"

LICENSE="BSD-2-Clause"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/pytoolconfig-1.2.2[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/build[${PYTHON_USEDEP}]
		dev-python/pip[${PYTHON_USEDEP}]
		dev-python/pytest-timeout[${PYTHON_USEDEP}]
	)
"

# Copyed from distutils-r1.eclass
# Modify the "cmake.verbose" to "build.verbose" to meet the version of scikit-build-core
distutils_pep517_install() {
	debug-print-function ${FUNCNAME} "$@"
	[[ ${#} -eq 1 ]] || die "${FUNCNAME} takes exactly one argument: root"

	if [[ ! ${DISTUTILS_USE_PEP517:-no} != no ]]; then
		die "${FUNCNAME} is available only in PEP517 mode"
	fi

	local root=${1}
	export BUILD_DIR
	local -x WHEEL_BUILD_DIR=${BUILD_DIR}/wheel
	mkdir -p "${WHEEL_BUILD_DIR}" || die

	if [[ -n ${mydistutilsargs[@]} ]]; then
		die "mydistutilsargs are banned in PEP517 mode (use DISTUTILS_ARGS)"
	fi

	local cmd=() config_settings=
	if has cargo ${INHERITED} && [[ ${_CARGO_GEN_CONFIG_HAS_RUN} ]]; then
		cmd+=( cargo_env )
	fi

	# set it globally in case we were using "standalone" wrapper
	local -x FLIT_ALLOW_INVALID=1
	local -x HATCH_METADATA_CLASSIFIERS_NO_VERIFY=1
	local -x VALIDATE_PYPROJECT_NO_NETWORK=1
	local -x VALIDATE_PYPROJECT_NO_TROVE_CLASSIFIERS=1
	if in_iuse debug && use debug; then
		local -x SETUPTOOLS_RUST_CARGO_PROFILE=dev
	fi

	case ${DISTUTILS_USE_PEP517} in
		maturin)
			# `maturin pep517 build-wheel --help` for options
			local maturin_args=(
				"${DISTUTILS_ARGS[@]}"
				--auditwheel=skip # see bug #831171
				--jobs="$(makeopts_jobs)"
				$(in_iuse debug && usex debug '--profile=dev' '')
			)

			config_settings=$(
				"${EPYTHON}" - "${maturin_args[@]}" <<-EOF || die
					import json
					import sys
					print(json.dumps({"build-args": sys.argv[1:]}))
				EOF
			)
			;;
		meson-python)
			# variables defined by setup_meson_src_configure
			local MESONARGS=() BOOST_INCLUDEDIR BOOST_LIBRARYDIR NM READELF
			# it also calls filter-lto
			local x
			for x in $(all-flag-vars); do
				local -x "${x}=${!x}"
			done

			setup_meson_src_configure "${DISTUTILS_ARGS[@]}"

			local -x NINJAOPTS=$(get_NINJAOPTS)
			config_settings=$(
				"${EPYTHON}" - "${MESONARGS[@]}" <<-EOF || die
					import json
					import os
					import shlex
					import sys

					ninjaopts = shlex.split(os.environ["NINJAOPTS"])
					print(json.dumps({
						"builddir": "${BUILD_DIR}",
						"setup-args": sys.argv[1:],
						"compile-args": ["-v"] + ninjaopts,
					}))
				EOF
			)
			;;
		scikit-build-core)
			# TODO: split out the config/toolchain logic from cmake.eclass
			# for now, we copy the most important bits
			local CMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE:-RelWithDebInfo}
			cat >> "${BUILD_DIR}"/config.cmake <<- _EOF_ || die
				set(CMAKE_ASM_FLAGS_${CMAKE_BUILD_TYPE^^} "" CACHE STRING "")
				set(CMAKE_ASM-ATT_FLAGS_${CMAKE_BUILD_TYPE^^} "" CACHE STRING "")
				set(CMAKE_C_FLAGS_${CMAKE_BUILD_TYPE^^} "" CACHE STRING "")
				set(CMAKE_CXX_FLAGS_${CMAKE_BUILD_TYPE^^} "" CACHE STRING "")
				set(CMAKE_Fortran_FLAGS_${CMAKE_BUILD_TYPE^^} "" CACHE STRING "")
				set(CMAKE_EXE_LINKER_FLAGS_${CMAKE_BUILD_TYPE^^} "" CACHE STRING "")
				set(CMAKE_MODULE_LINKER_FLAGS_${CMAKE_BUILD_TYPE^^} "" CACHE STRING "")
				set(CMAKE_SHARED_LINKER_FLAGS_${CMAKE_BUILD_TYPE^^} "" CACHE STRING "")
				set(CMAKE_STATIC_LINKER_FLAGS_${CMAKE_BUILD_TYPE^^} "" CACHE STRING "")
			_EOF_

			# hack around CMake ignoring CPPFLAGS
			local -x CFLAGS="${CFLAGS} ${CPPFLAGS}"
			local -x CXXFLAGS="${CXXFLAGS} ${CPPFLAGS}"

			local cmake_args=(
				"-C${BUILD_DIR}/config.cmake"
				"${DISTUTILS_ARGS[@]}"
			)

			local -x NINJAOPTS=$(get_NINJAOPTS)
			config_settings=$(
				"${EPYTHON}" - "${cmake_args[@]}" <<-EOF || die
					import json
					import os
					import shlex
					import sys

					ninjaopts = shlex.split(os.environ["NINJAOPTS"])
					print(json.dumps({
						"build.tool-args": ninjaopts,
						"cmake.args": ";".join(sys.argv[1:]),
						"cmake.build-type": "${CMAKE_BUILD_TYPE}",
						"build.verbose": True,
						"install.strip": False,
					}))
				EOF
			)
			;;
		setuptools)
			if [[ -n ${DISTUTILS_ARGS[@]} ]]; then
				config_settings=$(
					"${EPYTHON}" - "${DISTUTILS_ARGS[@]}" <<-EOF || die
						import json
						import sys
						print(json.dumps({"--build-option": sys.argv[1:]}))
					EOF
				)
			fi
			;;
		sip)
			if [[ -n ${DISTUTILS_ARGS[@]} ]]; then
				# NB: for practical reasons, we support only --foo=bar,
				# not --foo bar
				local arg
				for arg in "${DISTUTILS_ARGS[@]}"; do
					[[ ${arg} != -* ]] &&
						die "Bare arguments in DISTUTILS_ARGS unsupported: ${arg}"
				done

				config_settings=$(
					"${EPYTHON}" - "${DISTUTILS_ARGS[@]}" <<-EOF || die
						import collections
						import json
						import sys

						args = collections.defaultdict(list)
						for arg in (x.split("=", 1) for x in sys.argv[1:]): \
							args[arg[0]].extend(
								[arg[1]] if len(arg) > 1 else [])

						print(json.dumps(args))
					EOF
				)
			fi
			;;
		*)
			[[ -n ${DISTUTILS_ARGS[@]} ]] &&
				die "DISTUTILS_ARGS are not supported by ${DISTUTILS_USE_PEP517}"
			;;
	esac

	# https://pyo3.rs/latest/building-and-distribution.html#cross-compiling
	if tc-is-cross-compiler; then
		local -x PYO3_CROSS_LIB_DIR=${SYSROOT}/$(python_get_stdlib)
	fi

	local build_backend=$(_distutils-r1_get_backend)
	einfo "  Building the wheel for ${PWD#${WORKDIR}/} via ${build_backend}"
	cmd+=(
		"${EPYTHON}" -m gpep517 build-wheel
			--prefix="${EPREFIX}/usr"
			--backend "${build_backend}"
			--output-fd 3
			--wheel-dir "${WHEEL_BUILD_DIR}"
	)
	if [[ -n ${config_settings} ]]; then
		cmd+=( --config-json "${config_settings}" )
	fi
	if [[ -n ${SYSROOT} ]]; then
		cmd+=( --sysroot "${SYSROOT}" )
	fi
	printf '%s\n' "${cmd[*]}"
	local wheel=$(
		"${cmd[@]}" 3>&1 >&2 || die "Wheel build failed"
	)
	[[ -n ${wheel} ]] || die "No wheel name returned"

	distutils_wheel_install "${root}" "${WHEEL_BUILD_DIR}/${wheel}"

	DISTUTILS_WHEEL_PATH=${WHEEL_BUILD_DIR}/${wheel}
}

distutils_enable_tests pytest
