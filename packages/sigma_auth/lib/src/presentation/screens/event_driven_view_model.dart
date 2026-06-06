import 'dart:async';
import 'package:flutter/foundation.dart';

/// Base view model that helps one implement an Elm-like architecture, where events are processed and
/// new models are emitted. In particular, this base class exists to setup the core event channel
/// to avoid gotcha's around threading and race conditions.
abstract class EventDrivenViewModel<E, S> extends ChangeNotifier {
  final String tag;
  final StreamController<E> _eventChannel = StreamController<E>();
  final StreamController<S> _effectChannel = StreamController<S>.broadcast();

  EventDrivenViewModel(this.tag) {
    _eventChannel.stream.listen((event) {
      if (kDebugMode) {
        print('[$tag] [Event] $event');
      }
      processEvent(event);
    });
  }

  /// Stream of side effects (e.g. showing a snackbar or dialog) that should only happen once.
  Stream<S> get effectStream => _effectChannel.stream;

  void onEvent(E event) {
    _eventChannel.add(event);
  }

  /// Emit a side effect to the UI.
  @protected
  void emitEffect(S effect) {
    _effectChannel.add(effect);
  }

  /// Handle the event how you wish. It's recommended that you use the event to emit a new state model
  /// to be observed by the view.
  @protected
  Future<void> processEvent(E event);

  @override
  void dispose() {
    _eventChannel.close();
    _effectChannel.close();
    super.dispose();
  }
}
