import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:sigma/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:sigma/data/models/country.dart';
import 'package:sigma/core/i18n/strings.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController(text: '+55');
  
  Country _selectedCountry = manualCountries.first; // Brasil

  void _onCountrySelected(Country country) {
    setState(() {
      _selectedCountry = country;
      _codeController.text = '+${country.phoneCode}';
    });
  }

  void _showCountryPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return _CountryPickerSheet(
          onSelected: _onCountrySelected,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
    final state = authViewModel.state;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    if (state.status == AuthStatus.success) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        authViewModel.resetState();
        context.push('/verification', extra: '${_codeController.text}${_phoneController.text}');
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onBackground),
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
              Text(
                context.translate('login_title'),
                style: textTheme.headlineLarge?.copyWith(color: colorScheme.onBackground),
              ),
              const SizedBox(height: 24),
              Text(
                context.translate('login_subtitle'),
                style: textTheme.bodyMedium?.copyWith(color: colorScheme.onBackground.withOpacity(0.6)),
              ),
              const SizedBox(height: 48),
              
              InkWell(
                onTap: _showCountryPicker,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    color: theme.inputDecorationTheme.fillColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Text(_selectedCountry.flag, style: const TextStyle(fontSize: 24)),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          _selectedCountry.name,
                          style: TextStyle(
                            fontSize: 18,
                            color: colorScheme.onBackground,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down, color: colorScheme.onBackground.withOpacity(0.5)),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 12),
              
              Row(
                children: [
                  Container(
                    width: 85,
                    decoration: BoxDecoration(
                      color: theme.inputDecorationTheme.fillColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _codeController,
                      keyboardType: TextInputType.phone,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: colorScheme.onBackground,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      onChanged: (value) {
                        if (!value.startsWith('+')) {
                          _codeController.text = '+$value';
                          _codeController.selection = TextSelection.fromPosition(
                            TextPosition(offset: _codeController.text.length),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.inputDecorationTheme.fillColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                          fontSize: 18,
                          color: colorScheme.onBackground,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          hintText: '00 00000-0000',
                          hintStyle: TextStyle(color: colorScheme.onBackground.withOpacity(0.2)),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 48),
              
              if (state.status == AuthStatus.loading)
                Center(child: CircularProgressIndicator(color: colorScheme.primary))
              else ...[
                if (state.status == AuthStatus.error)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: Text(
                      state.error ?? context.translate('error_generic'),
                      style: TextStyle(color: colorScheme.error),
                    ),
                  ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      final fullPhone = '${_codeController.text}${_phoneController.text}';
                      authViewModel.requestCode(fullPhone);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      context.translate('btn_send_code'),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onPrimary,
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

class _CountryPickerSheet extends StatefulWidget {
  final Function(Country) onSelected;
  const _CountryPickerSheet({required this.onSelected});

  @override
  State<_CountryPickerSheet> createState() => _CountryPickerSheetState();
}

class _CountryPickerSheetState extends State<_CountryPickerSheet> {
  String _searchQuery = '';
  
  @override
  Widget build(BuildContext context) {
    final filteredCountries = manualCountries.where((c) => 
      c.name.toLowerCase().contains(_searchQuery.toLowerCase()) || 
      c.phoneCode.contains(_searchQuery)
    ).toList();

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      maxChildSize: 0.9,
      minChildSize: 0.5,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Text(
                context.translate('select_country'),
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  hintText: context.translate('search_country_hint'),
                  prefixIcon: const Icon(Icons.search),
                  fillColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.05),
                ),
                onChanged: (value) => setState(() => _searchQuery = value),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: filteredCountries.length,
                  itemBuilder: (context, index) {
                    final country = filteredCountries[index];
                    return ListTile(
                      leading: Text(country.flag, style: const TextStyle(fontSize: 24)),
                      title: Text(country.name),
                      trailing: Text('+${country.phoneCode}'),
                      onTap: () {
                        widget.onSelected(country);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
