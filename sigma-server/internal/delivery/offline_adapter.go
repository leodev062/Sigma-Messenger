package delivery

// OfflineDeliveryAdapter exposes MessageDeliveryService with optional push suppression.
type OfflineDeliveryAdapter struct {
	inner *MessageDeliveryService
}

func NewOfflineDeliveryAdapter(inner *MessageDeliveryService) *OfflineDeliveryAdapter {
	return &OfflineDeliveryAdapter{inner: inner}
}

func (a *OfflineDeliveryAdapter) Deliver(recipientID, destinationType string, payload []byte, notify bool) error {
	if a == nil || a.inner == nil {
		return nil
	}
	return a.inner.Deliver(recipientID, destinationType, payload, notify)
}
