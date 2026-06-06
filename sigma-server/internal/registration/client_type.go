package registration

import (
	"encoding/json"
)

type ClientType int

const (
	ClientTypeUnknown ClientType = iota
	ClientTypeIOS
	ClientTypeAndroidWithFCM
	ClientTypeAndroidWithoutFCM
)

func (c ClientType) String() string {
	switch c {
	case ClientTypeIOS:
		return "IOS"
	case ClientTypeAndroidWithFCM:
		return "ANDROID_WITH_FCM"
	case ClientTypeAndroidWithoutFCM:
		return "ANDROID_WITHOUT_FCM"
	default:
		return "UNKNOWN"
	}
}

func (c ClientType) MarshalJSON() ([]byte, error) {
	return json.Marshal(c.String())
}

func (c *ClientType) UnmarshalJSON(data []byte) error {
	var s string
	if err := json.Unmarshal(data, &s); err != nil {
		return err
	}

	switch s {
	case "IOS":
		*c = ClientTypeIOS
	case "ANDROID_WITH_FCM":
		*c = ClientTypeAndroidWithFCM
	case "ANDROID_WITHOUT_FCM":
		*c = ClientTypeAndroidWithoutFCM
	default:
		*c = ClientTypeUnknown
	}
	return nil
}
