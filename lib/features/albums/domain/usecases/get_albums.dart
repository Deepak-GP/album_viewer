import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/album.dart';
import '../repositories/album_repository.dart';

class GetAlbumsWithPagination
    implements UseCase<List<Album>, GetAlbumsWithPaginationParams> {
  final AlbumRepository repository;

  GetAlbumsWithPagination(this.repository);

  @override
  Future<Either<Failure, List<Album>>> call(
      GetAlbumsWithPaginationParams params) async {
    return await repository.getAlbumsWithPagination(
      limit: params.limit,
      offset: params.offset,
    );
  }
}

class GetCachedAlbums implements UseCase<List<Album>, NoParams> {
  final AlbumRepository repository;

  GetCachedAlbums(this.repository);

  @override
  Future<Either<Failure, List<Album>>> call(NoParams params) async {
    return await repository.getCachedAlbums();
  }
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAlbumsWithPaginationParams extends Equatable {
  final int limit;
  final int offset;

  const GetAlbumsWithPaginationParams({
    this.limit = 10,
    this.offset = 0,
  });

  @override
  List<Object> get props => [limit, offset];
}
