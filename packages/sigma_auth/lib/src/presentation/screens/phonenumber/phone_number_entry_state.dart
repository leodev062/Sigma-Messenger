class PhoneNumberEntryState {
  final String countryName;
  final String countryEmoji;
  final String countryCode;
  final String regionCode;
  final String nationalNumber;
  final String formattedNumber;
  final bool showSpinner;
  final bool showDialog;
  final PhoneNumberEntryOneTimeEvent? oneTimeEvent;

  PhoneNumberEntryState({
    this.countryName = "",
    this.countryEmoji = "",
    this.countryCode = "",
    this.regionCode = "",
    this.nationalNumber = "",
    this.formattedNumber = "",
    this.showSpinner = false,
    this.showDialog = false,
    this.oneTimeEvent,
  });

  bool get isNumberPossible => nationalNumber.length >= 7;

  PhoneNumberEntryState copyWith({
    String? countryName,
    String? countryEmoji,
    String? countryCode,
    String? regionCode,
    String? nationalNumber,
    String? formattedNumber,
    bool? showSpinner,
    bool? showDialog,
    PhoneNumberEntryOneTimeEvent? oneTimeEvent,
  }) {
    return PhoneNumberEntryState(
      countryName: countryName ?? this.countryName,
      countryEmoji: countryEmoji ?? this.countryEmoji,
      countryCode: countryCode ?? this.countryCode,
      regionCode: regionCode ?? this.regionCode,
      nationalNumber: nationalNumber ?? this.nationalNumber,
      formattedNumber: formattedNumber ?? this.formattedNumber,
      showSpinner: showSpinner ?? this.showSpinner,
      showDialog: showDialog ?? this.showDialog,
      oneTimeEvent: oneTimeEvent ?? this.oneTimeEvent,
    );
  }
}

abstract class PhoneNumberEntryOneTimeEvent {}

class PhoneNumberNetworkError extends PhoneNumberEntryOneTimeEvent {}
class PhoneNumberUnknownError extends PhoneNumberEntryOneTimeEvent {}
class PhoneNumberRateLimited extends PhoneNumberEntryOneTimeEvent {
  final int retryAfter;
  PhoneNumberRateLimited(this.retryAfter);
}

class CouldNotRequestCodeWithSelectedTransport extends PhoneNumberEntryOneTimeEvent {}
class UnableToSendSms extends PhoneNumberEntryOneTimeEvent {}
