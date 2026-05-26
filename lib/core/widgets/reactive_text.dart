import 'package:flutter/material.dart';

/// Um widget de texto otimizado que reage a mudanças com animação suave.
class ReactiveText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final Duration duration;

  const ReactiveText({
    super.key,
    required this.text,
    this.style,
    this.textAlign,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: Text(
        text,
        key: ValueKey<String>(text),
        style: style,
        textAlign: textAlign,
      ),
    );
  }
}
