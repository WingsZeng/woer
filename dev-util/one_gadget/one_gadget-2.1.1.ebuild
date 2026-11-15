# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
USE_RUBY="ruby33 ruby34 ruby40"

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

ruby_add_rdepend "
	>=dev-ruby/elftools-2.2.0
	<dev-ruby/elftools-3
	dev-ruby/logger
"

all_ruby_prepare() {
	sed -e 's/__dir__/"."/' \
		-i ${RUBY_FAKEGEM_GEMSPEC} || die
}
