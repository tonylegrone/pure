set --global DIRNAME $current_dirname

function setup
    cp tests/fixtures/{config.mock.fish,config.fish}
end

function teardown
    rm tests/fixtures/config.fish
end

@test "migrate all variables" (
    set file_to_migrate tests/fixtures/config.fish  # created during 'setup'

    fish tools/migration-to-2.0.0.fish $file_to_migrate 2>&1 >/dev/null

    diff -U 0 tests/fixtures/config.expected.fish $file_to_migrate
) $status -eq 0

