import 'package:flutter/material.dart';

import '../../../../core/widgets/shimmer_loading_widget.dart';
import '../../../../features/photos/presentation/bloc/photo_bloc.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/album.dart';
import '../../domain/usecases/get_albums.dart';
import 'album_item_widget.dart';

class AlbumInfiniteScrollWidget extends StatefulWidget {
  const AlbumInfiniteScrollWidget({super.key});

  @override
  State<AlbumInfiniteScrollWidget> createState() =>
      _AlbumInfiniteScrollWidgetState();
}

class _AlbumInfiniteScrollWidgetState extends State<AlbumInfiniteScrollWidget> {
  late final GetAlbumsWithPagination _getAlbumsWithPagination;
  late final GetCachedAlbums _getCachedAlbums;
  final Map<int, PhotoBloc> _photoBlocs = {};
  final Set<int> _loadedAlbums = {};
  late PageController _pageController;
  static const int _infinitePages = 10000; // Large number for infinite effect
  static const int _centerPage = 5000; // Center page to start from
  List<Album> _allAlbums = [];

  @override
  void initState() {
    super.initState();
    _getAlbumsWithPagination = sl<GetAlbumsWithPagination>();
    _getCachedAlbums = sl<GetCachedAlbums>();
    _pageController =
        PageController(initialPage: _centerPage, viewportFraction: 0.28);
    _loadInitialAlbums();
  }

  @override
  void dispose() {
    _pageController.dispose();
    for (final bloc in _photoBlocs.values) {
      bloc.close();
    }
    super.dispose();
  }

  Future<void> _loadInitialAlbums() async {
    // Load cached albums first
    final cachedResult = await _getCachedAlbums(NoParams());
    cachedResult.fold(
      (failure) {
        // No cached data, continue with API call
      },
      (cachedAlbums) {
        if (cachedAlbums.isNotEmpty) {
          setState(() {
            _allAlbums = cachedAlbums;
          });
        }
      },
    );

    // Load fresh data from API
    final result = await _getAlbumsWithPagination(
      const GetAlbumsWithPaginationParams(
          limit: 100, offset: 0), // Load more albums for infinite scroll
    );

    result.fold(
      (failure) {
        // Keep cached data if available
      },
      (albums) {
        setState(() {
          _allAlbums = albums;
        });
      },
    );
  }

  void _loadPhotosForAlbum(int albumId) {
    if (_loadedAlbums.contains(albumId)) {
      return;
    }

    final photoBloc = _getPhotoBloc(albumId);
    photoBloc.add(LoadPhotos(albumId));

    setState(() {
      _loadedAlbums.add(albumId);
    });
  }

  PhotoBloc _getPhotoBloc(int albumId) {
    if (!_photoBlocs.containsKey(albumId)) {
      _photoBlocs[albumId] = sl<PhotoBloc>(param1: albumId);
    }
    return _photoBlocs[albumId]!;
  }

  int _getAlbumIndex(int pageIndex) {
    if (_allAlbums.isEmpty) return 0;

    // Use modulo to create infinite loop
    // This ensures that scrolling past the last album shows the first album again
    return pageIndex % _allAlbums.length;
  }

  @override
  Widget build(BuildContext context) {
    if (_allAlbums.isEmpty) {
      return const Center(
        child: ShimmerLoadingWidget(),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await _loadInitialAlbums();
        for (final entry in _photoBlocs.entries) {
          final albumId = entry.key;
          final bloc = entry.value;
          bloc.add(RefreshPhotos(albumId));
        }
        _loadedAlbums.clear();
      },
      child: PageView.builder(
        controller: _pageController,
        pageSnapping: false,
        scrollDirection: Axis.vertical,
        itemCount: _infinitePages,
        itemBuilder: (context, pageIndex) {
          final albumIndex = _getAlbumIndex(pageIndex);
          final album = _allAlbums[albumIndex];

          // Load photos for this album if not already loaded
          if (!_loadedAlbums.contains(album.id)) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _loadPhotosForAlbum(album.id);
            });
          }

          return AlbumItemWidget(
            album: album,
            index: albumIndex,
            photoBloc: _getPhotoBloc(album.id),
          );
        },
      ),
    );
  }
}
