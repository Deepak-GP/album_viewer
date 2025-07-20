import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/photo.dart';
import '../../domain/repositories/photo_repository.dart';
import '../datasources/photo_local_data_source.dart';
import '../datasources/photo_remote_data_source.dart';
import '../models/photo_model.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  final PhotoRemoteDataSource remoteDataSource;
  final PhotoLocalDataSource localDataSource;

  PhotoRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Photo>>> getPhotosByAlbumId(int albumId) async {
    try {
      final photoModels =
          await remoteDataSource.getPhotosByAlbumIdWithCache(albumId);
      await localDataSource.cachePhotos(photoModels);
      return Right(photoModels);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Photo>>> getCachedPhotosByAlbumId(
      int albumId) async {
    try {
      final photoModels =
          await localDataSource.getCachedPhotosByAlbumId(albumId);
      return Right(photoModels);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> cachePhotos(List<Photo> photos) async {
    try {
      final photoModels =
          photos.map((photo) => PhotoModel.fromEntity(photo)).toList();
      await localDataSource.cachePhotos(photoModels);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> clearCacheForAlbum(int albumId) async {
    try {
      // Clear remote cache
      if (remoteDataSource is PhotoRemoteDataSourceImpl) {
        (remoteDataSource as PhotoRemoteDataSourceImpl)
            .clearCacheForAlbum(albumId);
      }

      // Clear local cache
      await localDataSource.clearCacheForAlbum(albumId);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
