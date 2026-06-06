import 'package:sigma_core/sigma_core.dart';

class CountryCodeState {
  final String query;
  final List<Country> countryList;
  final List<Country> commonCountryList;
  final List<Country> filteredList;
  final int startingIndex;

  CountryCodeState({
    this.query = "",
    this.countryList = const [],
    this.commonCountryList = const [],
    this.filteredList = const [],
    this.startingIndex = 0,
  });

  CountryCodeState copyWith({
    String? query,
    List<Country>? countryList,
    List<Country>? commonCountryList,
    List<Country>? filteredList,
    int? startingIndex,
  }) {
    return CountryCodeState(
      query: query ?? this.query,
      countryList: countryList ?? this.countryList,
      commonCountryList: commonCountryList ?? this.commonCountryList,
      filteredList: filteredList ?? this.filteredList,
      startingIndex: startingIndex ?? this.startingIndex,
    );
  }
}
