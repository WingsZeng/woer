# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
USE_RUBY="ruby31 ruby32 ruby33"

RUBY_FAKEGEM_BINWRAP="one_gadget"
RUBY_FAKEGEM_EXTRADOC="README.md"
RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

inherit ruby-fakegem

DESCRIPTION="The best tool for finding one gadget RCE in libc.so.6"

HOMEPAGE="https://github.com/david942j/one_gadget"
SRC_URI="https://github.com/david942j/one_gadget/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_bdepend "
    >=dev-ruby/rake-13.0
    >=dev-ruby/rspec-3.7
    >=dev-ruby/rubocop-1
	>=dev-ruby/simplecov-0.21
	>=dev-ruby/yard-0.9
"

# fix: elftools >= 1.0.2 < 1.2.0
# don't know how to do
ruby_add_rdepend "
    =dev-ruby/elftools-1.1*
"

all_ruby_prepare() {
    sed -e 's/__dir__/"."/' \
        -e 's/__FILE__/"'${RUBY_FAKEGEM_GEMSPEC}'"/' \
        -e 's/git ls-files -z/find * -print0/' \
        -i ${RUBY_FAKEGEM_GEMSPEC} || die
}
