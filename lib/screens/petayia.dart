import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class MapsYIA extends StatelessWidget {
  final List<String> images = [
    'assets/images/maps1.png',
    'assets/images/maps2.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Peta Lokasi Tenant YIA'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                _showFullScreenImage(context, 0);
              },
              child: Image.asset(
                'assets/images/maps1.png',
                width: 400,
                height: 400,
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: GestureDetector(
              onTap: () {
                _showFullScreenImage(context, 1);
              },
              child: Image.asset(
                'assets/images/maps2.png',
                width: 400,
                height: 400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFullScreenImage(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _FullScreenImageGallery(
          images: images,
          initialIndex: index,
        ),
      ),
    );
  }
}

class _FullScreenImageGallery extends StatelessWidget {
  final List<String> images;
  final int initialIndex;

  _FullScreenImageGallery({required this.images, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhotoViewGallery.builder(
        itemCount: images.length,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: AssetImage(images[index]),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
          );
        },
        scrollPhysics: BouncingScrollPhysics(),
        backgroundDecoration: BoxDecoration(
          color: Color.fromARGB(255, 16, 16, 16),
        ),
        pageController: PageController(initialPage: initialIndex),
      ),
    );
  }
}
