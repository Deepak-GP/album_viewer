import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/photo.dart';

abstract class PhotoRepository {
  Future<Either<Failure, List<Photo>>> getPhotosByAlbumId(int albumId);
  Future<Either<Failure, List<Photo>>> getCachedPhotosByAlbumId(int albumId);
  Future<Either<Failure, void>> cachePhotos(List<Photo> photos);
  Future<Either<Failure, void>> clearCacheForAlbum(int albumId);
}
