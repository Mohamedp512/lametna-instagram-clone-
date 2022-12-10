import 'dart:async';

import 'package:flutter/material.dart' as material
    show Image, ImageConfiguration, ImageStreamListener;

extension GetImageAspectRatio on material.Image {
  Future<double> getAspectRatio() async {
    final compeleter = Completer<double>();
    image.resolve(const material.ImageConfiguration()).addListener(
      material.ImageStreamListener(
        (imageInfo, synchronousCall) {
          final aspectRatio = imageInfo.image.width / imageInfo.image.height;
          imageInfo.image.dispose();
          compeleter.complete(aspectRatio);
        },
      ),
    );
    return compeleter.future;
  }
}