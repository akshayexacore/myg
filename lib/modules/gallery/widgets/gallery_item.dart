import 'package:flutter/widgets.dart';

class GalleryItem {
  GalleryItem({
    required this.id,
    required this.resource,
    this.isFile = false,
  });

  final String id;
  final String resource;
  final bool isFile;
}