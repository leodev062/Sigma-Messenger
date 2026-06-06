import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sigma_core/sigma_core.dart';
import '../models/home_tab.dart';

/// HomeState - Estado imutável da tela inicial.
class HomeState {
  final HomeTab selectedTab;
  final SocketConnectionStatus connectionStatus;

  HomeState({
    this.selectedTab = HomeTab.chats,
    this.connectionStatus = SocketConnectionStatus.disconnected,
  });

  HomeState copyWith({
    HomeTab? selectedTab,
    SocketConnectionStatus? connectionStatus,
  }) {
    return HomeState(
      selectedTab: selectedTab ?? this.selectedTab,
      connectionStatus: connectionStatus ?? this.connectionStatus,
    );
  }
}

/// HomeViewModel - Refatorado para POO com State Pattern e HomeTab Enum.
class HomeViewModel extends ChangeNotifier {
  final ISocketService _socketService;
  final SigmaStore _sigmaStore;
  late StreamSubscription _statusSubscription;
  
  HomeState _state = HomeState();
  HomeState get state => _state;

  HomeTab get selectedTab => _state.selectedTab;
  int get selectedIndex => _state.selectedTab.index;

  HomeViewModel(this._socketService, this._sigmaStore) {
    _statusSubscription = _socketService.status.listen((status) {
      _state = _state.copyWith(connectionStatus: status);
      notifyListeners();
    });
    
    _restoreState();
  }

  Future<void> _restoreState() async {
    final lastTabIndex = await _sigmaStore.settings.getLastTab();
    if (lastTabIndex >= 0 && lastTabIndex < HomeTab.values.length) {
      _state = _state.copyWith(selectedTab: HomeTab.values[lastTabIndex]);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _statusSubscription.cancel();
    super.dispose();
  }

  void setTab(HomeTab tab) {
    if (_state.selectedTab == tab) return;
    _state = _state.copyWith(selectedTab: tab);
    
    _sigmaStore.settings.setLastTab(tab.index);
    notifyListeners();
  }

  /// Mantido para compatibilidade se necessário, mas prefira setTab
  void setSelectedIndex(int index) {
    if (index >= 0 && index < HomeTab.values.length) {
      setTab(HomeTab.values[index]);
    }
  }

  String getTitle(BuildContext context) {
    if (_state.selectedTab != HomeTab.chats) {
      // Usar rótulo do HomeTab como título para outras abas
      return _state.selectedTab.label(context);
    }
    return _state.connectionStatus.toStatusTitle(context);
  }
}

extension _SocketStatusMapping on SocketConnectionStatus {
  String toStatusTitle(BuildContext context) {
    switch (this) {
      case SocketConnectionStatus.connecting:
        return context.translate('connecting');
      case SocketConnectionStatus.waitingNetwork:
        return context.translate('waiting_network');
      case SocketConnectionStatus.disconnected:
        return context.translate('no_connection');
      case SocketConnectionStatus.connected:
        return 'Sigma'; // Título padrão no lugar de app_name para chats
    }
  }
}
