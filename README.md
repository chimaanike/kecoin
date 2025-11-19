# kecoin

A simple [Clarity](https://docs.stacks.co/write-smart-contracts/clarity-language) fungible token project scaffolded with [Clarinet](https://docs.hiro.so/clarinet).

The `kecoin` contract defines a basic fungible token suitable for local development, experiments, and examples.

## Prerequisites

- [Clarinet](https://docs.hiro.so/clarinet) installed and available on your `PATH`.
  - Verify with:
    - `clarinet --version`

## Project structure

- `Clarinet.toml` – Clarinet project configuration.
- `contracts/kecoin.clar` – main kecoin token smart contract.
- `settings/` – network configuration files (Devnet, Testnet, Mainnet).
- `tests/kecoin.test.ts` – placeholder for unit tests for the kecoin contract.

Additional files created by Clarinet (e.g. `.vscode`, `package.json`, `tsconfig.json`, etc.) support editor integration and TypeScript-based testing.

## Contract overview

The `kecoin` contract implements a simple fungible token with the following properties:

- **Token name**: `"kecoin"`
- **Symbol**: `"KEC"`
- **Decimals**: `6`
- **Owner model**: this simple example does **not** enforce a special owner; any
  principal may mint tokens. This is suitable for local development only.

The contract exposes:

### Read-only functions

- `get-name` → `(response (string-utf8 32) uint)`  
  Returns the human-readable name of the token.

- `get-symbol` → `(response (string-utf8 10) uint)`  
  Returns the ticker symbol for the token.

- `get-decimals` → `(response uint uint)`  
  Returns the number of decimal places.

- `get-balance-of (owner principal)` → `(response uint uint)`  
  Returns the balance of `owner`.

- `get-total-supply` → `(response uint uint)`  
  Returns the total number of tokens minted via this contract.

### Public functions

- `mint (amount uint) (recipient principal)` → `(response bool uint)`  
  Mints `amount` of `kecoin` tokens to `recipient`. In this simple example,
  any principal may call `mint` for local testing.

- `transfer (amount uint) (recipient principal)` → `(response bool uint)`  
  Transfers `amount` of `kecoin` tokens from the caller (`tx-sender`) to `recipient`.

## Common workflows

All commands below assume you are in the project root:

```bash
cd /home/anthony/Documents/GitHub/kecoin
```

### Check the contract

Run static analysis and type checking for all contracts:

```bash
clarinet check
```

### Open a Clarinet console

To interact with the contract from a REPL-like environment:

```bash
clarinet console
```

Example console commands:

```clarity
;; Check initial total supply
(contract-call? .kecoin get-total-supply)

;; Mint tokens as the contract owner (replace with the deployer principal in the console)
(contract-call? .kecoin mint u1000000 'ST3J2GVMMM2R07ZFBJDWTYEYAR8FZH5WK0C3FRM2)

;; Check balance
(contract-call? .kecoin get-balance-of 'ST3J2GVMMM2R07ZFBJDWTYEYAR8FZH5WK0C3FRM2)

;; Transfer tokens from one principal to another
(contract-call? .kecoin transfer u1000 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM)
```

### Run tests

Clarinet scaffolds a TypeScript test file in `tests/kecoin.test.ts`.

Install dependencies and run tests:

```bash
npm install
npm test
```

## Development tips

- Use `clarinet check` frequently while editing contracts to catch errors early.
- Use `clarinet console` to experiment with contract calls before writing tests.
- Keep the README updated as you add more contracts or functionality to the project.
