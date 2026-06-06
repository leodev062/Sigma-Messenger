import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:sigma_core/src/contacts/avatars/profile_contact_photo.dart';

class DecryptedFileImageProvider extends ImageProvider<DecryptedFileImageProvider> {
  final ProfileContactPhoto photo;

  DecryptedFileImageProvider(this.photo);

  @override
  Future<DecryptedFileImageProvider> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<DecryptedFileImageProvider>(this);
  }

  @override
  ImageStreamCompleter loadImage(DecryptedFileImageProvider key, ImageDecoderCallback decode) {
    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(key, decode),
      scale: 1.0,
      debugLabel: photo.pathOrUrl,
    );
  }

  Future<ui.Codec> _loadAsync(DecryptedFileImageProvider key, ImageDecoderCallback decode) async {
    try {
      final File file = File(photo.pathOrUrl);
      if (!await file.exists()) {
        throw Exception('Avatar file not found: ${photo.pathOrUrl}');
      }

      final Uint8List bytes = await file.readAsBytes();
      
      final ui.ImmutableBuffer buffer = await ui.ImmutableBuffer.fromUint8List(bytes);
      return decode(buffer);
    } catch (e) {
      rethrow;
    }
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is DecryptedFileImageProvider && 
           other.photo.pathOrUrl == photo.pathOrUrl;
  }

  @override
  int get hashCode => photo.pathOrUrl.hashCode;
}
