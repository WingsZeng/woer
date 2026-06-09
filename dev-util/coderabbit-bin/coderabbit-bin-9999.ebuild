EAPI=8

DESCRIPTION="AI-powered code review CLI"
HOMEPAGE="https://coderabbit.ai"

PROPERTIES="live"
LICENSE=""
SLOT="0"
RESTRICT="bindist mirror strip"

BDEPEND="app-arch/unzip net-misc/wget"
RDEPEND="dev-vcs/git"

S="${WORKDIR}"

QA_PREBUILT="usr/bin/coderabbit"

src_unpack() {
    local my_arch
    use amd64 && my_arch="x64"
    use arm64 && my_arch="arm64"

    wget -q "https://cli.coderabbit.ai/releases/latest/coderabbit-linux-${my_arch}.zip" \
        -O "${T}/coderabbit.zip" || die "Download failed"
    cd "${S}" || die
    unzip -q "${T}/coderabbit.zip" || die "Unzip failed"
}

src_install() {
    dobin coderabbit
    dosym coderabbit /usr/bin/cr
}
