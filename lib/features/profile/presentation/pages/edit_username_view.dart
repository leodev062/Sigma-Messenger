import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigma/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:sigma/core/i18n/strings.dart';

class EditUsernameView extends StatefulWidget {
  const EditUsernameView({super.key});

  @override
  State<EditUsernameView> createState() => _EditUsernameViewState();
}

class _EditUsernameViewState extends State<EditUsernameView> {
  late TextEditingController _controller;
  Timer? _debounce;
  bool _isChecking = false;
  bool? _isAvailable;
  String? _lastChecked;

  @override
  void initState() {
    super.initState();
    final user = context.read<AuthViewModel>().state.user;
    _controller = TextEditingController(text: user?.username ?? '');
    _lastChecked = _controller.text.trim();
    // Não adicionamos o listener imediatamente para evitar validação no initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.addListener(_onUsernameChanged);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onUsernameChanged() {
    final text = _controller.text.trim();
    final currentUser = context.read<AuthViewModel>().state.user;
    
    if (text == _lastChecked) return;

    if (_debounce?.isActive ?? false) _debounce!.cancel();
    
    if (text.isEmpty || text == currentUser?.username) {
      setState(() {
        _isAvailable = null;
        _isChecking = false;
        _lastChecked = text;
      });
      return;
    }

    if (text.length < 3) {
      setState(() {
        _isAvailable = null;
        _isChecking = false;
      });
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      setState(() {
        _isChecking = true;
        _isAvailable = null;
      });

      final available = await context.read<AuthViewModel>().isUsernameAvailable(text);
      
      if (mounted && text == _controller.text.trim()) {
        setState(() {
          _isAvailable = available;
          _isChecking = false;
          _lastChecked = text;
        });
      }
    });
  }

  Future<void> _save() async {
    final authViewModel = context.read<AuthViewModel>();
    final newUsername = _controller.text.trim();

    if (newUsername.isEmpty || _isAvailable == false) return;

    try {
      await authViewModel.updateProfile(
        username: newUsername,
      );
      if (mounted) Navigator.pop(context);
    } catch (e) {
      // Erro tratado pelo ViewModel
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final authViewModel = context.watch<AuthViewModel>();
    final currentUsername = authViewModel.state.user?.username;
    final text = _controller.text.trim();

    return Scaffold(
      appBar: AppBar(
        title: Text(context.translate('username')),
        actions: [
          if (authViewModel.isLoading)
            const Center(child: Padding(padding: EdgeInsets.all(16.0), child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))))
          else
            TextButton(
              onPressed: (text.isNotEmpty && text != currentUsername && _isAvailable == true) ? _save : null,
              child: Text(
                context.translate('btn_finish'),
                style: TextStyle(
                  color: (text.isNotEmpty && text != currentUsername && _isAvailable == true) ? colorScheme.primary : Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              autofocus: true,
              style: const TextStyle(fontSize: 18),
              decoration: InputDecoration(
                prefixText: '@ ',
                prefixStyle: TextStyle(color: colorScheme.onSurface, fontSize: 18),
                hintText: 'username',
                suffixIcon: _isChecking 
                  ? const SizedBox(width: 20, height: 20, child: Center(child: CircularProgressIndicator(strokeWidth: 2)))
                  : (text.isNotEmpty && text != currentUsername && _isAvailable != null)
                    ? Icon(
                        _isAvailable == true ? Icons.check_circle : Icons.error, 
                        color: _isAvailable == true ? Colors.green : Colors.red
                      )
                    : null,
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: colorScheme.primary),
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (text.isNotEmpty && text != currentUsername) ...[
              if (_isAvailable == false)
                Text(
                  context.translate('username_taken'),
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                )
              else if (_isAvailable == true)
                Text(
                  context.translate('username_available'),
                  style: const TextStyle(color: Colors.green, fontSize: 12),
                ),
            ],
            const SizedBox(height: 16),
            Text(
              context.translate('username_hint'),
              style: TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.6), fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
