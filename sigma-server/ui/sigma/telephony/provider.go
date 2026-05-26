package telephony

type TelephonyProvider interface {
	SendMessage(number, text string) error
}
