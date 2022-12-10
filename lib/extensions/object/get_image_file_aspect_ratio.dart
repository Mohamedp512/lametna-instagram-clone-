import 'dart:io';
import 'package:instantgram/extensions/object/get_image_aspect_ratio.dart';
import 'package:instantgram/state/image_upload/type_def.dart';
import 'package:flutter/material.dart' as material show Image;

extension GetImageFileAspectRatio on FilePath {
  Future<double> getAspectRatio() {
    final file = File(this);
    final image = material.Image.file(file);
    return image.getAspectRatio();
  }
}
