import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigma/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:sigma/core/i18n/strings.dart';
import 'package:sigma/core/widgets/sigma_avatar.dart';
import 'edit_username_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
    final user = authViewModel.state.user;
    final colorScheme = Theme.of(context).colorScheme;

    if (user == null) return const Center(child: Text('User not found'));

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 32),
          Center(
            child: SigmaAvatar(
              avatarUrl: user.avatarUrl,
              name: user.name ?? user.username,
              radius: 50,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(context.translate('not_available'))),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
              foregroundColor: colorScheme.onSurface,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            child: Text(context.translate('edit_photo')),
          ),
          const SizedBox(height: 32),
          
          _buildProfileItem(
            icon: Icons.person_outline,
            title: user.name ?? context.translate('name'),
            onTap: () => _showNameEditBottomSheet(context, user.name ?? ''),
          ),
          _buildProfileItem(
            icon: Icons.emoji_emotions_outlined,
            title: context.translate('about'),
            subtitle: user.bio ?? context.translate('available'),
            onTap: () => _showBioBottomSheet(context, user.bio ?? ''),
          ),
          _buildProfileItem(
            icon: Icons.api_outlined,
            title: context.translate('seals'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(context.translate('not_available'))),
              );
            },
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Text(
              context.translate('profile_visibility_info'),
              style: TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.6), fontSize: 14),
            ),
          ),
          
          const Divider(height: 1),
          
          _buildProfileItem(
            icon: Icons.alternate_email,
            title: context.translate('username'),
            subtitle: user.username != null ? '@${user.username}' : null,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditUsernameView()),
              );
            },
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              context.translate('username_info'),
              style: TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.6), fontSize: 14),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildProfileItem({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, size: 28),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      subtitle: subtitle != null ? Text(subtitle, style: const TextStyle(color: Colors.grey)) : null,
      onTap: onTap,
    );
  }

  void _showNameEditBottomSheet(BuildContext context, String currentName) {
    final controller = TextEditingController(text: currentName);
    final colorScheme = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, top: 24, left: 24, right: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(context.translate('name'), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              autofocus: true,
              decoration: InputDecoration(border: UnderlineInputBorder(borderSide: BorderSide(color: colorScheme.primary))),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCELAR')),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    context.read<AuthViewModel>().updateProfile(name: controller.text.trim());
                    Navigator.pop(context);
                  },
                  child: const Text('SALVAR'),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _showBioBottomSheet(BuildContext context, String currentBio) {
    final controller = TextEditingController(text: currentBio);
    final colorScheme = Theme.of(context).colorScheme;
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 24, left: 24, right: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(context.translate('about'), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: context.translate('about'),
                  border: UnderlineInputBorder(borderSide: BorderSide(color: colorScheme.primary)),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCELAR')),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () {
                      context.read<AuthViewModel>().updateProfile(bio: controller.text.trim());
                      Navigator.pop(context);
                    },
                    child: const Text('SALVAR'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                context.translate('suggestions'), 
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              _buildSuggestionItem(context, context.translate('fale_livremente'), controller),
              _buildSuggestionItem(context, context.translate('disponivel'), controller),
              _buildSuggestionItem(context, context.translate('ocupado'), controller),
              _buildSuggestionItem(context, context.translate('na_escola'), controller),
              _buildSuggestionItem(context, context.translate('no_cinema'), controller),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSuggestionItem(BuildContext context, String text, TextEditingController controller) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(text),
      onTap: () {
        controller.text = text;
      },
    );
  }
}
