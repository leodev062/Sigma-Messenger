import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sigma_core/sigma_core.dart';
import '../viewmodels/home_viewmodel.dart';
import '../models/home_tab.dart';
import '../widgets/sigma_bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UpdateViewModel>().check();
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.watch<HomeViewModel>();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Calcula a cor de fundo da barra de navegação (Elevação Nível 3)
    final navBarColor = ElevationOverlay.applySurfaceTint(
      colorScheme.surface,
      colorScheme.surfaceTint,
      3,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: navBarColor,
        systemNavigationBarIconBrightness: 
            theme.brightness == Brightness.dark ? Brightness.light : Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: 
            theme.brightness == Brightness.dark ? Brightness.light : Brightness.dark,
      ),
      child: Scaffold(
        appBar: _HomeAppBar(
          title: homeViewModel.getTitle(context),
          currentTab: homeViewModel.selectedTab,
          onSettingsSelected: () => homeViewModel.setTab(HomeTab.communities), // Use Communities (Placeholder for Settings)
        ),
        body: IndexedStack(
          index: homeViewModel.selectedIndex,
          children: HomeTab.values.map((tab) => tab.view).toList(),
        ),
        bottomNavigationBar: SigmaBottomNavigationBar(
          selectedTab: homeViewModel.selectedTab,
          onTabSelected: (tab) => homeViewModel.setTab(tab),
        ),
        floatingActionButton: homeViewModel.selectedTab == HomeTab.chats
            ? _HomeFloatingActionButton(colorScheme: colorScheme)
            : null,
      ),
    );
  }
}

class _HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final HomeTab currentTab;
  final VoidCallback onSettingsSelected;

  const _HomeAppBar({
    required this.title,
    required this.currentTab,
    required this.onSettingsSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.normal,
          fontSize: 22,
        ),
      ),
      backgroundColor: colorScheme.surface,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      actions: [
        if (currentTab == HomeTab.chats)
          IconButton(
            icon: Icon(Icons.camera_alt_outlined, color: colorScheme.onSurface),
            onPressed: () {},
          ),
        PopupMenuButton<String>(
          icon: Icon(Icons.more_vert, color: colorScheme.onSurface),
          onSelected: (value) {
            if (value == 'settings') {
              onSettingsSelected();
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'new_group',
              child: Text(context.translate('new_group')),
            ),
            PopupMenuItem(
              value: 'new_broadcast',
              child: Text(context.translate('new_broadcast')),
            ),
            PopupMenuItem(
              value: 'linked_devices',
              child: Text(context.translate('linked_devices')),
            ),
            PopupMenuItem(
              value: 'starred_messages',
              child: Text(context.translate('starred_messages')),
            ),
            PopupMenuItem(
              value: 'settings',
              child: Text(context.translate('settings')),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomeFloatingActionButton extends StatelessWidget {
  final ColorScheme colorScheme;

  const _HomeFloatingActionButton({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: const Icon(Icons.add_comment_rounded),
    );
  }
}
