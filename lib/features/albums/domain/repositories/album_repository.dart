import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/album.dart';

abstract class AlbumRepository {
  Future<Either<Failure, List<Album>>> getAlbumsWithPagination(
      {int limit = 10, int offset = 0});
  Future<Either<Failure, List<Album>>> getCachedAlbums();
  Future<Either<Failure, void>> cacheAlbums(List<Album> albums);
  Future<Either<Failure, void>> clearCache();
}
