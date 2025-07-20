import 'package:hive/hive.dart';

import '../models/album_model.dart';

abstract class AlbumLocalDataSource {
  Future<List<AlbumModel>> getCachedAlbums();
  Future<void> cacheAlbums(List<AlbumModel> albums);
  Future<void> clearCache();
}

class AlbumLocalDataSourceImpl implements AlbumLocalDataSource {
  final Box albumsBox;

  AlbumLocalDataSourceImpl(this.albumsBox);

  @override
  Future<List<AlbumModel>> getCachedAlbums() async {
    try {
      final List<dynamic> data = albumsBox.values.toList();
      return data
          .map((item) => AlbumModel.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    } catch (e) {
      throw Exception('Failed to get cached albums: $e');
    }
  }

  @override
  Future<void> cacheAlbums(List<AlbumModel> albums) async {
    try {
      final List<Map<String, dynamic>> jsonData =
          albums.map((album) => album.toJson()).toList();
      await albumsBox.addAll(jsonData);
    } catch (e) {
      throw Exception('Failed to cache albums: $e');
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      await albumsBox.clear();
    } catch (e) {
      throw Exception('Failed to clear album cache: $e');
    }
  }
}
