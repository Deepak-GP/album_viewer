import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/network/network_service.dart';
import 'features/albums/data/datasources/album_local_data_source.dart';
import 'features/albums/data/datasources/album_remote_data_source.dart';
import 'features/albums/data/repositories/album_repository_impl.dart';
import 'features/albums/domain/repositories/album_repository.dart';
import 'features/albums/domain/usecases/get_albums.dart';
import 'features/albums/presentation/controllers/album_pagination_controller.dart';
import 'features/photos/data/datasources/photo_local_data_source.dart';
import 'features/photos/data/datasources/photo_remote_data_source.dart';
import 'features/photos/data/repositories/photo_repository_impl.dart';
import 'features/photos/domain/repositories/photo_repository.dart';
import 'features/photos/domain/usecases/get_photos_by_album_id.dart';
import 'features/photos/presentation/bloc/photo_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Initialize Hive
  await Hive.initFlutter();

  // Open Hive boxes (using dynamic for now since adapters aren't generated)
  final albumsBox = await Hive.openBox('albums_box');
  final photosBox = await Hive.openBox('photos_box');

  // Core
  sl.registerLazySingleton<NetworkService>(() => NetworkServiceImpl());

  // Data sources
  sl.registerLazySingleton<AlbumRemoteDataSource>(
    () => AlbumRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<AlbumLocalDataSource>(
    () => AlbumLocalDataSourceImpl(albumsBox),
  );
  sl.registerLazySingleton<PhotoRemoteDataSource>(
    () => PhotoRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<PhotoLocalDataSource>(
    () => PhotoLocalDataSourceImpl(photosBox),
  );

  // Repositories
  sl.registerLazySingleton<AlbumRepository>(
    () => AlbumRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<PhotoRepository>(
    () => PhotoRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetAlbumsWithPagination(sl()));
  sl.registerLazySingleton(() => GetCachedAlbums(sl()));
  sl.registerLazySingleton(() => GetPhotosByAlbumId(sl()));
  sl.registerLazySingleton(() => GetCachedPhotosByAlbumId(sl()));

  // Controllers
  sl.registerFactory(() => AlbumPaginationController(
        getAlbumsWithPagination: sl(),
        getCachedAlbums: sl(),
      ));

  // BLoCs
  sl.registerFactoryParam<PhotoBloc, int, void>(
    (albumId, _) => PhotoBloc(
      getPhotosByAlbumId: sl(),
      getCachedPhotosByAlbumId: sl(),
    ),
  );
}
