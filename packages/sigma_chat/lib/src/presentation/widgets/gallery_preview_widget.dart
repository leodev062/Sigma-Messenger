import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:sigma_core/sigma_core.dart';

class GalleryPreviewWidget extends StatefulWidget {
  final Function(AssetEntity) onAssetSelected;

  const GalleryPreviewWidget({super.key, required this.onAssetSelected});

  @override
  State<GalleryPreviewWidget> createState() => _GalleryPreviewWidgetState();
}

class _GalleryPreviewWidgetState extends State<GalleryPreviewWidget> {
  final List<AssetEntity> _assets = [];
  bool _isLoading = true;
  bool _hasPermission = false;

  @override
  void initState() {
    super.initState();
    _loadAssets();
  }

  Future<void> _loadAssets() async {
    final service = locator<MediaPreviewService>();
    final ps = await service.requestPermissions();
    
    if (mounted) {
      setState(() {
        _hasPermission = ps;
        _isLoading = !ps;
      });
    }

    if (ps) {
      final assets = await service.fetchRecentMedia();
      if (mounted) {
        setState(() {
          _assets.clear();
          _assets.addAll(assets);
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasPermission && !_isLoading) {
      return Container(
        height: 120,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("Acesso à galeria negado."),
            TextButton(
              onPressed: _loadAssets,
              child: const Text("Conceder Permissão"),
            ),
          ],
        ),
      );
    }

    if (_isLoading) {
      return const SizedBox(
        height: 120,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: _assets.length,
        itemBuilder: (context, index) {
          final asset = _assets[index];
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: GestureDetector(
              onTap: () => widget.onAssetSelected(asset),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AssetEntityImage(
                  asset,
                  isOriginal: false,
                  thumbnailSize: const ThumbnailSize.square(200),
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
