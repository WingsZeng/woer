# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
USE_RUBY="ruby31 ruby32 ruby33"

RUBY_FAKEGEM_BINWRAP=""
RUBY_FAKEGEM_EXTRADOC="README.md"
RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

inherit ruby-fakegem

DESCRIPTION="The OS gem allows for some useful and easy functions, like OS.windows? (=> true or false) OS.bits ( => 32 or 64) etc"
HOMEPAGE="https://github.com/rdp/os"
SRC_URI="https://github.com/rdp/os/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_bdepend "
    >=dev-ruby/rake-10.5
    >=dev-ruby/rspec-3.12
    >=dev-ruby/test-unit-3.5
"

PATCHES=(
    "${FILESDIR}"/${P}-https.patch
    "${FILESDIR}"/${P}-add-cygwin-support.patch
    "${FILESDIR}"/${P}-add-host_cpu-to-doc.patch
    "${FILESDIR}"/${P}-remove-circular-dependency.patch
    "${FILESDIR}"/${P}-upgrade-rspec.patch
)
