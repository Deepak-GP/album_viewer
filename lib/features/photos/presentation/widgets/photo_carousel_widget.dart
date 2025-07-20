import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/photo_bloc.dart';
import 'photo_item_widget.dart';

class PhotoCarouselWidget extends StatefulWidget {
  final int albumId;
  final PhotoBloc photoBloc;

  const PhotoCarouselWidget({
    super.key,
    required this.albumId,
    required this.photoBloc,
  });

  @override
  State<PhotoCarouselWidget> createState() => _PhotoCarouselWidgetState();
}

class _PhotoCarouselWidgetState extends State<PhotoCarouselWidget> {
  late PageController _pageController;
  static const int _infinitePages = 10000; // Large number for infinite effect
  static const int _centerPage = 5000; // Center page to start from

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _centerPage);
    widget.photoBloc.add(LoadPhotos(widget.albumId));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int _getPhotoIndex(int pageIndex) {
    final photos = _getCurrentPhotos();
    if (photos.isEmpty) return 0;

    // Use modulo to create infinite loop
    // This ensures that scrolling past the last photo shows the first photo again
    return pageIndex % photos.length;
  }

  List<dynamic> _getCurrentPhotos() {
    final state = widget.photoBloc.state;
    if (state is PhotoLoaded) {
      return state.photos;
    } else if (state is PhotoLoading && state.cachedPhotos.isNotEmpty) {
      return state.cachedPhotos;
    } else if (state is PhotoError && state.cachedPhotos.isNotEmpty) {
      return state.cachedPhotos;
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotoBloc, PhotoState>(
      bloc: widget.photoBloc,
      builder: (context, state) {
        if (state is PhotoLoading && _getCurrentPhotos().isEmpty) {
          return const SizedBox(
            height: 120,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is PhotoError && _getCurrentPhotos().isEmpty) {
          return const SizedBox(
            height: 120,
            child: Center(
              child: Icon(Icons.error, color: Colors.red),
            ),
          );
        }

        if (_getCurrentPhotos().isEmpty) {
          return const SizedBox(
            height: 120,
            child: Center(
              child: Text('No photos found'),
            ),
          );
        }

        return SizedBox(
          height: 120,
          child: PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            itemCount: _infinitePages,
            itemBuilder: (context, pageIndex) {
              final photoIndex = _getPhotoIndex(pageIndex);
              final photo = _getCurrentPhotos()[photoIndex];

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: PhotoItemWidget(photo: photo),
              );
            },
          ),
        );
      },
    );
  }
}
