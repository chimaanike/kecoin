;; title: kecoin
;; version: 1.0.0
;; summary: Simple fungible token for the kecoin project
;; description: \"kecoin\" is a basic fungible token implemented in Clarity for use in local development and examples.

;; -----------------------------------------------------------------------------
;; token definitions
;; -----------------------------------------------------------------------------

(define-fungible-token kecoin)

;; -----------------------------------------------------------------------------
;; constants
;; -----------------------------------------------------------------------------

;; In this simple example we do not enforce a special contract owner; any
;; principal may call `mint` for local development and testing purposes.

;; -----------------------------------------------------------------------------
;; data vars
;; -----------------------------------------------------------------------------

;; Track total supply minted through this contract
(define-data-var total-supply uint u0)

;; -----------------------------------------------------------------------------
;; read-only functions
;; -----------------------------------------------------------------------------

(define-read-only (get-name)
  (ok "kecoin"))

(define-read-only (get-symbol)
  (ok "KEC"))

(define-read-only (get-decimals)
  ;; Example: 6 decimal places
  (ok u6))

(define-read-only (get-balance-of (owner principal))
  (ok (ft-get-balance kecoin owner)))

(define-read-only (get-total-supply)
  (ok (var-get total-supply)))

;; -----------------------------------------------------------------------------
;; public functions
;; -----------------------------------------------------------------------------

;; Mint new kecoin to a recipient.
;; NOTE: For simplicity in this example, any caller may mint tokens.
(define-public (mint (amount uint) (recipient principal))
  (match (ft-mint? kecoin amount recipient)
    success
      (begin
        (var-set total-supply (+ (var-get total-supply) amount))
        (ok success))
    error-code
      (err error-code)))

;; Transfer kecoin from the caller (tx-sender) to a recipient.
(define-public (transfer (amount uint) (recipient principal))
  (match (ft-transfer? kecoin amount tx-sender recipient)
    success (ok success)
    error-code (err error-code)))
