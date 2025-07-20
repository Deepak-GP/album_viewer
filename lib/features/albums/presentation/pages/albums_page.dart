import 'package:flutter/material.dart';

import '../widgets/album_pagination_widget.dart';

class AlbumsPage extends StatelessWidget {
  const AlbumsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Album Viewer'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const AlbumPaginationWidget(),
    );
  }
}
