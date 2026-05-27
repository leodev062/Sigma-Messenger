import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigma/features/auth/presentation/viewmodels/auth_viewmodel.dart';

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
      // Se DisplayName for o telefone (padrão do servidor), deixa vazio
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
        const SnackBar(content: Text('Por favor, preencha o seu nome e um nome de utilizador.')),
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

    const peachColor = Color(0xFFF7D8D0);
    const peachTextColor = Color(0xFF8A7A77);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Configure seu\nPerfil .',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Como os seus amigos devem ver você no Sigma?',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black38,
                ),
              ),
              
              const SizedBox(height: 48),

              // Avatar Placeholder
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: peachColor,
                      backgroundImage: _avatarUrl != null ? NetworkImage(_avatarUrl!) : null,
                      child: _avatarUrl == null 
                        ? const Icon(Icons.person, size: 60, color: peachTextColor)
                        : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 48),

              // Campo Nome
              const Text('NOME COMPLETO', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black26)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: peachColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: _nameController,
                  style: const TextStyle(fontSize: 18, color: peachTextColor, fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                    hintText: 'Seu Nome',
                    border: InputBorder.none,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Campo Username
              const Text('NOME DE UTILIZADOR', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black26)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: peachColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Text('@', style: TextStyle(fontSize: 18, color: peachTextColor, fontWeight: FontWeight.bold)),
                    Expanded(
                      child: TextField(
                        controller: _usernameController,
                        style: const TextStyle(fontSize: 18, color: peachTextColor, fontWeight: FontWeight.bold),
                        decoration: const InputDecoration(
                          hintText: 'username',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 48),

              if (state.status == AuthStatus.loading)
                const Center(child: CircularProgressIndicator())
              else ...[
                if (state.status == AuthStatus.error)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: Text(
                      state.error ?? 'Erro ao salvar perfil',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: _onContinue,
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'CONCLUIR',
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
