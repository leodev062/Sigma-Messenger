import 'package:sigma_core/sigma_core.dart';

abstract class PhoneNumberEntryScreenEvents {
  const PhoneNumberEntryScreenEvents();
}

class CountryCodeChanged extends PhoneNumberEntryScreenEvents {
  final String value;
  const CountryCodeChanged(this.value);
}

class EntryCountrySelected extends PhoneNumberEntryScreenEvents {
  final Country country;
  const EntryCountrySelected(this.country);
}

class PhoneNumberChanged extends PhoneNumberEntryScreenEvents {
  final String value;
  const PhoneNumberChanged(this.value);
}

class PhoneNumberEntered extends PhoneNumberEntryScreenEvents {
  const PhoneNumberEntered();
}

class PhoneNumberSubmitted extends PhoneNumberEntryScreenEvents {
  const PhoneNumberSubmitted();
}

class PhoneNumberCancelled extends PhoneNumberEntryScreenEvents {
  const PhoneNumberCancelled();
}

class CountryPicker extends PhoneNumberEntryScreenEvents {
  const CountryPicker();
}

class PhoneNumberAutoFilled extends PhoneNumberEntryScreenEvents {
  final String value;
  PhoneNumberAutoFilled(this.value);
}
