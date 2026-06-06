
/// Bridge interface to avoid circular dependency between sigma_core and sigma_chat.
/// The concrete implementation will be in sigma_chat and registered in locator.
abstract class PushMessageProcessor {
  Future<void> process(List<int> bytes);
}
