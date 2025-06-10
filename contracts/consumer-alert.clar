;; Consumer Alert Contract
;; Manages allergen alerts and notifications for consumers

(define-constant ERR_UNAUTHORIZED (err u500))
(define-constant ERR_ALERT_NOT_FOUND (err u501))
(define-constant ERR_SUBSCRIPTION_EXISTS (err u502))
(define-constant ERR_INVALID_SEVERITY (err u503))

;; Alert severity levels
(define-constant SEVERITY_LOW u1)
(define-constant SEVERITY_MEDIUM u2)
(define-constant SEVERITY_HIGH u3)
(define-constant SEVERITY_CRITICAL u4)

;; Consumer allergen subscriptions
(define-map consumer-subscriptions
  { consumer: principal }
  {
    allergen-alerts: uint,
    notification-preferences: uint,
    active: bool,
    created-at: uint
  }
)

;; Allergen alerts
(define-map allergen-alerts
  { alert-id: uint }
  {
    product-id: uint,
    allergen-type: uint,
    severity: uint,
    title: (string-ascii 100),
    description: (string-ascii 500),
    issued-by: principal,
    issued-at: uint,
    expires-at: uint,
    active: bool
  }
)

;; Alert acknowledgments
(define-map alert-acknowledgments
  { consumer: principal, alert-id: uint }
  {
    acknowledged-at: uint,
    action-taken: (string-ascii 100)
  }
)

(define-data-var next-alert-id uint u1)

;; Subscribe to allergen alerts
(define-public (subscribe-to-alerts (allergen-flags uint) (notification-preferences uint))
  (begin
    (map-set consumer-subscriptions
      { consumer: tx-sender }
      {
        allergen-alerts: allergen-flags,
        notification-preferences: notification-preferences,
        active: true,
        created-at: block-height
      }
    )
    (ok true)
  )
)

;; Update subscription preferences
(define-public (update-subscription (allergen-flags uint) (notification-preferences uint))
  (match (map-get? consumer-subscriptions { consumer: tx-sender })
    subscription-data
    (begin
      (map-set consumer-subscriptions
        { consumer: tx-sender }
        (merge subscription-data {
          allergen-alerts: allergen-flags,
          notification-preferences: notification-preferences
        })
      )
      (ok true)
    )
    (err u404)
  )
)

;; Issue allergen alert
(define-public (issue-alert
  (product-id uint)
  (allergen-type uint)
  (severity uint)
  (title (string-ascii 100))
  (description (string-ascii 500))
  (expires-at uint)
)
  (let ((alert-id (var-get next-alert-id)))
    (asserts! (<= severity SEVERITY_CRITICAL) ERR_INVALID_SEVERITY)
    (map-set allergen-alerts
      { alert-id: alert-id }
      {
        product-id: product-id,
        allergen-type: allergen-type,
        severity: severity,
        title: title,
        description: description,
        issued-by: tx-sender,
        issued-at: block-height,
        expires-at: expires-at,
        active: true
      }
    )
    (var-set next-alert-id (+ alert-id u1))
    (ok alert-id)
  )
)

;; Acknowledge alert
(define-public (acknowledge-alert (alert-id uint) (action-taken (string-ascii 100)))
  (begin
    (asserts! (is-some (map-get? allergen-alerts { alert-id: alert-id })) ERR_ALERT_NOT_FOUND)
    (map-set alert-acknowledgments
      { consumer: tx-sender, alert-id: alert-id }
      {
        acknowledged-at: block-height,
        action-taken: action-taken
      }
    )
    (ok true)
  )
)

;; Get consumer subscription
(define-read-only (get-consumer-subscription (consumer principal))
  (map-get? consumer-subscriptions { consumer: consumer })
)

;; Get alert details
(define-read-only (get-alert (alert-id uint))
  (map-get? allergen-alerts { alert-id: alert-id })
)

;; Check if consumer should receive alert
(define-read-only (should-receive-alert (consumer principal) (allergen-type uint))
  (match (map-get? consumer-subscriptions { consumer: consumer })
    subscription-data
    (and
      (get active subscription-data)
      (> (bit-and (get allergen-alerts subscription-data) allergen-type) u0)
    )
    false
  )
)

;; Get active alerts for allergen type
(define-read-only (get-active-alerts-count (allergen-type uint))
  ;; Simplified implementation - would need iteration in full version
  u0
)

;; Deactivate expired alerts (admin function)
(define-public (deactivate-expired-alert (alert-id uint))
  (match (map-get? allergen-alerts { alert-id: alert-id })
    alert-data
    (if (>= block-height (get expires-at alert-data))
      (begin
        (map-set allergen-alerts
          { alert-id: alert-id }
          (merge alert-data { active: false })
        )
        (ok true)
      )
      (err u600)
    )
    ERR_ALERT_NOT_FOUND
  )
)
