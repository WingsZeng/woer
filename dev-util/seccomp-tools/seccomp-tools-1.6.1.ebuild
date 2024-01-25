# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
USE_RUBY="ruby31 ruby32"

RUBY_FAKEGEM_BINWRAP="seccomp-tools"
RUBY_FAKEGEM_EXTRADOC="README.md"
RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

inherit ruby-fakegem

DESCRIPTION="Provide powerful tools for seccomp analysis"
HOMEPAGE="https://github.com/david942j/seccomp-tools"
SRC_URI="https://github.com/david942j/seccomp-tools/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_bdepend "
    >=dev-ruby/rake-13.0
    >=dev-ruby/rake-compiler-1.0
    >=dev-ruby/rspec-3.9
    >=dev-ruby/rubocop-1
    >=dev-ruby/simplecov-0.21
    >=dev-ruby/yard-0.9
"

ruby_add_rdepend "
    >=dev-ruby/os-1.1.1
"

all_ruby_prepare() {
    sed -e 's/__dir__/"."/' \
        -e 's/__FILE__/"'${RUBY_FAKEGEM_GEMSPEC}'"/' \
        -e 's/git ls-files -z/find * -print0/' \
        -i ${RUBY_FAKEGEM_GEMSPEC} || die
}
each_ruby_compile() {
	${RUBY} -S rake compile || die "rake compile failed"
}

each_ruby_install() {
	each_fakegem_install

	# Ensure that newer rubygems version see the extention as installed
	ruby_fakegem_extensions_installed
}
