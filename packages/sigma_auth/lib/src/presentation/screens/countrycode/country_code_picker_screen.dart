import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_auth/sigma_auth.dart';

class CountryCodePickerScreen extends StatelessWidget {
  const CountryCodePickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CountryCodePickerViewModel>();
    final layoutParams = RegistrationScaffold.rememberLayoutParams(context);

    if (layoutParams is OnePaneParams) {
      return _OnePaneLayout(
        params: layoutParams,
        state: viewModel.state,
        onEvent: viewModel.onEvent,
      );
    } else if (layoutParams is TwoPaneParams) {
      return _TwoPaneLayout(
        params: layoutParams,
        state: viewModel.state,
        onEvent: viewModel.onEvent,
      );
    }
    return const SizedBox.shrink();
  }
}

class _OnePaneLayout extends StatelessWidget {
  final OnePaneParams params;
  final CountryCodeState state;
  final Function(CountryCodePickerScreenEvents) onEvent;

  const _OnePaneLayout({
    required this.params,
    required this.state,
    required this.onEvent,
  });

  @override
  Widget build(BuildContext context) {
    return OnePaneRegistrationScaffold(
      params: params,
      topBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => onEvent(const Dismissed()),
              tooltip: context.translate('CountryCodeSelectScreen__close'),
            ),
            Text(
              context.translate('CountryCodeSelectScreen__your_country'),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
      contentBuilder: (context, padding) => _CountryList(state: state, onEvent: onEvent),
    );
  }
}

class _TwoPaneLayout extends StatelessWidget {
  final TwoPaneParams params;
  final CountryCodeState state;
  final Function(CountryCodePickerScreenEvents) onEvent;

  const _TwoPaneLayout({
    required this.params,
    required this.state,
    required this.onEvent,
  });

  @override
  Widget build(BuildContext context) {
    return TwoPaneRegistrationScaffold(
      params: params,
      topBar: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => onEvent(const Dismissed()),
            tooltip: context.translate('CountryCodeSelectScreen__close'),
          ),
        ],
      ),
      firstPaneBuilder: (context, padding) => Padding(
        padding: padding,
        child: Text(
          context.translate('CountryCodeSelectScreen__your_country'),
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      secondPaneBuilder: (context, padding) => _CountryList(state: state, onEvent: onEvent),
    );
  }
}

class _CountryList extends StatelessWidget {
  final CountryCodeState state;
  final Function(CountryCodePickerScreenEvents) onEvent;

  const _CountryList({required this.state, required this.onEvent});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SearchBar(
          query: state.query,
          onSearch: (q) => onEvent(Search(q)),
        ),
        if (state.countryList.isEmpty)
          const Expanded(child: Center(child: CircularProgressIndicator()))
        else
          Expanded(
            child: ListView.builder(
              itemCount: state.query.isEmpty 
                  ? (state.commonCountryList.length + state.countryList.length + (state.commonCountryList.isNotEmpty ? 1 : 0))
                  : state.filteredList.length,
              itemBuilder: (context, index) {
                if (state.query.isEmpty) {
                  if (state.commonCountryList.isNotEmpty) {
                    if (index < state.commonCountryList.length) {
                      return _CountryItem(country: state.commonCountryList[index], onEvent: onEvent);
                    } else if (index == state.commonCountryList.length) {
                      return const Divider(indent: 24, endIndent: 24);
                    } else {
                      return _CountryItem(country: state.countryList[index - state.commonCountryList.length - 1], onEvent: onEvent);
                    }
                  } else {
                    return _CountryItem(country: state.countryList[index], onEvent: onEvent);
                  }
                } else {
                  return _CountryItem(country: state.filteredList[index], onEvent: onEvent, query: state.query);
                }
              },
            ),
          ),
      ],
    );
  }
}

class _CountryItem extends StatelessWidget {
  final Country country;
  final Function(CountryCodePickerScreenEvents) onEvent;
  final String query;

  const _CountryItem({required this.country, required this.onEvent, this.query = ""});

  @override
  Widget build(BuildContext context) {
    final emoji = country.flag;
    final name = country.name.isEmpty ? context.translate('CountryCodeSelectScreen__unknown_country') : country.name;
    final code = '+${country.phoneCode}';

    return InkWell(
      onTap: () => onEvent(PickerCountrySelected(country)),
      child: Container(
        constraints: const BoxConstraints(minHeight: 56),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 24),
            Expanded(
              child: _HighlightedText(
                text: name,
                query: query,
                style: Theme.of(context).textTheme.bodyLarge!,
              ),
            ),
            const SizedBox(width: 24),
            _HighlightedText(
              text: code,
              query: query,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HighlightedText extends StatelessWidget {
  final String text;
  final String query;
  final TextStyle style;

  const _HighlightedText({required this.text, required this.query, required this.style});

  @override
  Widget build(BuildContext context) {
    if (query.isEmpty) return Text(text, style: style);

    final startIndex = text.toLowerCase().indexOf(query.toLowerCase());
    if (startIndex == -1) return Text(text, style: style);

    return RichText(
      text: TextSpan(
        style: style,
        children: [
          TextSpan(text: text.substring(0, startIndex)),
          TextSpan(
            text: text.substring(startIndex, startIndex + query.length),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: text.substring(startIndex + query.length)),
        ],
      ),
    );
  }
}

class _SearchBar extends StatefulWidget {
  final String query;
  final Function(String) onSearch;

  const _SearchBar({required this.query, required this.onSearch});

  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  late TextEditingController _controller;
  bool _showKeyboard = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.query);
  }

  @override
  void didUpdateWidget(_SearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.query != _controller.text) {
      _controller.text = widget.query;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      color: colorScheme.surface,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
      child: TextField(
        controller: _controller,
        onChanged: widget.onSearch,
        keyboardType: _showKeyboard ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          hintText: context.translate('CountryCodeSelectScreen__search_by'),
          filled: true,
          fillColor: colorScheme.surfaceContainerHighest,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32), borderSide: BorderSide.none),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          constraints: const BoxConstraints(minHeight: 54),
          suffixIcon: widget.query.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => widget.onSearch(""),
                )
              : IconButton(
                  icon: Icon(_showKeyboard ? Icons.keyboard : Icons.dialpad),
                  onPressed: () => setState(() => _showKeyboard = !_showKeyboard),
                ),
        ),
      ),
    );
  }
}
