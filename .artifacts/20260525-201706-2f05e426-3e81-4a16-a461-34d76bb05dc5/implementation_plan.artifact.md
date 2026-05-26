# Implementation Plan - Conversation Management (Archive/Delete)

This plan outlines the implementation of archive and delete functionality for chats in the Sigma Flutter app, mirroring the logic used in Signal.

## Proposed Changes

### [Core - Database]

#### [database.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma/lib/core/storage/database.dart)
- Add database methods for archiving and deleting chats.
- Update `watchAllChats` to filter by archive status (optional, based on UI needs).

```dart
// Add to AppDatabase
Future<void> archiveChat(String chatId, bool archive) {
  return (update(chats)..where((t) => t.id.equals(chatId)))
      .write(ChatsCompanion(isArchived: Value(archive), isPinned: Value(false)));
}

Future<void> deleteChat(String chatId) async {
  await transaction(() async {
    await (delete(messages)..where((t) => t.chatId.equals(chatId))).go();
    await (delete(chats)..where((t) => t.id.equals(chatId))).go();
  });
}
```

---

### [Features - Repository]

#### [chat_repository.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma/lib/features/chat/chat_repository.dart)
- Add `archiveChat` and `deleteChat` methods.
- `deleteChat` should also notify the server via WebSocket (Signal pattern).

```dart
Future<void> archiveChat(String chatId, bool archive) async {
  await _database.archiveChat(chatId, archive);
}

Future<void> deleteChat(String chatId) async {
  await _database.deleteChat(chatId);
  // Pattern Signal: Sync delete with server via WebSocket
  if (_socketManager.isConnected) {
    await _socketManager.request(
      verb: 'DELETE',
      path: '/api/v1/chats/$chatId',
    );
  }
}
```

---

### [Features - ViewModel]

#### [chat_viewmodel.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma/lib/features/chat/chat_viewmodel.dart)
- Expose archive and delete actions to the UI.

---

### [Features - UI]

#### [home_screen.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma/lib/features/chat/home_screen.dart)
- Implement "Swipe to Archive/Delete" or a Long Press menu in the conversation list, matching Signal's UX.

---

## Verification Plan

### Automated Tests
- No existing tests for these features.
- I will verify by checking the database state and server logs after performing the actions in the UI.

### Manual Verification
- Perform swipe/long-press actions on a chat.
- Verify the chat disappears from the main list when archived.
- Verify the chat and its messages are removed from the database when deleted.
- Verify the server receives the `DELETE` request for the chat.
