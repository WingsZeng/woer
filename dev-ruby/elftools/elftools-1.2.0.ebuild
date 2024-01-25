# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
USE_RUBY="ruby31 ruby32 ruby33"

RUBY_FAKEGEM_BINWRAP=""
RUBY_FAKEGEM_EXTRADOC="README.md"
RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

inherit ruby-fakegem

DESCRIPTION="A light weight ELF parser. elftools is designed to be a low-level ELF parser."
HOMEPAGE="https://github.com/david942j/rbelftools"
SRC_URI="https://github.com/david942j/rbelftools/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_bdepend "
	>=dev-ruby/os-1
	>=dev-ruby/pry-0.10
    >=dev-ruby/rake-13.0
    >=dev-ruby/rspec-3.7
    >=dev-ruby/rubocop-1
	>=dev-ruby/simplecov-0.21
	>=dev-ruby/yard-0.9
"

ruby_add_rdepend "
	>=dev-ruby/bindata-2
"

all_ruby_unpack() {
    default
    # rename to correct package name
    mv "rb${P}" "${P}" || die
}

all_ruby_prepare() {
    sed -e 's/__dir__/"."/' \
        -e 's/__FILE__/"'${RUBY_FAKEGEM_GEMSPEC}'"/' \
        -e 's/git ls-files -z/find * -print0/' \
        -i ${RUBY_FAKEGEM_GEMSPEC} || die
}
