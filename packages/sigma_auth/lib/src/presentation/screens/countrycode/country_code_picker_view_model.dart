import 'package:sigma_core/sigma_core.dart';
import '../../../../sigma_auth.dart';
import 'country_code_picker_repository.dart';

class CountryCodePickerViewModel extends EventDrivenViewModel<CountryCodePickerScreenEvents, void> {
  final CountryCodePickerRepository repository;
  final Function(Country?) onResult;

  CountryCodeState _state = CountryCodeState();
  CountryCodeState get state => _state;

  CountryCodePickerViewModel({
    required this.repository,
    required this.onResult,
    Country? initialCountry,
  }) : super("CountryCodePickerViewModel") {
    _loadCountries(initialCountry);
  }

  @override
  Future<void> processEvent(CountryCodePickerScreenEvents event) async {
    if (event is Search) {
      _applySearchEvent(event.query);
    } else if (event is PickerCountrySelected) {
      onResult(event.country);
    } else if (event is Dismissed) {
      onResult(null);
    }
  }

  void _applySearchEvent(String filterBy) {
    if (filterBy.isEmpty) {
      _state = _state.copyWith(query: filterBy, filteredList: []);
    } else {
      final query = filterBy.toLowerCase();
      final filtered = _state.countryList.where((country) {
        return country.name.toLowerCase().contains(query) ||
            country.phoneCode.toString().contains(query.replaceAll("+", ""));
      }).toList();
      _state = _state.copyWith(query: filterBy, filteredList: filtered);
    }
    notifyListeners();
  }

  Future<void> _loadCountries(Country? initialCountry) async {
    final countryList = await repository.getCountries();
    final commonCountryList = await repository.getCommonCountries();
    
    int startingIndex = 0;
    if (initialCountry != null) {
      final idxCommon = commonCountryList.indexOf(initialCountry);
      if (idxCommon != -1) {
        startingIndex = idxCommon;
      } else {
        final idxAll = countryList.indexOf(initialCountry);
        if (idxAll != -1) {
          startingIndex = idxAll + (commonCountryList.isNotEmpty ? commonCountryList.length + 1 : 0);
        }
      }
    }

    _state = _state.copyWith(
      countryList: countryList,
      commonCountryList: commonCountryList,
      startingIndex: startingIndex,
    );
    notifyListeners();
  }
}
