import 'package:flutter/material.dart';

import '../../../photos/presentation/bloc/photo_bloc.dart';
import '../../../photos/presentation/widgets/photo_carousel_widget.dart';
import '../../domain/entities/album.dart';

class AlbumItemWidget extends StatelessWidget {
  final Album album;
  final int index;
  final PhotoBloc photoBloc;

  const AlbumItemWidget({
    super.key,
    required this.album,
    required this.index,
    required this.photoBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Album ${index + 1}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          PhotoCarouselWidget(
            albumId: album.id,
            photoBloc: photoBloc,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
