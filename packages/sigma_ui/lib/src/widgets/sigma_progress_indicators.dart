import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Um indicador de progresso circular estilizado com ondas e pontilhados,
/// baseado no design fornecido.
class SigmaCircularProgress extends StatefulWidget {
  final double size;
  final Color? color;

  const SigmaCircularProgress({
    super.key,
    this.size = 48,
    this.color,
  });

  @override
  State<SigmaCircularProgress> createState() => _SigmaCircularProgressState();
}

class _SigmaCircularProgressState extends State<SigmaCircularProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? Theme.of(context).colorScheme.primary;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _CircularWavyPainter(
            animationValue: _controller.value,
            color: color,
          ),
        );
      },
    );
  }
}

class _CircularWavyPainter extends CustomPainter {
  final double animationValue;
  final Color color;

  _CircularWavyPainter({required this.animationValue, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final strokeWidth = size.width * 0.12;

    // 1. Desenha o fundo pontilhado/suave
    final bgPaint = Paint()
      ..color = color.withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, bgPaint);

    // 2. Desenha a parte "ativa" com efeito ondulado
    final activePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final startAngle = animationValue * 2 * math.pi;
    const sweepAngle = math.pi * 0.7; // Um pouco mais que o anterior para fluidez

    // Criando o efeito ondulado dentro do arco
    for (double i = 0; i <= sweepAngle; i += 0.05) { // Passo menor para suavidade
      final angle = startAngle + i;
      // Ondulação senoidal baseada na posição do arco e no tempo
      final waveOffset = math.sin(i * 12 + animationValue * 15) * (strokeWidth * 0.25);
      final currentRadius = radius + waveOffset;
      
      final x = center.dx + currentRadius * math.cos(angle);
      final y = center.dy + currentRadius * math.sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, activePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/// Um indicador de progresso linear estilizado com ondas,
/// baseado no design fornecido.
class SigmaLinearProgress extends StatefulWidget {
  final double width;
  final Color? color;

  const SigmaLinearProgress({
    super.key,
    this.width = 200,
    this.color,
  });

  @override
  State<SigmaLinearProgress> createState() => _SigmaLinearProgressState();
}

class _SigmaLinearProgressState extends State<SigmaLinearProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? Theme.of(context).colorScheme.primary;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.width, 12),
          painter: _LinearWavyPainter(
            animationValue: _controller.value,
            color: color,
          ),
        );
      },
    );
  }
}

class _LinearWavyPainter extends CustomPainter {
  final double animationValue;
  final Color color;

  _LinearWavyPainter({required this.animationValue, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = size.height * 0.4;
    
    // 1. Linha de fundo pontilhada
    final bgPaint = Paint()
      ..color = color.withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    
    canvas.drawLine(Offset(0, size.height / 2), Offset(size.width, size.height / 2), bgPaint);

    // 2. Parte ativa "Wavy"
    final activePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final segmentWidth = size.width * 0.3;
    final startX = (animationValue * (size.width + segmentWidth)) - segmentWidth;

    bool isPathEmpty = true;

    for (double x = 0; x <= segmentWidth; x += 2) {
      final currentX = startX + x;
      if (currentX < 0 || currentX > size.width) continue;

      // Efeito de onda senoidal
      final yOffset = math.sin(x * 0.15 + animationValue * 10) * (size.height * 0.25);
      
      if (isPathEmpty) {
        path.moveTo(currentX, size.height / 2 + yOffset);
        isPathEmpty = false;
      } else {
        path.lineTo(currentX, size.height / 2 + yOffset);
      }
    }

    canvas.drawPath(path, activePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
