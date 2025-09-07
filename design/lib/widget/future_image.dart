import 'dart:typed_data';

import 'package:flutter/material.dart';

class FutureImage extends StatelessWidget {
  final Future<Uint8List?> imageFuture;
  final double? width;
  final double? height;
  final BoxFit fit;

  const FutureImage({
    super.key,
    required this.imageFuture,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: imageFuture, // 인자로 받은 Future를 사용
      builder: (context, snapshot) {
        // 1. 로딩 중일 때
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            width: width,
            height: height,
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        // 2. 에러가 발생했을 때
        if (snapshot.hasError) {
          return SizedBox(
            width: width,
            height: height,
            child: const Center(child: Icon(Icons.error)),
          );
        }

        // 3. 데이터가 있고 (null이 아닐 때)
        if (snapshot.hasData && snapshot.data != null) {
          return Image.memory(
            snapshot.data!,
            width: width,
            height: height,
            fit: fit,
          );
        }

        // 4. 데이터가 없을 때 (Future가 null을 반환)
        return SizedBox(
          width: width,
          height: height,
          child: const Center(child: Icon(Icons.image_not_supported)),
        );
      },
    );
  }
}
