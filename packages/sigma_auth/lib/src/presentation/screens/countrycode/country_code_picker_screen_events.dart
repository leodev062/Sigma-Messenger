import 'package:sigma_core/sigma_core.dart';

abstract class CountryCodePickerScreenEvents {
  const CountryCodePickerScreenEvents();
}

class Search extends CountryCodePickerScreenEvents {
  final String query;
  const Search(this.query);
}

class PickerCountrySelected extends CountryCodePickerScreenEvents {
  final Country country;
  const PickerCountrySelected(this.country);
}

class Dismissed extends CountryCodePickerScreenEvents {
  const Dismissed();
}
