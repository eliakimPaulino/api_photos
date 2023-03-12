import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/photo_model.dart';

class PhotoViewerScreen extends StatefulWidget {
  const PhotoViewerScreen(
      {super.key, required this.photos, required this.currentIndex});

  final List<Photo> photos;
  final int currentIndex;

  @override
  State<PhotoViewerScreen> createState() => _PhotoViewerScreenState();
}

class _PhotoViewerScreenState extends State<PhotoViewerScreen> {
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.photos.length,
        itemBuilder: (context, index) {
          final photo = widget.photos[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: Key('${index}_${photo.id}'),
                child: CachedNetworkImage(
                  height: 300,
                  width: double.infinity,
                  imageUrl: photo.url,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => const Center(
                    child: Icon(Icons.error, color: Colors.red, size: 50),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '(${index + 1}/${widget.photos.length})',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      photo.description,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.grey[100],
                          backgroundImage: CachedNetworkImageProvider(
                            photo.user.profileImageUrl,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        GestureDetector(
                          onTap: () async {
                            final uri = Uri.parse(photo.user.profileUrl);
                            if (await canLaunchUrl(uri)) launchUrl(uri);
                          },
                          child: Text(
                            photo.user.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
