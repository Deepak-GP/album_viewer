import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/album.dart';
import '../../domain/repositories/album_repository.dart';
import '../datasources/album_local_data_source.dart';
import '../datasources/album_remote_data_source.dart';
import '../models/album_model.dart';

class AlbumRepositoryImpl implements AlbumRepository {
  final AlbumRemoteDataSource remoteDataSource;
  final AlbumLocalDataSource localDataSource;

  AlbumRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Album>>> getAlbumsWithPagination(
      {int limit = 10, int offset = 0}) async {
    try {
      final albumModels = await remoteDataSource.getAlbumsWithCache(
          limit: limit, offset: offset);
      await localDataSource.cacheAlbums(albumModels);
      return Right(albumModels);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Album>>> getCachedAlbums() async {
    try {
      final albumModels = await localDataSource.getCachedAlbums();
      return Right(albumModels);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> cacheAlbums(List<Album> albums) async {
    try {
      final albumModels =
          albums.map((album) => AlbumModel.fromEntity(album)).toList();
      await localDataSource.cacheAlbums(albumModels);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> clearCache() async {
    try {
      // Clear remote cache
      if (remoteDataSource is AlbumRemoteDataSourceImpl) {
        (remoteDataSource as AlbumRemoteDataSourceImpl).clearCache();
      }

      // Clear local cache
      await localDataSource.clearCache();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
