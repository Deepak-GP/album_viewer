import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/photo.dart';
import '../../domain/usecases/get_photos_by_album_id.dart';

// Events
abstract class PhotoEvent extends Equatable {
  const PhotoEvent();

  @override
  List<Object?> get props => [];
}

class LoadPhotos extends PhotoEvent {
  final int albumId;

  const LoadPhotos(this.albumId);

  @override
  List<Object?> get props => [albumId];
}

class RefreshPhotos extends PhotoEvent {
  final int albumId;

  const RefreshPhotos(this.albumId);

  @override
  List<Object?> get props => [albumId];
}

// States
abstract class PhotoState extends Equatable {
  const PhotoState();

  @override
  List<Object?> get props => [];
}

class PhotoInitial extends PhotoState {}

class PhotoLoading extends PhotoState {
  final List<Photo> cachedPhotos;

  const PhotoLoading({this.cachedPhotos = const []});

  @override
  List<Object?> get props => [cachedPhotos];
}

class PhotoLoaded extends PhotoState {
  final List<Photo> photos;
  final bool isInitialized;

  const PhotoLoaded({
    required this.photos,
    this.isInitialized = true,
  });

  @override
  List<Object?> get props => [photos, isInitialized];
}

class PhotoError extends PhotoState {
  final String message;
  final List<Photo> cachedPhotos;

  const PhotoError({
    required this.message,
    this.cachedPhotos = const [],
  });

  @override
  List<Object?> get props => [message, cachedPhotos];
}

// BLoC
class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final GetPhotosByAlbumId getPhotosByAlbumId;
  final GetCachedPhotosByAlbumId getCachedPhotosByAlbumId;

  PhotoBloc({
    required this.getPhotosByAlbumId,
    required this.getCachedPhotosByAlbumId,
  }) : super(PhotoInitial()) {
    on<LoadPhotos>(_onLoadPhotos);
    on<RefreshPhotos>(_onRefreshPhotos);
  }

  Future<void> _onLoadPhotos(LoadPhotos event, Emitter<PhotoState> emit) async {
    // Check if already loading
    if (state is PhotoLoading) return;

    emit(const PhotoLoading());

    try {
      // First try to load cached data
      final cachedResult = await getCachedPhotosByAlbumId(
        GetPhotosByAlbumIdParams(albumId: event.albumId),
      );

      List<Photo> cachedPhotos = [];
      cachedResult.fold(
        (failure) {
          // No cached data, continue with API call
        },
        (photos) {
          cachedPhotos = photos;
          if (photos.isNotEmpty) {
            emit(PhotoLoaded(photos: photos, isInitialized: true));
          }
        },
      );

      // Fetch fresh data from API
      final result = await getPhotosByAlbumId(
        GetPhotosByAlbumIdParams(albumId: event.albumId),
      );

      result.fold(
        (failure) {
          if (cachedPhotos.isEmpty) {
            emit(PhotoError(message: failure.toString()));
          }
        },
        (photos) {
          emit(PhotoLoaded(photos: photos, isInitialized: true));
        },
      );
    } catch (e) {
      if (state is PhotoLoaded) {
        // Keep showing loaded photos if we have them
        return;
      }
      emit(PhotoError(message: e.toString()));
    }
  }

  Future<void> _onRefreshPhotos(
      RefreshPhotos event, Emitter<PhotoState> emit) async {
    emit(const PhotoLoading());

    try {
      // Fetch fresh data from API
      final result = await getPhotosByAlbumId(
        GetPhotosByAlbumIdParams(albumId: event.albumId),
      );

      result.fold(
        (failure) {
          emit(PhotoError(message: failure.toString()));
        },
        (photos) {
          emit(PhotoLoaded(photos: photos, isInitialized: true));
        },
      );
    } catch (e) {
      emit(PhotoError(message: e.toString()));
    }
  }
}
