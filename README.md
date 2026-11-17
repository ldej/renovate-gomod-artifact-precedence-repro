# Renovate gomod artifact-precedence reproduction

Minimal reproduction for a grouped Go update with `gomodTidyAll` and a local module replacement.

## Fixture

- `pkg/cache` requires `github.com/valkey-io/valkey-go v1.0.79`.
- `services/usage` imports that cache module with a local `replace`, and requires both valkey and `github.com/nats-io/nats.go v1.55.0`.
- One gomod package rule groups all Go dependency updates as `all-go`.
- There is no Go workspace, custom post-upgrade command, or private dependency to interfere with the case.

The starting versions are deliberately one release behind. A correct grouped update should produce valkey `v1.0.80` and NATS `v1.56.0`, with consistent `go.mod` and `go.sum` files. Processing `pkg/cache` before `services/usage` can capture a dependent `go.mod` before the direct usage update runs, exposing the artifact-precedence problem this fixture targets.

## Baseline check

```sh
go -C pkg/cache mod tidy
go -C services/usage mod tidy
go -C pkg/cache test ./...
go -C services/usage test ./...
go -C pkg/cache mod tidy -diff
go -C services/usage mod tidy -diff
```

## Reproduce

With a GitHub token exported as `RENOVATE_TOKEN`, run against the repository's `main` branch:

```sh
npx --yes --package renovate@44.241.0 renovate \
  --platform=github \
  --require-config=optional \
  ldej/renovate-gomod-artifact-precedence-repro
```

Renovate's generated branch and pull request contain the reproduction evidence. The expected bug is that `services/usage/go.mod` does not retain the direct NATS version bump even though `services/usage/go.sum` has been updated for it.
