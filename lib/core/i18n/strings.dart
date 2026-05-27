import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigma/features/settings/presentation/viewmodels/settings_viewmodel.dart';

class SigmaStrings {
  static final Map<String, Map<String, String>> _values = {
    'pt': {
      'app_name': 'Sigma',
      'welcome_title': 'Sigma .\nConnect .',
      'welcome_subtitle': 'A nova era da comunicação privada e segura. Simples, rápido e elegante.',
      'btn_start': 'COMEÇAR',
      
      'permissions_title': 'Privacidade e\nPermissões .',
      'permissions_subtitle': 'Para funcionar corretamente, o Sigma precisa de acesso aos seus contatos para sincronizar conversas e notificações para te avisar de novas mensagens.',
      'btn_give_permission': 'DAR PERMISSÃO',
      'btn_not_now': 'AGORA NÃO',
      
      'login_title': 'Número de\nTelefone .',
      'login_subtitle': 'Insira o número do seu celular para receber um código de acesso.',
      'select_country': 'Selecione seu país',
      'search_country_hint': 'Pesquisar país ou código...',
      'btn_send_code': 'ENVIAR CÓDIGO',
      'error_generic': 'Ocorreu um erro',
      
      'verification_title': 'Código de\nAcesso .',
      'verification_subtitle': 'Digite o código de 6 dígitos que enviamos para {phone}.',
      'resend_sms': 'Reenviar código SMS',
      'invalid_code': 'Código inválido',
      
      'profile_setup_title': 'Configure seu\nPerfil .',
      'profile_setup_subtitle': 'Como os seus amigos devem ver você no Sigma?',
      'full_name_label': 'Nome Completo',
      'username_label': 'Nome de Utilizador',
      'btn_finish': 'CONCLUIR',
      'profile_setup_empty_error': 'Por favor, preencha o seu nome e um nome de utilizador.',
      'profile_setup_save_error': 'Erro ao salvar perfil',
      
      'search_ai_hint': 'Perguntar à Meta AI ou Pesquisar',
      'no_chats': 'Nenhuma conversa ainda.',
      'filter_all': 'Tudo',
      'filter_unread': 'Não lidas',
      'filter_groups': 'Grupos',
      'no_connection': 'Sem ligação',
      'waiting_network': 'Aguardando rede...',
      
      'new_group': 'Novo grupo',
      'new_contact': 'Novo contacto',
      'new_community': 'Nova comunidade',
      'contacts_header': 'Contactos no Sigma',
      'no_contacts': 'Nenhum contacto encontrado.',
      
      'app_settings': 'Definições do App',
      'language': 'Idioma',
      'theme': 'Tema',
      'show_filters': 'Mostrar Filtros de Chat',
      'account': 'Conta',
      'account_subtitle': 'Segurança, mudar número, apagar conta',
      'chats': 'Conversas',
      'chats_subtitle': 'Tema, fundos, histórico, filtros',
      'privacy': 'Privacidade',
      'notifications': 'Notificações',
      'help': 'Ajuda',
      
      'theme_system': 'Padrão do Sistema',
      'theme_light': 'Claro',
      'theme_dark': 'Escuro',
      'select_language': 'Selecionar Idioma',
      
      'phone_number': 'Número de Telefone',
      'security_notifications': 'Notificações de segurança',
      'two_step_verification': 'Verificação em duas etapas',
      'email_address': 'Endereço de e-mail',
      'delete_account': 'Apagar conta',
      
      'display_header': 'Exibição',
      'wallpaper': 'Fundo de ecrã',
      'chat_history': 'Histórico de conversas',
      'chat_backup': 'Cópia de segurança',
      
      'profile': 'Perfil',
      'name': 'Nome',
      'about': 'Recado',
      'available': 'Disponível',
      'username': 'Nome de utilizador',
      'seals': 'Selos',
      'edit_photo': 'Editar foto',
      'profile_visibility_info': 'Seu perfil e alterações ficarão visíveis para seus contatos, grupos e pessoas que você enviar mensagens.',
      'username_info': 'As pessoas agora podem enviar mensagens para você usando seu nome de usuário opcional. Você não precisa mais informar seu número de telefone.',
      'loading': 'A carregar...',
      'type_message_hint': 'Mensagem do Sigma',
      'no_messages': 'Nenhuma mensagem aqui.',
      
      'update_available': 'Versão {version} disponível',
      'btn_ignore': 'IGNORAR',
      'btn_update': 'ATUALIZAR',
      'update_check_error': 'Erro ao verificar atualizações',

      'suggestions': 'Sugestões',
      'fale_livremente': 'Fale livremente',
      'disponivel': 'Disponível',
      'ocupado': 'Ocupado',
      'na_escola': 'Na escola',
      'no_cinema': 'No cinema',
      'not_available': 'Funcionalidade não disponível no momento',
      'username_hint': 'Escolha um nome de usuário único. Outras pessoas poderão te encontrar por este nome sem precisar do seu número de telefone.',
      'checking_username': 'Verificando disponibilidade...',
      'username_available': 'Nome de usuário disponível!',
      'username_taken': 'Este nome de usuário já está em uso.',
    },
    'en': {
      'app_name': 'Sigma',
      'welcome_title': 'Sigma .\nConnect .',
      'welcome_subtitle': 'The new era of private and secure communication. Simple, fast, and elegant.',
      'btn_start': 'START',
      
      'permissions_title': 'Privacy and\nPermissions .',
      'permissions_subtitle': 'To function correctly, Sigma needs access to your contacts to sync conversations and notifications to alert you of new messages.',
      'btn_give_permission': 'GIVE PERMISSION',
      'btn_not_now': 'NOT NOW',
      
      'login_title': 'Phone\nNumber .',
      'login_subtitle': 'Enter your mobile number to receive an access code.',
      'select_country': 'Select your country',
      'search_country_hint': 'Search country or code...',
      'btn_send_code': 'SEND CODE',
      'error_generic': 'An error occurred',
      
      'verification_title': 'Access\nCode .',
      'verification_subtitle': 'Enter the 6-digit code we sent to {phone}.',
      'resend_sms': 'Resend SMS code',
      'invalid_code': 'Invalid code',
      
      'profile_setup_title': 'Setup your\nProfile .',
      'profile_setup_subtitle': 'How should your friends see you on Sigma?',
      'full_name_label': 'Full Name',
      'username_label': 'Username',
      'btn_finish': 'FINISH',
      'profile_setup_empty_error': 'Please fill in your name and a username.',
      'profile_setup_save_error': 'Error saving profile',
      
      'search_ai_hint': 'Ask Meta AI or Search',
      'no_chats': 'No chats yet.',
      'filter_all': 'All',
      'filter_unread': 'Unread',
      'filter_groups': 'Groups',
      'no_connection': 'No connection',
      'waiting_network': 'Waiting for network...',
      
      'new_group': 'New group',
      'new_contact': 'New contact',
      'new_community': 'New community',
      'contacts_header': 'Contacts on Sigma',
      'no_contacts': 'No contacts found.',
      
      'app_settings': 'App Settings',
      'language': 'Language',
      'theme': 'Theme',
      'show_filters': 'Show Chat Filters',
      'account': 'Account',
      'account_subtitle': 'Security, change number, delete account',
      'chats': 'Chats',
      'chats_subtitle': 'Theme, wallpapers, history, filters',
      'privacy': 'Privacy',
      'notifications': 'Notifications',
      'help': 'Help',
      
      'theme_system': 'System Default',
      'theme_light': 'Light',
      'theme_dark': 'Dark',
      'select_language': 'Select Language',
      
      'phone_number': 'Phone Number',
      'security_notifications': 'Security notifications',
      'two_step_verification': 'Two-step verification',
      'email_address': 'Email address',
      'delete_account': 'Delete account',
      
      'display_header': 'Display',
      'wallpaper': 'Wallpaper',
      'chat_history': 'Chat history',
      'chat_backup': 'Chat backup',
      
      'profile': 'Profile',
      'name': 'Name',
      'about': 'About',
      'available': 'Available',
      'username': 'Username',
      'seals': 'Seals',
      'edit_photo': 'Edit photo',
      'profile_visibility_info': 'Your profile and changes will be visible to your contacts, groups, and people you message.',
      'username_info': 'People can now message you using your optional username. You no longer need to share your phone number.',
      'loading': 'Loading...',
      'type_message_hint': 'Sigma message',
      'no_messages': 'No messages here.',
      
      'update_available': 'Version {version} available',
      'btn_ignore': 'IGNORE',
      'btn_update': 'UPDATE',
      'update_check_error': 'Error checking for updates',

      'suggestions': 'Suggestions',
      'fale_livremente': 'Speak freely',
      'disponivel': 'Available',
      'ocupado': 'Busy',
      'na_escola': 'At school',
      'no_cinema': 'At the movies',
      'not_available': 'Feature not available at the moment',
      'username_hint': 'Choose a unique username. Others will be able to find you by this name without needing your phone number.',
      'checking_username': 'Checking availability...',
      'username_available': 'Username available!',
      'username_taken': 'This username is already in use.',
    },
  };

  static String get(BuildContext context, String key, {Map<String, String>? args}) {
    final locale = Provider.of<SettingsViewModel>(context).locale.languageCode;
    String value = _values[locale]?[key] ?? _values['en']?[key] ?? key;
    
    if (args != null) {
      args.forEach((k, v) {
        value = value.replaceAll('{$k}', v);
      });
    }
    
    return value;
  }
}

extension SigmaStringsExtension on BuildContext {
  String translate(String key, {Map<String, String>? args}) => SigmaStrings.get(this, key, args: args);
}
