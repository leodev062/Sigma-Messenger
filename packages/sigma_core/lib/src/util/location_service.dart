import 'package:geolocator/geolocator.dart';
import 'package:sigma_core/sigma_core.dart';

/// LocationService - Abstração POO para serviços de GPS.
class LocationService with Loggable {
  
  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 1. Verificar se o GPS está ligado
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      logW("Serviço de localização desativado.");
      return null;
    }

    // 2. Verificar Permissões
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        logW("Permissão de localização negada.");
        return null;
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      logE("Permissão de localização negada permanentemente.");
      return null;
    }

    // 3. Obter Coordenadas
    try {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
      );
    } catch (e) {
      logE("Erro ao obter posição GPS: $e");
      return null;
    }
  }
}
