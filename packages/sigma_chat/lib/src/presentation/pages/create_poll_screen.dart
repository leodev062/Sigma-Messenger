import 'package:flutter/material.dart';
import 'package:sigma_core/sigma_core.dart';

class CreatePollScreen extends StatefulWidget {
  final Function(String question, bool allowMultiple, List<String> options) onSend;

  const CreatePollScreen({super.key, required this.onSend});

  @override
  State<CreatePollScreen> createState() => _CreatePollScreenState();
}

class _CreatePollScreenState extends State<CreatePollScreen> {
  final TextEditingController _questionController = TextEditingController();
  final List<TextEditingController> _optionControllers = [
    TextEditingController(),
    TextEditingController(),
  ];
  bool _allowMultiple = true;

  @override
  void initState() {
    super.initState();
    for (var controller in _optionControllers) {
      controller.addListener(_onOptionChanged);
    }
  }

  void _onOptionChanged() {
    final lastController = _optionControllers.last;
    if (lastController.text.isNotEmpty && _optionControllers.length < 10) {
      setState(() {
        final newController = TextEditingController();
        newController.addListener(_onOptionChanged);
        _optionControllers.add(newController);
      });
    }
  }

  bool get _isValid {
    final filledOptions = _optionControllers
        .where((c) => c.text.trim().isNotEmpty)
        .toList();
    return _questionController.text.trim().isNotEmpty && filledOptions.length >= 2;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Nova enquete"),
        actions: [
          IconButton(
            onPressed: _isValid
                ? () {
                    final options = _optionControllers
                        .map((c) => c.text.trim())
                        .where((t) => t.isNotEmpty)
                        .toList();
                    print("DEBUG: Enviando enquete via callback: ${_questionController.text}");
                    widget.onSend(
                      _questionController.text.trim(),
                      _allowMultiple,
                      options,
                    );
                    Navigator.pop(context);
                  }
                : null,
            icon: Icon(Icons.send, color: _isValid ? SigmaColors.signalBlue : Colors.grey),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            "PERGUNTA",
            style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.primary),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _questionController,
            decoration: const InputDecoration(
              hintText: "Faça uma pergunta",
              filled: true,
            ),
            onChanged: (_) => setState(() {}),
            textCapitalization: TextCapitalization.sentences,
          ),
          const SizedBox(height: 24),
          Text(
            "OPÇÕES",
            style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.primary),
          ),
          const SizedBox(height: 8),
          ..._optionControllers.asMap().entries.map((entry) {
            final index = entry.key;
            final controller = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: "Opção ${index + 1}",
                  filled: true,
                  prefixIcon: const Icon(Icons.menu, size: 20),
                ),
                onChanged: (_) => setState(() {}),
                textCapitalization: TextCapitalization.sentences,
              ),
            );
          }),
          const SizedBox(height: 16),
          SwitchListTile(
            title: const Text("Permitir várias respostas"),
            value: _allowMultiple,
            onChanged: (val) => setState(() => _allowMultiple = val),
            contentPadding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _questionController.dispose();
    for (var c in _optionControllers) {
      c.dispose();
    }
    super.dispose();
  }
}
