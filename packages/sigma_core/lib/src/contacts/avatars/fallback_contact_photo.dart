import 'package:flutter/material.dart';
import 'package:sigma_core/src/domain/entities/recipient.dart';
import 'contact_photo.dart';

class FallbackContactPhoto extends ContactPhoto {
  final Recipient recipient;

  FallbackContactPhoto(this.recipient);

  @override
  ImageProvider? getImageProvider() => null;

  Color get backgroundColor => recipient.color;
  String get initials => recipient.initials;
}
