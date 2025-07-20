import 'package:hive/hive.dart';

import '../models/photo_model.dart';

abstract class PhotoLocalDataSource {
  Future<List<PhotoModel>> getCachedPhotosByAlbumId(int albumId);
  Future<void> cachePhotos(List<PhotoModel> photos);
  Future<void> clearCacheForAlbum(int albumId);
}

class PhotoLocalDataSourceImpl implements PhotoLocalDataSource {
  final Box photosBox;

  PhotoLocalDataSourceImpl(this.photosBox);

  @override
  Future<List<PhotoModel>> getCachedPhotosByAlbumId(int albumId) async {
    try {
      final List<dynamic> data = photosBox.values.toList();
      final List<PhotoModel> photos = data
          .map((item) => PhotoModel.fromJson(Map<String, dynamic>.from(item)))
          .toList();
      return photos.where((photo) => photo.albumId == albumId).toList();
    } catch (e) {
      throw Exception('Failed to get cached photos for album $albumId: $e');
    }
  }

  @override
  Future<void> cachePhotos(List<PhotoModel> photos) async {
    try {
      final List<Map<String, dynamic>> jsonData =
          photos.map((photo) => photo.toJson()).toList();
      await photosBox.addAll(jsonData);
    } catch (e) {
      throw Exception('Failed to cache photos: $e');
    }
  }

  @override
  Future<void> clearCacheForAlbum(int albumId) async {
    try {
      final List<dynamic> data = photosBox.values.toList();
      final List<PhotoModel> allPhotos = data
          .map((item) => PhotoModel.fromJson(Map<String, dynamic>.from(item)))
          .toList();

      // Remove photos for the specific album
      final photosToKeep =
          allPhotos.where((photo) => photo.albumId != albumId).toList();

      // Clear and re-add remaining photos
      await photosBox.clear();
      final List<Map<String, dynamic>> jsonData =
          photosToKeep.map((photo) => photo.toJson()).toList();
      await photosBox.addAll(jsonData);
    } catch (e) {
      throw Exception('Failed to clear cache for album $albumId: $e');
    }
  }
}
