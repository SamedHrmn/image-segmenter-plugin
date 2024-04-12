import 'dart:typed_data';

import 'image_segmenter_plugin_platform_interface.dart';

class ImageSegmenterPlugin {
  void setInputImage(Uint8List bytes) {
    ImageSegmenterPluginPlatform.instance.setInputImage(bytes);
  }

  Future<Uint8List?> segmentImage() {
    return ImageSegmenterPluginPlatform.instance.segmentImage();
  }

  Future<void> init() {
    return ImageSegmenterPluginPlatform.instance.init();
  }

  void clear() {
    return ImageSegmenterPluginPlatform.instance.clear();
  }
}
