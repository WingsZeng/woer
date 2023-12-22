# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="user for naiveproxy"
ACCT_USER_ID=208
ACCT_USER_GROUPS=( naive )

acct-user_add_deps
