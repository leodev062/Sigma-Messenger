import 'dart:io';
import 'package:flutter/widgets.dart';
import 'contact_photo.dart';

class ProfileContactPhoto extends ContactPhoto {
  final String pathOrUrl;

  ProfileContactPhoto(this.pathOrUrl);

  @override
  ImageProvider getImageProvider() {
    // Se o endereço guardado no banco começar com http, carrega da internet direto
    if (pathOrUrl.startsWith('http://') || pathOrUrl.startsWith('https://')) {
      return NetworkImage(pathOrUrl);
    }
    // Caso contrário, assume que é um arquivo local em cache no dispositivo
    return FileImage(File(pathOrUrl));
  }
}
