import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigma_auth/sigma_auth.dart';
import 'package:sigma_core/sigma_core.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  String? _avatarUrl;
  bool _fieldsInitialized = false;

  void _syncFieldsFromAuth(AuthState authState) {
    if (_fieldsInitialized) return;

    final user = authState.user;
    if (user == null) return;

    final displayName = user.profileName?.trim() ?? '';
    final phone = user.phone?.trim() ?? '';
    final nameLooksLikePhone = displayName.isNotEmpty && displayName == phone;

    _nameController.text = nameLooksLikePhone ? '' : displayName;
    _usernameController.text = user.username?.trim() ?? '';
    _avatarUrl = user.avatarUrl;
    _fieldsInitialized = true;
  }

  Future<void> _onContinue() async {
    final authViewModel = context.read<AuthViewModel>();
    final name = _nameController.text.trim();
    final username = _usernameController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.translate('profile_setup_empty_error'))),
      );
      return;
    }

    if (authViewModel.state.isNewRegistration && username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.translate('username_label'))),
      );
      return;
    }

    await authViewModel.completeProfileSetup(
      name: name,
      username: username.isEmpty ? null : username.replaceFirst(RegExp(r'^@+'), ''),
      avatarUrl: _avatarUrl,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
    final state = authViewModel.state;
    _syncFieldsFromAuth(state);

    final layoutParams = RegistrationScaffold.rememberLayoutParams(context);

    if (layoutParams is OnePaneParams) {
      return _OnePaneLayout(
        params: layoutParams,
        state: state,
        isNewRegistration: state.isNewRegistration,
        nameController: _nameController,
        usernameController: _usernameController,
        avatarUrl: _avatarUrl,
        onContinue: _onContinue,
      );
    } else if (layoutParams is TwoPaneParams) {
      return _TwoPaneLayout(
        params: layoutParams,
        state: state,
        isNewRegistration: state.isNewRegistration,
        nameController: _nameController,
        usernameController: _usernameController,
        avatarUrl: _avatarUrl,
        onContinue: _onContinue,
      );
    }
    return const SizedBox.shrink();
  }
}

class _OnePaneLayout extends StatelessWidget {
  final OnePaneParams params;
  final AuthState state;
  final bool isNewRegistration;
  final TextEditingController nameController;
  final TextEditingController usernameController;
  final String? avatarUrl;
  final VoidCallback onContinue;

  const _OnePaneLayout({
    required this.params,
    required this.state,
    required this.isNewRegistration,
    required this.nameController,
    required this.usernameController,
    this.avatarUrl,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return OnePaneRegistrationScaffold(
      params: params,
      contentBuilder: (context, padding) => SingleChildScrollView(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Headline(isNewRegistration: isNewRegistration),
            const SizedBox(height: 24),
            _SubDescription(isNewRegistration: isNewRegistration),
            const SizedBox(height: 48),
            _Avatar(avatarUrl: avatarUrl),
            const SizedBox(height: 48),
            _InputFields(nameController: nameController, usernameController: usernameController),
          ],
        ),
      ),
      footer: _Footer(params: params, state: state, onContinue: onContinue),
    );
  }
}

class _TwoPaneLayout extends StatelessWidget {
  final TwoPaneParams params;
  final AuthState state;
  final bool isNewRegistration;
  final TextEditingController nameController;
  final TextEditingController usernameController;
  final String? avatarUrl;
  final VoidCallback onContinue;

  const _TwoPaneLayout({
    required this.params,
    required this.state,
    required this.isNewRegistration,
    required this.nameController,
    required this.usernameController,
    this.avatarUrl,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return TwoPaneRegistrationScaffold(
      params: params,
      firstPaneBuilder: (context, padding) => Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _Headline(isNewRegistration: isNewRegistration),
            const SizedBox(height: 24),
            _SubDescription(isNewRegistration: isNewRegistration),
            const SizedBox(height: 48),
            Center(child: _Avatar(avatarUrl: avatarUrl)),
          ],
        ),
      ),
      secondPaneBuilder: (context, padding) => Padding(
        padding: padding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _InputFields(nameController: nameController, usernameController: usernameController),
          ],
        ),
      ),
      footer: _Footer(params: params, state: state, onContinue: onContinue),
    );
  }
}

class _Headline extends StatelessWidget {
  final bool isNewRegistration;

  const _Headline({required this.isNewRegistration});

  @override
  Widget build(BuildContext context) {
    return Text(
      context.translate('CreateProfileActivity_set_up_your_profile'),
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}

class _SubDescription extends StatelessWidget {
  final bool isNewRegistration;

  const _SubDescription({required this.isNewRegistration});

  @override
  Widget build(BuildContext context) {
    return Text(
      context.translate('CreateProfileActivity_signal_profiles_are_end_to_end_encrypted'),
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String? avatarUrl;
  const _Avatar({this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: colorScheme.surfaceContainerHighest,
            backgroundImage: avatarUrl != null && avatarUrl!.isNotEmpty ? NetworkImage(avatarUrl!) : null,
            child: avatarUrl == null || avatarUrl!.isEmpty
                ? Icon(Icons.person, size: 60, color: colorScheme.onSurfaceVariant)
                : null,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: colorScheme.primary, shape: BoxShape.circle),
              child: Icon(Icons.camera_alt, color: colorScheme.onPrimary, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class _InputFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController usernameController;

  const _InputFields({required this.nameController, required this.usernameController});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        TextField(
          controller: nameController,
          style: const TextStyle(fontSize: 18),
          decoration: InputDecoration(
            labelText: context.translate('full_name_label'),
            border: const UnderlineInputBorder(),
            filled: true,
            fillColor: colorScheme.surfaceContainerHighest,
          ),
        ),
        const SizedBox(height: 24),
        TextField(
          controller: usernameController,
          style: const TextStyle(fontSize: 18),
          decoration: InputDecoration(
            labelText: context.translate('username_label'),
            prefixText: '@ ',
            border: const UnderlineInputBorder(),
            filled: true,
            fillColor: colorScheme.surfaceContainerHighest,
          ),
        ),
      ],
    );
  }
}

class _Footer extends StatelessWidget {
  final RegistrationScaffoldParams params;
  final AuthState state;
  final VoidCallback onContinue;

  const _Footer({required this.params, required this.state, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: params.footerPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (state.status == AuthStatus.loading)
            const Center(child: CircularProgressIndicator())
          else ...[
            if (state.error != null && state.error!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(state.error!, style: TextStyle(color: colorScheme.error)),
              ),
            SizedBox(
              height: 56,
              child: FilledButton.tonal(
                onPressed: onContinue,
                child: Text(context.translate('btn_finish')),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
