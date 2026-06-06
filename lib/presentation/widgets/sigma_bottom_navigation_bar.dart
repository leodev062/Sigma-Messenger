import 'package:flutter/material.dart';
import '../models/home_tab.dart';

class SigmaBottomNavigationBar extends StatelessWidget {
  final HomeTab selectedTab;
  final ValueChanged<HomeTab> onTabSelected;

  const SigmaBottomNavigationBar({
    super.key,
    required this.selectedTab,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return NavigationBar(
      selectedIndex: selectedTab.index,
      onDestinationSelected: (index) => onTabSelected(HomeTab.values[index]),
      backgroundColor: ElevationOverlay.applySurfaceTint(
        colorScheme.surface,
        colorScheme.surfaceTint,
        3,
      ),
      indicatorColor: colorScheme.secondaryContainer,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      height: 75,
      elevation: 0,
      destinations: HomeTab.values.map((tab) {
        return NavigationDestination(
          icon: Icon(tab.icon),
          selectedIcon: Icon(tab.selectedIcon),
          label: tab.label(context),
        );
      }).toList(),
    );
  }
}
