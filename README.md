# BitAsset Protocol

## Decentralized Real-World Asset Tokenization on Bitcoin Layer 2

BitAsset is a comprehensive smart contract protocol built on Stacks that enables the tokenization of real-world assets on Bitcoin's secure settlement layer. The protocol provides fractional ownership, decentralized governance, automated dividend distribution, and regulatory compliance through integrated KYC verification.

## 🌟 Features

- **Fractional Asset Ownership**: Tokenize real-world assets into 100,000 Semi-Fungible Tokens (SFTs) per asset
- **Decentralized Governance**: Weighted voting system based on token ownership
- **Automated Dividend Distribution**: Proportional dividend claims based on ownership percentage
- **Oracle Integration**: Real-time asset pricing through oracle price feeds
- **KYC Compliance**: Built-in regulatory framework with multi-level KYC verification
- **Bitcoin Security**: Leverages Bitcoin's security model through Stacks Layer 2

## 🏗️ Architecture Overview

```
┌─────────────────────────────────────────────────────────────┐
│                    BitAsset Protocol                        │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌─────────────────┐    ┌─────────────────┐                │
│  │  Asset Registry │    │ Token Balances  │                │
│  │                 │    │                 │                │
│  │ • Asset metadata│    │ • Owner mapping │                │
│  │ • Valuations    │    │ • Balance info  │                │
│  │ • Lock status   │    │ • Distribution  │                │
│  └─────────────────┘    └─────────────────┘                │
│                                                             │
│  ┌─────────────────┐    ┌─────────────────┐                │
│  │   Governance    │    │   Dividends     │                │
│  │                 │    │                 │                │
│  │ • Proposals     │    │ • Claim tracker │                │
│  │ • Voting system │    │ • Distribution  │                │
│  │ • Execution     │    │ • Calculations  │                │
│  └─────────────────┘    └─────────────────┘                │
│                                                             │
│  ┌─────────────────┐    ┌─────────────────┐                │
│  │  KYC Registry   │    │  Oracle Feeds   │                │
│  │                 │    │                 │                │
│  │ • Approval      │    │ • Price data    │                │
│  │ • Levels (1-5)  │    │ • Timestamps    │                │
│  │ • Expiry dates  │    │ • Oracle auth   │                │
│  └─────────────────┘    └─────────────────┘                │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
                 ┌─────────────────────┐
                 │   Bitcoin Layer 1   │
                 │                     │
                 │ • Settlement        │
                 │ • Security          │
                 │ • Finality          │
                 └─────────────────────┘
```

## 📊 System Overview

### Core Components

#### 1. Asset Management

- **Asset Registration**: Register real-world assets with metadata, valuation, and ownership
- **Tokenization**: Each asset is divided into 100,000 SFTs for fractional ownership
- **Asset Locking**: Ability to lock assets for specific operations or compliance

#### 2. Token Management

- **Balance Tracking**: Maintains ownership records for each token holder
- **Transfer Mechanics**: Semi-fungible token transfers between verified users
- **Ownership Verification**: KYC-gated token operations

#### 3. Governance System

- **Proposal Creation**: Asset stakeholders can create governance proposals
- **Weighted Voting**: Voting power proportional to token ownership
- **Execution Framework**: Automated proposal execution based on voting outcomes

#### 4. Dividend Distribution

- **Proportional Claims**: Dividends distributed based on ownership percentage
- **Claim Tracking**: Prevents double-claiming and tracks distribution history
- **Automated Calculation**: Smart contract calculates claimable amounts

#### 5. Compliance Layer

- **KYC Integration**: Multi-level KYC verification (Levels 1-5)
- **Regulatory Framework**: Built-in compliance checks for all operations
- **Expiry Management**: Time-bound KYC approvals with renewal requirements

## 🔄 Data Flow

### Asset Registration Flow

```
Owner → register-asset() → Asset Registry → Token Minting → Balance Assignment
```

### Dividend Claim Flow

```
Token Holder → claim-dividends() → Balance Check → Calculate Claimable → Update Claims → Transfer
```

### Governance Flow

```
Stakeholder → create-proposal() → Voting Period → vote() → Execution → State Update
```

### Oracle Price Update Flow

```
Oracle → update-price() → Price Validation → Asset Value Update → Event Emission
```

## 🛡️ Security Features

### Access Control

