import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:travel_claim/utils/api_base_helper.dart';

class CustomSslImageDispaly extends StatelessWidget {
  const CustomSslImageDispaly({
    super.key,
    required this.url,
    this.height,
    this.width,
  });

  final String url;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchImage(url),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            width: height ?? 24.0,
            height: height ?? 24.0,
            child: SizedBox(),
          );
        } else if (snapshot.hasError) {
          return Icon(Icons.error);
        } else {
          return Center(
            child: Image.memory(
              snapshot.data as Uint8List,
              height: height ?? 24.0,
              width: width ?? width,
            ),
          );
        }
      },
    );
  }
}
