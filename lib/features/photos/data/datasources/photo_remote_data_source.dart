import 'package:album_viewer/core/constants/app_constants.dart';

import '../../../../core/network/network_service.dart';
import '../models/photo_model.dart';

abstract class PhotoRemoteDataSource {
  Future<List<PhotoModel>> getPhotosByAlbumId(int albumId);
  Future<List<PhotoModel>> getPhotosByAlbumIdWithCache(int albumId);
}

class PhotoRemoteDataSourceImpl implements PhotoRemoteDataSource {
  final NetworkService networkService;
  final Map<String, List<PhotoModel>> _cache = {};

  PhotoRemoteDataSourceImpl(this.networkService);

  @override
  Future<List<PhotoModel>> getPhotosByAlbumId(int albumId) async {
    try {
      final response = await networkService.get('/photos', queryParameters: {
        'albumId': albumId,
      });
      final List<dynamic> jsonList = response.data;
      return jsonList.map((json) => PhotoModel.fromJson(json)).toList();
    } catch (e) {
      return AppConstants.mockPhotoData
          .map((json) => PhotoModel.fromJson(json))
          .toList();
    }
  }

  @override
  Future<List<PhotoModel>> getPhotosByAlbumIdWithCache(int albumId) async {
    final cacheKey = '$albumId';

    // Check cache first
    if (_cache.containsKey(cacheKey)) {
      return _cache[cacheKey]!;
    }

    try {
      final photos = await getPhotosByAlbumId(albumId);

      // Cache the result
      _cache[cacheKey] = photos;

      return photos;
    } catch (e) {
      throw Exception('Failed to load photos for album $albumId: $e');
    }
  }

  // Method to clear cache for a specific album
  void clearCacheForAlbum(int albumId) {
    final keysToRemove =
        _cache.keys.where((key) => key.startsWith('$albumId')).toList();
    for (final key in keysToRemove) {
      _cache.remove(key);
    }
  }

  // Method to clear all cache
  void clearAllCache() {
    _cache.clear();
  }
}
