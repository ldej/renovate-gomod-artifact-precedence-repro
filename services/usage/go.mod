module github.com/ldej/renovate-gomod-artifact-precedence-repro/services/usage

go 1.26.0

require (
	github.com/ldej/renovate-gomod-artifact-precedence-repro/pkg/cache v0.0.0-00010101000000-000000000000
	github.com/nats-io/nats.go v1.56.0
	github.com/valkey-io/valkey-go v1.0.80
)

require (
	github.com/klauspost/compress v1.20.0 // indirect
	github.com/nats-io/nkeys v0.4.16 // indirect
	github.com/nats-io/nuid v1.0.1 // indirect
	golang.org/x/crypto v0.57.0 // indirect
	golang.org/x/sys v0.50.0 // indirect
)

replace github.com/ldej/renovate-gomod-artifact-precedence-repro/pkg/cache => ../../pkg/cache
