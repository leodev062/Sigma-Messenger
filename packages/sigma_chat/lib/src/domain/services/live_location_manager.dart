import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:sigma_core/sigma_core.dart';
import '../../domain/i_chat_repository.dart';
import '../../data/jobs/chat/push_location_send_job.dart';

/// LiveLocationManager - Handles real-time location tracking and syncing.
class LiveLocationManager with Loggable {
  final IChatRepository _chatRepository;
  final SigmaJobManager _jobManager;
  
  final Map<String, StreamSubscription<Position>> _activeTrackers = {};
  final Map<String, DateTime> _expiryTimes = {};
  final Map<String, String> _destinationTypes = {};

  LiveLocationManager(this._chatRepository, this._jobManager);

  /// Starts sharing live location for a specific message/chat.
  Future<void> startLiveLocation({
    required String chatId,
    required String messageId,
    required int durationMinutes,
    String destinationType = "USER",
  }) async {
    if (_activeTrackers.containsKey(messageId)) {
      logW("Live location already active for message $messageId");
      return;
    }

    final expiry = DateTime.now().add(Duration(minutes: durationMinutes));
    _expiryTimes[messageId] = expiry;
    _destinationTypes[messageId] = destinationType;

    logI("Starting live location for $chatId, expires at $expiry");

    // Configure location settings
    const locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10, // Update every 10 meters
    );

    final subscription = Geolocator.getPositionStream(locationSettings: locationSettings).listen(
      (position) {
        _handleLocationUpdate(chatId, messageId, position);
      },
      onError: (e) {
        logE("Error in location stream for $messageId", e);
        stopLiveLocation(messageId);
      },
    );

    _activeTrackers[messageId] = subscription;

    // Set a timer to stop automatically
    Timer(Duration(minutes: durationMinutes), () {
      stopLiveLocation(messageId);
    });
  }

  void _handleLocationUpdate(String chatId, String messageId, Position position) async {
    final expiry = _expiryTimes[messageId];
    if (expiry != null && DateTime.now().isAfter(expiry)) {
      stopLiveLocation(messageId);
      return;
    }

    logD("Live update for $messageId: ${position.latitude}, ${position.longitude}");

    // 1. Update local DB
    final message = await _chatRepository.getMessage(messageId);
    if (message == null) return;

    final updatedMessage = MessageEntity(
      id: message.id,
      conversationId: message.conversationId,
      senderId: message.senderId,
      textContent: message.textContent,
      type: message.type,
      timestamp: message.timestamp,
      status: message.status,
      latitude: position.latitude,
      longitude: position.longitude,
      accuracy: position.accuracy,
      isLive: true,
      locationTimestamp: DateTime.now().millisecondsSinceEpoch,
    );

    await _chatRepository.saveLocationData(updatedMessage);

    // 2. Queue Job to send update to server
    // We use the same messageId to overwrite on receiver side if they follow the same logic
    _jobManager.add(PushLocationSendJob(
      messageId: messageId,
      isUpdate: true,
      destinationType: _destinationTypes[messageId] ?? "USER",
    ));
  }

  /// Stops sharing live location for a specific message.
  void stopLiveLocation(String messageId) {
    logI("Stopping live location for $messageId");
    _activeTrackers[messageId]?.cancel();
    _activeTrackers.remove(messageId);
    _expiryTimes.remove(messageId);
    
    // Optional: Send a final "terminated" update
  }

  void dispose() {
    for (var sub in _activeTrackers.values) {
      sub.cancel();
    }
    _activeTrackers.clear();
    _expiryTimes.clear();
  }
}
