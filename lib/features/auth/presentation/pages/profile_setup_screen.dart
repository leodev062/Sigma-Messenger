import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigma/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:sigma/core/i18n/strings.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  String? _avatarUrl;

  @override
  void initState() {
    super.initState();
    final user = context.read<AuthViewModel>().state.user;
    if (user != null) {
      _nameController.text = (user.name == user.phone) ? '' : (user.name ?? '');
      _usernameController.text = user.username ?? '';
      _avatarUrl = user.avatarUrl;
    }
  }

  void _onContinue() {
    final name = _nameController.text.trim();
    final username = _usernameController.text.trim();

    if (name.isEmpty || username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.translate('profile_setup_empty_error'))),
      );
      return;
    }

    context.read<AuthViewModel>().updateProfile(
      name: name,
      username: username,
      avatarUrl: _avatarUrl,
    );
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
    final state = authViewModel.state;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                context.translate('profile_setup_title'),
                style: textTheme.headlineLarge?.copyWith(color: colorScheme.onBackground),
              ),
              const SizedBox(height: 12),
              Text(
                context.translate('profile_setup_subtitle'),
                style: textTheme.bodyMedium?.copyWith(color: colorScheme.onBackground.withOpacity(0.6)),
              ),
              
              const SizedBox(height: 48),

              // Avatar Placeholder
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: colorScheme.primaryContainer,
                      backgroundImage: _avatarUrl != null ? NetworkImage(_avatarUrl!) : null,
                      child: _avatarUrl == null 
                        ? Icon(Icons.person, size: 60, color: colorScheme.onPrimaryContainer)
                        : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.camera_alt, color: colorScheme.onPrimary, size: 20),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 48),

              // Campo Nome com Floating Label moderno
              TextField(
                controller: _nameController,
                style: TextStyle(fontSize: 18, color: colorScheme.onBackground, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  labelText: context.translate('full_name_label'),
                  labelStyle: TextStyle(color: colorScheme.onBackground.withOpacity(0.5), fontWeight: FontWeight.normal),
                  floatingLabelStyle: TextStyle(color: colorScheme.primary, fontWeight: FontWeight.bold),
                  filled: true,
                  fillColor: theme.inputDecorationTheme.fillColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                ),
              ),

              const SizedBox(height: 24),

              // Campo Username com Floating Label moderno e prefixo
              TextField(
                controller: _usernameController,
                style: TextStyle(fontSize: 18, color: colorScheme.onBackground, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  labelText: context.translate('username_label'),
                  labelStyle: TextStyle(color: colorScheme.onBackground.withOpacity(0.5), fontWeight: FontWeight.normal),
                  floatingLabelStyle: TextStyle(color: colorScheme.primary, fontWeight: FontWeight.bold),
                  prefixText: '@ ',
                  prefixStyle: TextStyle(fontSize: 18, color: colorScheme.onBackground, fontWeight: FontWeight.bold),
                  filled: true,
                  fillColor: theme.inputDecorationTheme.fillColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                ),
              ),

              const SizedBox(height: 48),

              if (state.status == AuthStatus.loading)
                Center(child: CircularProgressIndicator(color: colorScheme.primary))
              else ...[
                if (state.status == AuthStatus.error)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: Text(
                      state.error ?? context.translate('profile_setup_save_error'),
                      style: TextStyle(color: colorScheme.error),
                    ),
                  ),
                
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: _onContinue,
                    style: TextButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      context.translate('btn_finish'),
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
