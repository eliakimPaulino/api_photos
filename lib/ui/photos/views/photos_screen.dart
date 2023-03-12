import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_photos_api/ui/photos/photos.dart';

import '../../../models/photo_model.dart';
import '../../../repositories/photos_repository.dart';

class PhotosScreen extends StatelessWidget {
  const PhotosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PhotosView();
  }
}

class PhotosView extends StatefulWidget {
  const PhotosView({super.key});

  @override
  State<PhotosView> createState() => _PhotosViewState();
}

class _PhotosViewState extends State<PhotosView> {
  String _query = 'programming';
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Photos'),
        ),
        body: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Search',
                fillColor: Colors.white,
                filled: true,
              ),
              onSubmitted: (val) {
                if (val.trim().isNotEmpty) {
                  setState(() {
                    _query = val.trim();
                  });
                }
              },
            ),
            Expanded(
              child: FutureBuilder<List<Photo>>(
                future: context
                    .read<PhotosRepository>()
                    .searchPhotos(query: _query),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final photos = snapshot.data ?? [];
                    debugPrint(photos.toString());
                    return GridView.builder(
                      padding: const EdgeInsets.all(20),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 15.0,
                        crossAxisSpacing: 15.0,
                        crossAxisCount: 2,
                        childAspectRatio: 0.5,
                      ),
                      itemCount: photos.length,
                      itemBuilder: (context, index) {
                        final photo = photos[index];
                        return PhotoCard(
                          photos: photos,
                          photo: photo,
                          index: index,
                        );
                      },
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
