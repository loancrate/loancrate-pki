# LoanCrate Public Key Infrastructure

Configuration and scripts to generate LoanCrate's public key infrastructure (PKI).

## Configuration

We use [CFSSL (Cloudflare's PKI and TLS toolkit)](https://github.com/cloudflare/cfssl) to generate certificates and keys.
They have [installation instructions](https://github.com/cloudflare/cfssl#installation), but the short version with [Homebrew](https://brew.sh/) on Mac is:

```sh
brew install go
go install github.com/cloudflare/cfssl/cmd/...@latest
```

## Generating certificates, keys, bundles, etc

Running `make` in any directory will generate any missing or out of date artifacts in that directory and its subdirectories.

## List certificate expirations

Run `make expiration` to list the expiration date for each certificate in the repository.

## Renewing certificates

Run `make renew-<cert name>` to generate a new certificate with the existing CSR for each environment.

## Directory structure

The top-level subdirectories correspond to deployment environments, such as production, staging, and development.
Each environment directory contains the root certificate authority (CA) for that environment.
The subdirectories of the environments contain intermediate CAs.
The subdirectories of the intermediate CA directories contain end-entity certificates.

## Committing generated files

Because the generated certificates and bundles are distributed publicly and need to remain stable, they should be committed to version control.
However, because the security of the PKI depends on limiting access to the private keys, these are not committed.
Instead, the keys are stored in a separate secret manager, such as 1Password.

## Key management

To be able to generate certificates for an environment, you'll need the key of the CA under which you want to generate it.
For instance, to generate an end-entity certificate, you'll need the key of the intermediate CA, which you can obtain from the secret manager.
Once you've generated the certificate and key, the certificate should be committed to version control, and the key stored in the secret manager.

To make key management more convenient for environment administrators (who have access to the root CA key),
all keys for an environment are stored in a `.tgz` archive in the root directory.
For instance, the production keys would be stored in `production-keys.tgz`.
Whenever keys are added or changed in an environment, the key archive is updated.
To start working with an environment from a clean checkout of the repository, just download and extract the key archive for it.
Whenever you generate new keys, upload the updated key archive back to the secret manager.
To avoid over-sharing or accidental deletion of keys, the individual keys should also be pasted separately into the secret manager.
