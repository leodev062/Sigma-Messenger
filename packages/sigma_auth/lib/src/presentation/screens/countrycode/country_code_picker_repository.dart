import 'package:sigma_core/sigma_core.dart';

class CountryCodePickerRepository {
  Future<List<Country>> getCountries() async {
    return manualCountries;
  }

  Future<List<Country>> getCommonCountries() async {
    return manualCountries.where((c) => c.code == 'BR').toList();
  }
}