- **Owner-only Functions**: Critical operations restricted to contract owner
- **Stakeholder Verification**: Governance participation requires minimum token ownership
- **KYC Gating**: All operations require valid KYC status

### Validation Framework

- **Input Validation**: Comprehensive validation for all user inputs
- **Range Checks**: Asset values, durations, and amounts within defined limits
- **State Verification**: Consistent state checks before state modifications

### Error Handling

- **Comprehensive Error Codes**: Detailed error reporting for all failure scenarios
- **Transaction Safety**: All operations are atomic with proper rollback mechanisms
- **Edge Case Protection**: Handles various edge cases and invalid states

## 📋 Constants & Limits

| Parameter | Value | Description |
|-----------|-------|-------------|
| `MAX_ASSET_VALUE` | 1,000,000,000,000 | Maximum asset valuation |
| `MIN_ASSET_VALUE` | 1,000 | Minimum asset valuation |
| `MAX_DURATION` | 144 blocks | Maximum proposal duration (~1 day) |
| `MIN_DURATION` | 12 blocks | Minimum proposal duration (~1 hour) |
| `MAX_KYC_LEVEL` | 5 | Maximum KYC verification level |
| `MAX_EXPIRY` | 52,560 blocks | Maximum KYC expiry (~1 year) |
| `tokens-per-asset` | 100,000 | SFTs minted per asset |

## 🚀 Getting Started

### Prerequisites

- Stacks blockchain environment
- Clarinet for local development and testing
- Valid KYC verification for participation

### Deployment

1. Deploy the contract to Stacks testnet/mainnet
2. Initialize with contract owner
3. Configure oracle connections
4. Set up KYC verification processes

### Basic Usage

#### Register an Asset

```clarity
(contract-call? .bitasset register-asset "ipfs://metadata-hash" u1000000)
```

#### Claim Dividends

```clarity
(contract-call? .bitasset claim-dividends u1)
```

#### Create Governance Proposal

```clarity
(contract-call? .bitasset create-proposal u1 "Proposal Title" u144 u1000)
```

#### Vote on Proposal

```clarity
(contract-call? .bitasset vote u1 true u500)
```

## 📖 API Reference

### Public Functions

| Function | Parameters | Description |
|----------|------------|-------------|
| `register-asset` | metadata-uri, asset-value | Register new asset (owner only) |
| `claim-dividends` | asset-id | Claim proportional dividends |
| `create-proposal` | asset-id, title, duration, min-votes | Create governance proposal |
| `vote` | proposal-id, vote-for, amount | Vote on active proposal |

### Read-Only Functions

| Function | Parameters | Description |
|----------|------------|-------------|
| `get-asset-info` | asset-id | Retrieve asset details |
| `get-balance` | owner, asset-id | Get token balance |
| `get-proposal` | proposal-id | Get proposal details |
| `get-vote` | proposal-id, voter | Get voting record |
| `get-price-feed` | asset-id | Get oracle price data |

## 🏗️ Contract Architecture

### Data Structures

#### Assets Map

```clarity
{
  owner: principal,
  metadata-uri: string-ascii,
  asset-value: uint,
  is-locked: bool,
  creation-height: uint,
  last-price-update: uint,
  total-dividends: uint
}
```

#### Token Balances Map

```clarity
{
  owner: principal,
  asset-id: uint,
  balance: uint
}
```

#### Governance Proposals Map

```clarity
{
  title: string-ascii,
  asset-id: uint,
  start-height: uint,
  end-height: uint,
  executed: bool,
  votes-for: uint,
  votes-against: uint,
  minimum-votes: uint
}
```

## 🔐 Compliance & Regulatory

### KYC Requirements

- All participants must maintain valid KYC status
- Multiple verification levels (1-5) for different access tiers
- Time-bound approvals requiring periodic renewal
- Compliance checks integrated into all token operations

### Oracle Integration

- Real-time asset pricing through authenticated oracles
- Price staleness protection with timestamp validation
- Multiple oracle support for price consensus
- Oracle authorization and access control

## 🛠️ Development

### Testing

- Comprehensive unit tests for all functions
- Integration tests for complex workflows
- Edge case testing for security validation
- Oracle simulation for price feed testing

### Deployment Checklist

- [ ] Configure contract owner
- [ ] Set up oracle connections
- [ ] Initialize KYC verification system
- [ ] Deploy to testnet for validation
- [ ] Security audit completion
- [ ] Mainnet deployment
