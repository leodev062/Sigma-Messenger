import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:country_picker/country_picker.dart';
import 'package:sigma/features/auth/presentation/viewmodels/auth_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController(text: '55');
  
  Country? _selectedCountry = CountryService().findByCode('BR');

  void _onCountrySelected(Country country) {
    setState(() {
      _selectedCountry = country;
      _codeController.text = country.phoneCode;
    });
  }

  void _onCodeChanged(String code) {
    final country = CountryService().findByPhoneCode(code);
    if (country != null && country != _selectedCountry) {
      setState(() {
        _selectedCountry = country;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
    final state = authViewModel.state;

    if (state.status == AuthStatus.codeSent) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.push('/verification', extra: '+${_codeController.text}${_phoneController.text}');
      });
    }

    const peachColor = Color(0xFFF7D8D0);
    const peachTextColor = Color(0xFF8A7A77);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Número de\nTelefone .',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Insira o número do seu celular para receber um código de acesso.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black38,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 48),
              
              InkWell(
                onTap: () => showCountryPicker(
                  context: context,
                  showPhoneCode: true,
                  onSelect: _onCountrySelected,
                  countryListTheme: CountryListThemeData(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    color: peachColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Text(_selectedCountry?.flagEmoji ?? '🇧🇷', style: const TextStyle(fontSize: 24)),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          _selectedCountry?.name ?? 'Brasil',
                          style: const TextStyle(
                            fontSize: 18,
                            color: peachTextColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_down, color: peachTextColor),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 12),
              
              Row(
                children: [
                  Container(
                    width: 85,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: peachColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _codeController,
                      keyboardType: TextInputType.number,
                      onChanged: _onCodeChanged,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        color: peachTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      decoration: BoxDecoration(
                        color: peachColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(
                          fontSize: 18,
                          color: peachTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: const InputDecoration(
                          hintText: '00 00000-0000',
                          hintStyle: TextStyle(color: Color(0xFFC5B8B5)),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 48),
              
              if (state.status == AuthStatus.requestingCode)
                const Center(child: CircularProgressIndicator())
              else ...[
                if (state.status == AuthStatus.error)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: Text(
                      state.errorMessage ?? 'Ocorreu um erro',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      final fullPhone = '+${_codeController.text}${_phoneController.text}';
                      authViewModel.requestCode(fullPhone);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'ENVIAR CÓDIGO',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF38B6FF),
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
