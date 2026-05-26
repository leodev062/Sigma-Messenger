import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:sigma/features/auth/presentation/viewmodels/auth_viewmodel.dart';

class VerificationScreen extends StatefulWidget {
  final String phoneNumber;
  const VerificationScreen({super.key, required this.phoneNumber});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final TextEditingController _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
    final state = authViewModel.state;

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
                'Código de\nAcesso .',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Digite o código de 6 dígitos que enviamos para ${widget.phoneNumber}.',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black38,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 48),
              
              // Campo de Código
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 30),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7D8D0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: TextField(
                    controller: _codeController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 6,
                    autofocus: true,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8A7A77),
                      letterSpacing: 12,
                    ),
                    decoration: const InputDecoration(
                      counterText: '',
                      hintText: '000000',
                      hintStyle: TextStyle(
                        color: Color(0xFFC5B8B5),
                        letterSpacing: 12,
                      ),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      if (value.length == 6) {
                        authViewModel.verifyCode(value);
                      }
                    },
                  ),
                ),
              ),
              
              const SizedBox(height: 48),
              
              if (state.status == AuthStatus.loggingIn)
                const Center(child: CircularProgressIndicator())
              else ...[
                if (state.status == AuthStatus.error)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: Text(
                        state.errorMessage ?? 'Código inválido',
                        style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                
                Center(
                  child: TextButton(
                    onPressed: state.status == AuthStatus.loggingIn 
                        ? null 
                        : () {
                          // authViewModel.requestCode(widget.phoneNumber);
                        },
                    child: const Text(
                      'Reenviar código SMS',
                      style: TextStyle(
                        color: Colors.black26,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
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
