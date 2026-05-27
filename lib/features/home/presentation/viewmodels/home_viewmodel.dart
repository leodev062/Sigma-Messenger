import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sigma/core/i18n/strings.dart';
import 'package:sigma/domain/services/i_socket_service.dart';

class HomeViewModel extends ChangeNotifier {
  final ISocketService _socketService;
  late StreamSubscription _statusSubscription;
  
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  
  SocketConnectionStatus _connectionStatus = SocketConnectionStatus.disconnected;

  HomeViewModel(this._socketService) {
    _statusSubscription = _socketService.status.listen((status) {
      _connectionStatus = status;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _statusSubscription.cancel();
    super.dispose();
  }

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  String getTitle(BuildContext context) {
    // Se não estiver na aba de Chats (0), mostra apenas o nome da aba traduzido
    if (_selectedIndex != 0) {
      switch (_selectedIndex) {
        case 1:
          return context.translate('contacts');
        case 2:
          return context.translate('settings');
        case 3:
          return context.translate('profile');
        default:
          return context.translate('app_name');
      }
    }

    switch (_connectionStatus) {
      case SocketConnectionStatus.connecting:
        return context.translate('loading');
      case SocketConnectionStatus.waitingNetwork:
        return context.translate('waiting_network');
      case SocketConnectionStatus.disconnected:
        return context.translate('no_connection');
      case SocketConnectionStatus.connected:
        return context.translate('app_name');
    }
  }
}
