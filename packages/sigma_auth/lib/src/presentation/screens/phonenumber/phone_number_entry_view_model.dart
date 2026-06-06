import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_auth/sigma_auth.dart';
import 'package:sigma_auth/src/domain/services/phone_number_formatter.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../countrycode/country_utils.dart';

class PhoneNumberEntryViewModel extends EventDrivenViewModel<PhoneNumberEntryScreenEvents, PhoneNumberEntryOneTimeEvent> with Loggable {
  final RequestVerificationInteractor requestVerificationInteractor;
  final Function() onNavigateToCountryPicker;
  final Function(String e164, String sessionId) onNavigateToVerification;

  PhoneNumberEntryState _state = PhoneNumberEntryState();
  PhoneNumberEntryState get state => _state;

  PhoneNumberEntryViewModel({
    required this.requestVerificationInteractor,
    required this.onNavigateToCountryPicker,
    required this.onNavigateToVerification,
  }) : super("PhoneNumberEntryViewModel") {
    _init();
  }

  Future<void> _init() async {
    _setDefaultCountry();
    _tryAutoFill();
  }

  Future<void> _tryAutoFill() async {
    try {
      final phone = await SmsAutoFill().hint;
      if (phone != null && phone.isNotEmpty) {
        onEvent(PhoneNumberAutoFilled(phone));
      }
    } catch (e) {
      logW("AutoFill hint falhou: $e");
    }
  }

  void _setDefaultCountry() {
    _state = _state.copyWith(
      regionCode: "BR",
      countryName: "Brazil",
      countryEmoji: CountryUtils.countryToEmoji("BR"),
      countryCode: "55",
    );
    notifyListeners();
  }

  @override
  Future<void> processEvent(PhoneNumberEntryScreenEvents event) async {
    if (event is CountryCodeChanged) {
      _applyCountryCodeChanged(event.value);
    } else if (event is EntryCountrySelected) {
      _applyCountrySelected(event.country);
    } else if (event is PhoneNumberChanged) {
      _applyPhoneNumberChanged(event.value);
    } else if (event is PhoneNumberAutoFilled) {
      _applyPhoneNumberAutoFilled(event.value);
    } else if (event is PhoneNumberEntered) {
      // Validação antes de abrir o diálogo
      if (PhoneNumberFormatter.isValid(_state.nationalNumber, _state.regionCode)) {
        _state = _state.copyWith(showDialog: true);
      } else {
        emitEffect(PhoneNumberUnknownError()); // TODO: Criar erro específico de validação
      }
    } else if (event is PhoneNumberCancelled) {
      // Fecha o diálogo e reseta o estado
      _state = _state.copyWith(showDialog: false);
    } else if (event is PhoneNumberSubmitted) {
      // Fecha o diálogo e processa
      _state = _state.copyWith(showDialog: false);
      _applyPhoneNumberSubmitted();
    } else if (event is CountryPicker) {
      onNavigateToCountryPicker();
    }
    notifyListeners();
  }

  void _applyCountryCodeChanged(String value) {
    final sanitized = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (sanitized == _state.countryCode) return;
    _state = _state.copyWith(countryCode: sanitized);
  }

  void _applyCountrySelected(Country country) {
    _state = _state.copyWith(
      countryCode: country.phoneCode.toString(),
      regionCode: country.code,
      countryName: country.name,
      countryEmoji: country.flag,
    );
  }

  void _applyPhoneNumberChanged(String value) {
    final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
    // Otimização: Apenas formata se o país for conhecido
    String formatted = value;
    if (_state.regionCode.isNotEmpty) {
      formatted = PhoneNumberFormatter.formatNational(digits, _state.regionCode);
    }
    _state = _state.copyWith(nationalNumber: digits, formattedNumber: formatted);
  }

  void _applyPhoneNumberAutoFilled(String value) {
    // value geralmente vem no formato E164 do sistema (+55119...)
    try {
      final cleaned = value.replaceAll("+", "");
      // Tenta identificar se o DDI bate com o país atual ou se deve mudar
      if (cleaned.startsWith(_state.countryCode)) {
        final national = cleaned.substring(_state.countryCode.length);
        _applyPhoneNumberChanged(national);
      } else {
        // Fallback: Apenas preenche o campo se não soubermos o país
        _state = _state.copyWith(formattedNumber: value, nationalNumber: cleaned);
      }
    } catch (e) {
      _state = _state.copyWith(formattedNumber: value);
    }
  }

  Future<void> _applyPhoneNumberSubmitted() async {
    _state = _state.copyWith(showSpinner: true);
    notifyListeners();

    final e164 = PhoneNumberFormatter.toE164(_state.nationalNumber, _state.countryCode);
    
    final result = await requestVerificationInteractor.execute(e164);
    
    _state = _state.copyWith(showSpinner: false);
    if (result.success && result.sessionId != null) {
      onNavigateToVerification(e164, result.sessionId!);
    } else {
      emitEffect(PhoneNumberNetworkError());
    }
    notifyListeners();
  }
}
