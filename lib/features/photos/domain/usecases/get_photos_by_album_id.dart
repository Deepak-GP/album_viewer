import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/photo.dart';
import '../repositories/photo_repository.dart';

class GetPhotosByAlbumId
    implements UseCase<List<Photo>, GetPhotosByAlbumIdParams> {
  final PhotoRepository repository;

  GetPhotosByAlbumId(this.repository);

  @override
  Future<Either<Failure, List<Photo>>> call(
      GetPhotosByAlbumIdParams params) async {
    return await repository.getPhotosByAlbumId(params.albumId);
  }
}

class GetCachedPhotosByAlbumId
    implements UseCase<List<Photo>, GetPhotosByAlbumIdParams> {
  final PhotoRepository repository;

  GetCachedPhotosByAlbumId(this.repository);

  @override
  Future<Either<Failure, List<Photo>>> call(
      GetPhotosByAlbumIdParams params) async {
    return await repository.getCachedPhotosByAlbumId(params.albumId);
  }
}

class GetPhotosByAlbumIdParams extends Equatable {
  final int albumId;

  const GetPhotosByAlbumIdParams({required this.albumId});

  @override
  List<Object> get props => [albumId];
}
