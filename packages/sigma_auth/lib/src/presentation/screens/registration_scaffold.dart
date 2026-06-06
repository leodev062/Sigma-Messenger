import 'dart:math' as math;
import 'package:flutter/material.dart';

enum WindowBreakpoint { small, medium, largeWidth, largeHeight }

abstract class RegistrationScaffoldParams {
  final double headerSlotHeight;
  final double bottomInset;
  final double maxButtonWidth;

  RegistrationScaffoldParams({
    required this.headerSlotHeight,
    required this.bottomInset,
    required this.maxButtonWidth,
  });

  EdgeInsets get footerPadding => EdgeInsets.only(
        top: 16,
        bottom: bottomInset,
        left: 16,
        right: bottomInset,
      );
}

class OnePaneParams extends RegistrationScaffoldParams {
  final double paneVerticalInset;
  final double paneHorizontalInset;

  OnePaneParams({
    required super.headerSlotHeight,
    required this.paneVerticalInset,
    required this.paneHorizontalInset,
    required super.bottomInset,
    required super.maxButtonWidth,
  });

  EdgeInsets panePadding({required bool hasHeader}) => EdgeInsets.only(
        top: hasHeader ? paneVerticalInset : headerSlotHeight + paneVerticalInset,
        bottom: paneVerticalInset,
        left: paneHorizontalInset,
        right: paneHorizontalInset,
      );
}

class TwoPaneParams extends RegistrationScaffoldParams {
  final double paneTopInset;
  final double paneBottomInset;
  final double paneOuterInset;
  final double paneInnerInset;

  TwoPaneParams({
    required super.headerSlotHeight,
    required this.paneTopInset,
    required this.paneBottomInset,
    required this.paneOuterInset,
    required this.paneInnerInset,
    required super.bottomInset,
    required super.maxButtonWidth,
  });

  EdgeInsets firstPanePadding({required bool hasHeader}) => EdgeInsets.only(
        top: hasHeader ? paneTopInset : headerSlotHeight + paneTopInset,
        bottom: paneBottomInset,
        left: paneOuterInset,
        right: paneInnerInset,
      );

  EdgeInsets secondPanePadding({required bool hasHeader}) => EdgeInsets.only(
        top: hasHeader ? paneTopInset : headerSlotHeight + paneTopInset,
        bottom: paneBottomInset,
        left: paneInnerInset,
        right: paneOuterInset,
      );
}

class RegistrationScaffold extends StatelessWidget {
  final Widget? topBar;
  final Widget? footer;
  final Widget content;

  const RegistrationScaffold({
    super.key,
    this.topBar,
    this.footer,
    required this.content,
  });

  static RegistrationScaffoldParams rememberLayoutParams(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final breakpoint = _getBreakpoint(size);
    final viewPadding = MediaQuery.of(context).padding;
    final bottomInset = math.max(viewPadding.bottom, 24.0);

    switch (breakpoint) {
      case WindowBreakpoint.small:
        return OnePaneParams(
          headerSlotHeight: 24,
          bottomInset: bottomInset,
          paneVerticalInset: 24,
          paneHorizontalInset: 24,
          maxButtonWidth: double.infinity, // Mobile preenche largura
        );
      case WindowBreakpoint.medium:
        return TwoPaneParams(
          headerSlotHeight: 64,
          bottomInset: bottomInset,
          paneTopInset: 16,
          paneBottomInset: 24,
          paneOuterInset: 24,
          paneInnerInset: 24,
          maxButtonWidth: 320,
        );
      case WindowBreakpoint.largeWidth:
        return TwoPaneParams(
          headerSlotHeight: 64,
          bottomInset: math.max(bottomInset, 32.0),
          paneTopInset: 64,
          paneBottomInset: 64,
          paneOuterInset: 128,
          paneInnerInset: 64,
          maxButtonWidth: 412,
        );
      case WindowBreakpoint.largeHeight:
        return OnePaneParams(
          headerSlotHeight: 64,
          bottomInset: math.max(bottomInset, 32.0),
          paneVerticalInset: 64,
          paneHorizontalInset: size.width > 800 ? size.width * 0.2 : 128,
          maxButtonWidth: 400,
        );
    }
  }

  static WindowBreakpoint _getBreakpoint(Size size) {
    if (size.width < 600) return WindowBreakpoint.small;
    if (size.width < 840) return WindowBreakpoint.medium;
    if (size.width >= 840 && size.height < 480) return WindowBreakpoint.largeWidth;
    return WindowBreakpoint.largeHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            if (topBar != null) topBar!,
            Expanded(child: content),
            if (footer != null) footer!,
          ],
        ),
      ),
    );
  }
}

class OnePaneRegistrationScaffold extends StatelessWidget {
  final OnePaneParams params;
  final Widget? topBar;
  final Widget? footer;
  final Widget Function(BuildContext, EdgeInsets) contentBuilder;

  const OnePaneRegistrationScaffold({
    super.key,
    required this.params,
    this.topBar,
    this.footer,
    required this.contentBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return RegistrationScaffold(
      topBar: topBar,
      footer: footer,
      content: contentBuilder(context, params.panePadding(hasHeader: topBar != null)),
    );
  }
}

class TwoPaneRegistrationScaffold extends StatelessWidget {
  final TwoPaneParams params;
  final Widget? topBar;
  final Widget? footer;
  final Widget Function(BuildContext, EdgeInsets) firstPaneBuilder;
  final Widget Function(BuildContext, EdgeInsets) secondPaneBuilder;

  const TwoPaneRegistrationScaffold({
    super.key,
    required this.params,
    this.topBar,
    this.footer,
    required this.firstPaneBuilder,
    required this.secondPaneBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return RegistrationScaffold(
      topBar: topBar,
      footer: footer,
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: firstPaneBuilder(context, params.firstPanePadding(hasHeader: topBar != null)),
          ),
          Expanded(
            child: secondPaneBuilder(context, params.secondPanePadding(hasHeader: topBar != null)),
          ),
        ],
      ),
    );
  }
}
