;; Title: BitAsset - Decentralized Real-World Asset Tokenization
;;
;; Summary: A comprehensive smart contract protocol for tokenizing 
;; real-world assets on Bitcoin Layer 2 via Stacks, enabling fractional
;; ownership, governance, and dividend distribution with KYC compliance.
;;
;; Description: BitAsset transforms physical and digital assets into
;; blockchain-native tokens, providing liquidity and accessibility to
;; traditionally illiquid investments. The protocol features automated
;; governance mechanisms, oracle-based pricing, dividend distribution,
;; and regulatory compliance through integrated KYC verification.
;; Built specifically for Bitcoin's security model through Stacks L2.
;;
;; Features:
;; - Fractional asset ownership through SFT tokenization
;; - Decentralized governance with weighted voting
;; - Automated dividend distribution and claiming
;; - Oracle-based real-time asset pricing
;; - KYC compliance and regulatory framework
;; - Bitcoin-secured settlement layer

;; Constants

;; Administrative
(define-constant contract-owner tx-sender)

;; Error codes
(define-constant err-owner-only (err u100))
(define-constant err-not-found (err u101))
(define-constant err-already-listed (err u102))
(define-constant err-invalid-amount (err u103))
(define-constant err-not-authorized (err u104))
(define-constant err-kyc-required (err u105))
(define-constant err-vote-exists (err u106))
(define-constant err-vote-ended (err u107))
(define-constant err-price-expired (err u108))
(define-constant err-invalid-uri (err u110))
(define-constant err-invalid-value (err u111))
(define-constant err-invalid-duration (err u112))
(define-constant err-invalid-kyc-level (err u113))
(define-constant err-invalid-expiry (err u114))
(define-constant err-invalid-votes (err u115))
(define-constant err-invalid-address (err u116))
(define-constant err-invalid-title (err u117))

;; Configuration limits
(define-constant MAX-ASSET-VALUE u1000000000000) ;; 1 trillion
(define-constant MIN-ASSET-VALUE u1000) ;; 1 thousand
(define-constant MAX-DURATION u144) ;; ~1 day in blocks
(define-constant MIN-DURATION u12) ;; ~1 hour in blocks
(define-constant MAX-KYC-LEVEL u5)
(define-constant MAX-EXPIRY u52560) ;; ~1 year in blocks

;; SFTs per asset
(define-constant tokens-per-asset u100000)

;; Data Maps

;; Asset registry
(define-map assets
  { asset-id: uint }
  {
    owner: principal,
    metadata-uri: (string-ascii 256),
    asset-value: uint,
    is-locked: bool,
    creation-height: uint,
    last-price-update: uint,
    total-dividends: uint,
  }
)

;; Token ownership records
(define-map token-balances
  {
    owner: principal,
    asset-id: uint,
  }
  { balance: uint }
)

;; KYC compliance registry
(define-map kyc-status
  { address: principal }
  {
    is-approved: bool,
    level: uint,
    expiry: uint,
  }
)

;; Governance proposals
(define-map proposals
  { proposal-id: uint }
  {
    title: (string-ascii 256),
    asset-id: uint,
    start-height: uint,
    end-height: uint,
    executed: bool,
    votes-for: uint,
    votes-against: uint,
    minimum-votes: uint,
  }
)