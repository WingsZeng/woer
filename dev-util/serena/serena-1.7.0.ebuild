# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 optfeature

DESCRIPTION="Semantic code tools for AI coding agents via MCP and LSP"
HOMEPAGE="
	https://github.com/oraios/serena
	https://pypi.org/project/serena-agent/
"
SRC_URI="
	https://github.com/oraios/${PN}/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gui"

RDEPEND="
	>=dev-python/anthropic-0.117.0[${PYTHON_USEDEP}]
	>=dev-python/beautifulsoup4-4.14.0[${PYTHON_USEDEP}]
	>=dev-python/cryptography-44.0.0[${PYTHON_USEDEP}]
	>=dev-python/docstring-parser-0.17[${PYTHON_USEDEP}]
	>=dev-python/filelock-3.25[${PYTHON_USEDEP}]
	>=dev-python/flask-3.1[${PYTHON_USEDEP}]
	>=dev-python/jinja2-3.1.6[${PYTHON_USEDEP}]
	>=dev-python/joblib-1.5[${PYTHON_USEDEP}]
	>=dev-python/lsprotocol-2025.0.0[${PYTHON_USEDEP}]
	>=dev-python/mcp-1.28[${PYTHON_USEDEP}]
	>=dev-python/oslex-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/overrides-7.7.0[${PYTHON_USEDEP}]
	>=dev-python/pathspec-0.12[${PYTHON_USEDEP}]
	>=dev-python/psutil-7.0.0[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.12[${PYTHON_USEDEP}]
	>=dev-python/pygls-2.1[${PYTHON_USEDEP}]
	>=dev-python/python-dotenv-1.2[${PYTHON_USEDEP}]
	>=dev-python/python-multipart-0.0.31[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-6.0.2[${PYTHON_USEDEP}]
	>=dev-python/regex-2024.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.32[${PYTHON_USEDEP}]
	>=dev-python/ruamel-yaml-0.18[${PYTHON_USEDEP}]
	>=dev-python/sensai-utils-1.5.0[${PYTHON_USEDEP}]
	>=dev-python/starlette-1.3[${PYTHON_USEDEP}]
	>=dev-python/tiktoken-0.12[${PYTHON_USEDEP}]
	>=dev-python/tqdm-4.67[${PYTHON_USEDEP}]
	>=dev-python/types-pyyaml-6.0.12[${PYTHON_USEDEP}]
	>=dev-python/urllib3-2.7[${PYTHON_USEDEP}]
	>=dev-python/werkzeug-3.1[${PYTHON_USEDEP}]
	gui? (
		>=dev-python/pillow-10.0[${PYTHON_USEDEP}]
		>=dev-python/pystray-0.19.5[${PYTHON_USEDEP}]
		>=dev-python/pywebview-6.2[${PYTHON_USEDEP}]
	)
"

src_prepare() {
	distutils-r1_src_prepare

	# Remove strict version pins, use minimum versions instead
	sed -i -e 's/==[^"]*"/"/g' pyproject.toml || die

	# Drop Windows-only dependency
	sed -i -e '/pythonnet/d' pyproject.toml || die

	# dotenv is a deprecated wrapper for python-dotenv which is already a dependency
	sed -i -e '/^\s*"dotenv/d' pyproject.toml || die
}

pkg_postinst() {
	optfeature "Agno agent framework integration" "dev-python/agno dev-python/sqlalchemy"
	optfeature "Google Gemini model support" dev-python/google-genai
}
