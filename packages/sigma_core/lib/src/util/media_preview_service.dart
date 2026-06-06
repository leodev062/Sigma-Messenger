import 'package:photo_manager/photo_manager.dart';
import 'package:sigma_core/sigma_core.dart';

/// MediaPreviewService - Gerencia o acesso à galeria do dispositivo.
class MediaPreviewService with Loggable {
  
  Future<bool> requestPermissions() async {
    // photo_manager 3.x utiliza requestPermissionExtend
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    return ps.isAuth;
  }

  Future<List<AssetEntity>> fetchRecentMedia({int count = 20}) async {
    // photo_manager 3.x exige FilterOptionGroup
    final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
      type: RequestType.image,
      filterOption: FilterOptionGroup(),
    );

    if (paths.isEmpty) return [];

    // O primeiro caminho geralmente é o "Recentes" ou "Todas as fotos"
    return paths[0].getAssetListRange(start: 0, end: count);
  }

  Future<PermissionState> getPermissionState() async {
    return await PhotoManager.getPermissionState(
      requestOption: const PermissionRequestOption(),
    );
  }
}
