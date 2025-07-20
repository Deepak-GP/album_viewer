import 'package:album_viewer/core/constants/app_constants.dart';

import '../../../../core/network/network_service.dart';
import '../models/album_model.dart';

abstract class AlbumRemoteDataSource {
  Future<List<AlbumModel>> getAlbums({int limit = 10, int offset = 0});
  Future<List<AlbumModel>> getAlbumsWithCache({int limit = 10, int offset = 0});
}

class AlbumRemoteDataSourceImpl implements AlbumRemoteDataSource {
  final NetworkService networkService;
  final Map<String, List<AlbumModel>> _cache = {};

  AlbumRemoteDataSourceImpl(this.networkService);

  @override
  Future<List<AlbumModel>> getAlbums({int limit = 10, int offset = 0}) async {
    try {
      final response = await networkService.get('/albums', queryParameters: {
        '_limit': limit,
        '_start': offset,
      });
      final List<dynamic> jsonList = response.data;
      final albums = jsonList.map((json) => AlbumModel.fromJson(json)).toList();
      return albums;
    } catch (e) {
      return AppConstants.mockAlbumData
          .map((json) => AlbumModel.fromJson(json))
          .toList();
    }
  }

  @override
  Future<List<AlbumModel>> getAlbumsWithCache(
      {int limit = 10, int offset = 0}) async {
    final cacheKey = 'albums_${limit}_$offset';

    // Check cache first
    if (_cache.containsKey(cacheKey)) {
      return _cache[cacheKey]!;
    }

    try {
      final albums = await getAlbums(limit: limit, offset: offset);

      // Cache the result
      _cache[cacheKey] = albums;

      return albums;
    } catch (e) {
      throw Exception('Failed to load albums: $e');
    }
  }

  // Method to clear cache
  void clearCache() {
    _cache.clear();
  }
}
