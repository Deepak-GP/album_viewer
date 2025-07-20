import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/widgets/shimmer_loading_widget.dart';
import '../../../../features/photos/presentation/bloc/photo_bloc.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/album.dart';
import '../controllers/album_pagination_controller.dart';
import 'album_item_widget.dart';

class AlbumPaginationWidget extends StatefulWidget {
  const AlbumPaginationWidget({super.key});

  @override
  State<AlbumPaginationWidget> createState() => _AlbumPaginationWidgetState();
}

class _AlbumPaginationWidgetState extends State<AlbumPaginationWidget> {
  late final AlbumPaginationController _albumPaginationController;
  final Map<int, PhotoBloc> _photoBlocs = {};
  final Set<int> _loadedAlbums = {};

  @override
  void initState() {
    super.initState();
    _albumPaginationController = sl<AlbumPaginationController>();
  }

  @override
  void dispose() {
    _albumPaginationController.pagingController.dispose();
    for (final bloc in _photoBlocs.values) {
      bloc.close();
    }
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _albumPaginationController.refresh();
        for (final entry in _photoBlocs.entries) {
          final albumId = entry.key;
          final bloc = entry.value;
          bloc.add(RefreshPhotos(albumId));
        }
        _loadedAlbums.clear();
      },
      child: PagedListView<int, Album>(
        pagingController: _albumPaginationController.pagingController,
        builderDelegate: PagedChildBuilderDelegate<Album>(
          itemBuilder: (context, album, index) {
            // Load photos for this album if not already loaded
            if (!_loadedAlbums.contains(album.id)) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _loadPhotosForAlbum(album.id);
              });
            }

            return AlbumItemWidget(
              album: album,
              index: index,
              photoBloc: _getPhotoBloc(album.id),
            );
          },
          firstPageProgressIndicatorBuilder: (context) =>
              const ShimmerLoadingWidget(),
          newPageProgressIndicatorBuilder: (context) => const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          firstPageErrorIndicatorBuilder: (context) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, color: Colors.red, size: 48),
                const SizedBox(height: 16),
                Text(
                  'Error loading albums',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () =>
                      _albumPaginationController.retryLastFailedRequest(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
          newPageErrorIndicatorBuilder: (context) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, color: Colors.red, size: 32),
                const SizedBox(height: 8),
                Text(
                  'Error loading more albums',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () =>
                      _albumPaginationController.retryLastFailedRequest(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
          noItemsFoundIndicatorBuilder: (context) => const Center(
            child: Text('No albums found'),
          ),
        ),
      ),
    );
  }
}
