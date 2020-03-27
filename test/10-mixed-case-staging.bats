#! /usr/bin/env bats

load '/bats-support/load.bash'
load '/bats-assert/load.bash'
load '/getssl/test/test_helper.bash'


@test "Check can create certificate if domain is not lowercase using staging server and DuckDNS" {
    if [ -z "$STAGING" ]; then
        skip "Running internal tests, skipping external test"
    fi

    CONFIG_FILE="getssl-duckdns01.cfg"
    GETSSL_CMD_HOST=$(echo $GETSSL_HOST | tr a-z A-Z)

    setup_environment
    init_getssl
    create_certificate

    assert_success
    refute_output --regexp '[Ff][Aa][Ii][Ll][Ee][Dd]'
    refute_output --regexp '[Ee][Rr][Rr][Oo][Rr]'
    refute_output --regexp '[Ww][Aa][Rr][Nn][Ii][Nn][Gg]'
}
