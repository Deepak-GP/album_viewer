import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../domain/entities/album.dart';
import '../../domain/usecases/get_albums.dart';

class AlbumPaginationController {
  final GetAlbumsWithPagination getAlbumsWithPagination;
  final GetCachedAlbums getCachedAlbums;
  static const int _pageSize = 10;

  late final PagingController<int, Album> pagingController;

  AlbumPaginationController({
    required this.getAlbumsWithPagination,
    required this.getCachedAlbums,
  }) {
    pagingController = PagingController(firstPageKey: 0);
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      // If this is the first page, try to load cached data first
      if (pageKey == 0) {
        final cachedResult = await getCachedAlbums(NoParams());
        cachedResult.fold(
          (failure) {
            // No cached data, continue with API call
          },
          (cachedAlbums) {
            if (cachedAlbums.isNotEmpty) {
              // Show cached data immediately
              final isLastPage = cachedAlbums.length < _pageSize;
              final nextPageKey = isLastPage ? null : cachedAlbums.length;
              pagingController.value = PagingState(
                nextPageKey: nextPageKey,
                error: null,
                itemList: cachedAlbums,
              );
              return;
            }
          },
        );
      }

      // Fetch fresh data from API
      final result = await getAlbumsWithPagination(
        GetAlbumsWithPaginationParams(
          limit: _pageSize,
          offset: pageKey,
        ),
      );

      result.fold(
        (failure) async {
          // If API fails and we have cached data on first page, keep showing cached data
          if (pageKey == 0) {
            final cachedResult = await getCachedAlbums(NoParams());
            cachedResult.fold(
              (cacheFailure) {
                // No cached data, emit error
                pagingController.error = failure;
              },
              (cachedAlbums) {
                if (cachedAlbums.isNotEmpty) {
                  // Don't emit error, keep showing cached data
                  return;
                }
                pagingController.error = failure;
              },
            );
          } else {
            pagingController.error = failure;
          }
        },
        (albums) {
          final isLastPage = albums.length < _pageSize;
          final nextPageKey = isLastPage ? null : pageKey + albums.length;

          if (pageKey == 0) {
            // First page - replace all items
            pagingController.appendPage(albums, nextPageKey);
          } else {
            // Subsequent pages - append items
            pagingController.appendPage(albums, nextPageKey);
          }
        },
      );
    } catch (error) {
      pagingController.error = error;
    }
  }

  void refresh() {
    pagingController.refresh();
  }

  void retryLastFailedRequest() {
    pagingController.retryLastFailedRequest();
  }
}
